%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1 - Construct portfolio for optimization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
portfolio=portfolio_create('index','SPY', 'fromTime', '2014-04-13 9:30:01', 'toTime', '2014-04-16 16:00:00');
portfolio_settings(portfolio,'portfolioMetricsMode','price','windowLength', '360m');
portfolio_addPosition(portfolio,'GOOG',1);
portfolio_addPosition(portfolio,'AAPL',1);
portfolio_addPosition(portfolio,'C',1);

plot(portfolio)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2 - Compute theoretical efficient frontier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

portfolio_settings(portfolio,'portfolioMetricsMode','price','windowLength', '360m','resultsSamplingInterval','last');


VarianceLintner=null(1);
ExpectedReturnLintner=null(1);

for x = 0:0.005:0.015
        optimizer=optimization_goal(portfolio,'Variance','minimize');
        optimizer=optimization_constraint_portfolioValue(optimizer,10^9);
        optimizer=optimization_constraint_expectedReturn(optimizer,'=',x);
        optimPortfolio=optimization_run(optimizer);
        temp1=portfolio_variance(optimPortfolio);
        temp2=portfolio_expectedReturn(optimPortfolio);
        VarianceLintner=[VarianceLintner,temp1(2)];
        ExpectedReturnLintner=[ExpectedReturnLintner,temp2(2)];
end

y1=min(ExpectedReturnLintner):(max(ExpectedReturnLintner))/100:max(ExpectedReturnLintner);
x1=spline(ExpectedReturnLintner,VarianceLintner,y1);

close
figure('position',[800 200 1000 700])
plot(x1,y1,'LineSmoothing','on','Color',[0 74/255 97/255],'LineWidth',1.5);
set(gca,'Color',[213/255 228/255 235/255]);
set(gcf,'Color',[213/255 228/255 235/255]);
xlabel('Variance');
ylabel('Expected Return');
grid on
title('Efficient Frontier','FontSize',15,'FontWeight','bold');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 3 - Compute efficient frontiers of realistic portfolios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Variance6000Lintner=null(1);
ExpectedReturn6000Lintner=null(1);

for x =  0:0.004:0.016
  optimizer=optimization_goal(portfolio,'Variance','minimize');
  optimizer=optimization_constraint_portfolioValue(optimizer,6000);
  optimizer=optimization_constraint_expectedReturn(optimizer,'=',x);
  optimPortfolio=optimization_run(optimizer);
  temp1=portfolio_variance(optimPortfolio);
  temp2=portfolio_expectedReturn(optimPortfolio);
  Variance6000Lintner=[Variance6000Lintner,temp1(2)];
  ExpectedReturn6000Lintner=[ExpectedReturn6000Lintner,temp2(2)];
end

Variance20000Lintner=null(1);
ExpectedReturn20000Lintner=null(1);

for x = 0:0.004:0.016
  optimizer=optimization_goal(portfolio,'Variance','minimize');
  optimizer=optimization_constraint_portfolioValue(optimizer,20000);
  optimizer=optimization_constraint_expectedReturn(optimizer,'=',x);
  optimPortfolio=optimization_run(optimizer);
  temp1=portfolio_variance(optimPortfolio);
  temp2=portfolio_expectedReturn(optimPortfolio);
  Variance20000Lintner=[Variance20000Lintner,temp1(2)];
  ExpectedReturn20000Lintner=[ExpectedReturn20000Lintner,temp2(2)];
end

plot(x1,y1,Variance20000Lintner,ExpectedReturn20000Lintner,Variance6000Lintner,ExpectedReturn6000Lintner,'LineSmoothing','on','LineWidth',1.5);
set(gca,'Color',[213/255 228/255 235/255]);
set(gcf,'Color',[213/255 228/255 235/255]);
xlabel('Variance');
ylabel('Expected Return');
grid on
title('Efficient Frontier of Theoretical/$2000/$6000  portfolio','FontSize',15,'FontWeight','bold');
legend('Theoretical Portfolio','$20000 Portfolio','$6000 Portfolio');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 4 - Compare Markowitz and Lintner efficient frontiers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

portfolio_settings(portfolio,'portfolioMetricsMode','price','windowLength', '360m','resultsSamplingInterval','last','shortSalesMode', 'markowitz')

VarianceMarkowitz=null(1);
ExpectedReturnMarkowitz=null(1);

for x =  0:0.005:0.015
  optimizer=optimization_goal(portfolio,'Variance','minimize');
  optimizer=optimization_constraint_portfolioValue(optimizer,10^9);
  optimizer=optimization_constraint_expectedReturn(optimizer,'=',x);
  optimPortfolio=optimization_run(optimizer);
  temp1=portfolio_variance(optimPortfolio);
  temp2=portfolio_expectedReturn(optimPortfolio);
  VarianceMarkowitz=[VarianceMarkowitz,temp1(2)];
  ExpectedReturnMarkowitz=[ExpectedReturnMarkowitz,temp2(2)];
end

y2=min(ExpectedReturnMarkowitz):(max(ExpectedReturnMarkowitz))/100:max(ExpectedReturnMarkowitz);
x2=spline(ExpectedReturnMarkowitz,VarianceMarkowitz,y2);

plot(x1,y1,x2,y2,'LineSmoothing','on','LineWidth',1.5);
set(gca,'Color',[213/255 228/255 235/255]);
set(gcf,'Color',[213/255 228/255 235/255]);
xlabel('Variance');
ylabel('Expected Return');
grid on
title('Markowitz and Lintner Efficient Frontier','FontSize',15,'FontWeight','bold');
legend('Lintner','Markowitz');
