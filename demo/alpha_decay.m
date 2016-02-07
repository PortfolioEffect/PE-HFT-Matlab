%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1 - Compute optimal weights using Treynor-Black model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create test portfolio
timeStart =  '2014-10-02 09:30:00';
timeEnd = '2014-10-03 16:00:00';

portfolio=portfolio_create('index','SPY', 'fromTime',timeStart, 'toTime',timeEnd);
portfolio_settings(portfolio,'portfolioMetricsMode','price','jumpsModel','all','resultsNAFilter','false');
portfolio_addPosition(portfolio,'AAPL',100);
portfolio_addPosition(portfolio,'GOOG',100);
portfolio_addPosition(portfolio,'SPY',100);

figure('position',[800 200 1000 700])
util_plot2d(position_jensensAlpha(portfolio,'AAPL'),'AAPL','Title','Jensens Alpha')+util_line2d(position_jensensAlpha(portfolio,'GOOG'), 'GOOG')

% compute optimal weights according to the Treynor-Black model
paren = @(x, varargin) x(varargin{:});
alpha = [paren(position_jensensAlpha(portfolio,'AAPL'),:,2),paren(position_jensensAlpha(portfolio,'GOOG'),:,2)];
timeUTC =paren(position_jensensAlpha(portfolio,'AAPL'),:,1);
variance= [paren(position_variance(portfolio,'AAPL'),:,2),paren(position_variance(portfolio,'GOOG'),:,2)];

treynorBlack=alpha./variance;
optimWeigth=bsxfun(@rdivide,treynorBlack,sum(abs(treynorBlack),2));

% plot optimal position weights
util_plot2d([timeUTC, optimWeigth(:,1)],'AAPL','Title','Optimal Weight')+util_line2d([timeUTC, optimWeigth(:,2)], 'GOOG')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2- Compare two portfolios of equal value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\nDownloading required binaries. Please, wait...\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
meanGOOG=mean(paren(position_price(portfolio,'GOOG'),:,2))
meanAAPL=mean(paren(position_price(portfolio,'AAPL'),:,2))

% compute optimal position quatities for a portfolio of given size
portfolioCash=10000000;
optimPosition=portfolioCash*optimWeigth./[paren(position_price(portfolio,'AAPL'),:,2),paren(position_price(portfolio,'GOOG'),:,2)];

portfolioSimple=portfolio_create('index','SPY', 'fromTime',timeStart, 'toTime',timeEnd);
portfolio_settings(portfolioSimple,'portfolioMetricsMode','price','jumpsModel','all');
portfolio_addPosition(portfolioSimple, 'AAPL', bsxfun(@rdivide,(portfolioCash/2),(paren(position_price(portfolio,'AAPL'),:,2))), 'time', timeUTC)
portfolio_addPosition(portfolioSimple, 'GOOG',bsxfun(@rdivide,(portfolioCash/2),(paren(position_price(portfolio,'GOOG'),:,2))),  'time', timeUTC)

portfolioOptimal=portfolio_create('index','SPY', 'fromTime',timeStart, 'toTime',timeEnd);
portfolio_settings(portfolioOptimal,'portfolioMetricsMode','price','jumpsModel','all');
portfolio_addPosition(portfolioOptimal,'AAPL', optimPosition(:,1), 'time',timeUTC);
portfolio_addPosition(portfolioOptimal,'GOOG', optimPosition(:,2), 'time',timeUTC);

portfolioSimpleAlpha = portfolio_jensensAlpha(portfolioSimple);
portfolioOptimAlpha = portfolio_jensensAlpha(portfolioOptimal);

util_plot2d(portfolioSimpleAlpha,'Simple portfolio','Title', 'Jensens Alpha')+util_line2d(portfolioOptimAlpha, 'Optimal portfolio')+...
util_line2d([timeUTC, mean(portfolioSimpleAlpha(:,2))*ones(length(timeUTC),1)],'Avg. of simple')+...
util_line2d([timeUTC, mean(portfolioOptimAlpha(:,2))*ones(length(timeUTC),1)], 'Avg. of optimal')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 3 - Use ARMA-class model to estimate alpha-decay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
meanSimple=zeros(21, 1);
forecastErrorsSimple=zeros(21, 1);
model=arima(1,1,0);
x=0:0.1:2;

for  j = 1:21
   x1=x(j); 
  x2=1-x1;

  position_setQuantity(portfolioSimple, 'AAPL', (portfolioCash*x1)/meanAAPL)
  position_setQuantity(portfolioSimple, 'GOOG', (portfolioCash*x2)/meanGOOG)
  
  alpha=portfolio_jensensAlpha(portfolioSimple);
  meanSimple(j,1)=mean(alpha(:,2));
  
  forecastErrors=zeros(100,1);
    for i =1:100
    fit=estimate(model,alpha((3200+i*400):(3400+i*400-1),2),'Display','off');
    forecastErrors(i,1)=abs( forecast(fit,1,'Y0',alpha((3200+i*400):(3400+i*400-1),2)) - alpha(3400+i*400,2))*100/mean(abs(alpha(3400+i*400,2)));       %Calculation of forecast errors
    end
    forecastErrorsSimple(j,1)=mean(forecastErrors);
end

x = -2:0.25:2;
[X,Y] = meshgrid(x);
Z = X.*exp(-X.^2-Y.^2);
contour3(X,Y,Z,30)

 for i =1:100
    fit=estimate(model,portfolioOptimAlpha((3200+i*400):(3400+i*400-1),2),'Display','off');
    forecastErrors(i,1)=abs( forecast(fit,1,'Y0',portfolioOptimAlpha((3200+i*400):(3400+i*400-1),2)) - portfolioOptimAlpha(3400+i*400,2))*100/mean(abs(portfolioOptimAlpha(3400+i*400,2)));       %Calculation of forecast errors
    end
    forecastErrorsOptim=mean(forecastErrors);

plot(forecastErrorsSimple,meanSimple,'o');
set(gca,'Color',[213/255 228/255 235/255]);
set(gcf,'Color',[213/255 228/255 235/255]);
xlim([-0.1 max(forecastErrorsSimple)]);
xlabel('Forecast Error(%)')
ylabel('Alpha mean')
legend('Portfolio Simple Alpha');
hold all
plot(forecastErrorsOptim,mean(portfolioOptimAlpha(:,2)),'o');
legend('Portfolio Optimal Alpha');
leg=get(legend(gca),'String');
legend([leg 'Portfolio Optimal Alpha']);
hold off
