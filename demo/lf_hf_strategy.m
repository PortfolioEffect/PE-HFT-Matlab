%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1 - Define trading signals and construct portfolios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
symbol = 'GOOG';
dateStart = '2014-10-13 09:30:00';
dateEnd = '2014-10-14 16:00:00';
highFrequencyPortfolio=portfolio_create('fromTime',dateStart,'toTime',dateEnd);
lowFrequencyportfolio=portfolio_create('fromTime',dateStart,'toTime',dateEnd);

portfolio_addPosition(highFrequencyPortfolio,symbol,1);

goog=position_price(highFrequencyPortfolio,symbol);
printTime=goog(:,1);
googPrice=goog(:,2);


MA=150;
googHFMA=tsmovavg(googPrice','S',MA);
googHFMA(1:(MA-1))=rdivide(cumsum(googPrice(1:(MA-1)))',1:(MA-1));
MA=800;
googLFMA=tsmovavg(googPrice','S',MA);
googLFMA(1:(MA-1))=rdivide(cumsum(googPrice(1:(MA-1)))',1:(MA-1));
 
highFrequencyStrategy=zeros(length(googPrice),1);
highFrequencyStrategy(googPrice>=googHFMA')=100;
lowFrequencyStrategy=zeros(length(googPrice),1);
lowFrequencyStrategy(googPrice>=googLFMA')=100;

portfolio_addPosition(highFrequencyPortfolio,symbol,highFrequencyStrategy,'time',printTime);
portfolio_addPosition(lowFrequencyportfolio,symbol,lowFrequencyStrategy,'time',printTime);

highFrequencyPortfolio
lowFrequencyportfolio
plot(lowFrequencyportfolio)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2 - Holding intervals visualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close
figure('position',[800 200 1000 700])
subplot(2,1,1);
util_plot2d([printTime,highFrequencyStrategy],'HF Quantity','Title','High Frequency Portfolio Strategy')
subplot(2,1,2);
util_plot2d([printTime,lowFrequencyStrategy],'LF Quantity','Title','Low Frequency Portfolio Strategy')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 3 - Trading strategy variance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close
figure('position',[800 200 1000 700])
util_plot2d(portfolio_variance(highFrequencyPortfolio),'HF Portfolio','Title','Variance, daily')+...
util_line2d(portfolio_variance(lowFrequencyportfolio),'LF Portfolio')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 4 - Trading strategy Value-at-Risk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(portfolio_VaR(highFrequencyPortfolio,0.95),'HF Portfolio','Title','Value at Risk in %, daily (95% c.i.)')+...
util_line2d(portfolio_VaR(lowFrequencyportfolio,0.95),'LF Portfolio')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 5 - Trading strategy Sharpe ratio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(portfolio_sharpeRatio(highFrequencyPortfolio),'HF Portfolio','Title','Sharpe Ratio, daily')+...
util_line2d(portfolio_sharpeRatio(lowFrequencyportfolio),'LF Portfolio')
