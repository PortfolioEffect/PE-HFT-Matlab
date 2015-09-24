%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1 - Construct buy-and-hold portfolio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

paren = @(x, varargin) x(varargin{:});

portfolio=portfolio_create('index','SPY', 'fromTime', '2014-11-19 09:30:00', 'toTime', '2014-11-19 16:00:00');
portfolio_settings(portfolio,'portfolioMetricsMode','price','resultsSamplingInterval','1m');
portfolio_addPosition(portfolio,'AAPL',1000);
portfolio_addPosition(portfolio,'GOOG',1000);
portfolio_addPosition(portfolio,'SPY',1000);

plot(portfolio);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2 -  Run portfolio optimization with one constraint
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

optimizer=optimization_goal(portfolio,'Variance','minimize');
optimizer=optimization_constraint_portfolioValue(optimizer,10^9);
optimizer=optimization_constraint_expectedReturn(optimizer,'>=',0);
optimPortfolioOneConstraints=optimization_run(optimizer);

close
plot(optimPortfolioOneConstraints)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 3 -  Run portfolio optimization with two constraints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

optimizer=optimization_constraint_sumOfAbsWeights(optimizer,'>=',0.5,cellstr(['AAPL';'GOOG']));
optimPortfolioTwoConstraints=optimization_run(optimizer);

close
plot(optimPortfolioTwoConstraints)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 4 - Compute optimal portfolio expected return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close
figure('position',[800 200 1000 700])
util_plot2d(portfolio_expectedReturn(optimPortfolioOneConstraints),'Optimal Portfolio, with Constraints:Return>=0.02','Title','Portfolio Expected Return')+...
util_line2d(portfolio_expectedReturn(optimPortfolioTwoConstraints),'Optimal Portfolio, with Constraints:Return>=0.02, Sum of Abs Weights AAPL and GOOG >=0.5')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 5 - Compute optimal portfolio variance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(portfolio_variance(optimPortfolioOneConstraints),'Optimal Portfolio, with Constraints:Return>=0.02','Title','Portfolio Variance')+...
util_line2d(portfolio_variance(optimPortfolioTwoConstraints),'Optimal Portfolio, with Constraints:Return>=0.02, Sum of Abs Weights AAPL and GOOG >=0.5')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 6 - Compute optimal portfolio sum of absolute weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sumOfAbsWeightsOptimPortfolio=abs(paren(position_weight(optimPortfolioOneConstraints,'AAPL'),:,2))+abs(paren(position_weight(optimPortfolioOneConstraints,'GOOG'),:,2));
sumOfAbsWeightsOptimPortfolioTwoConstraints=abs(paren(position_weight(optimPortfolioTwoConstraints,'AAPL'),:,2))+abs(paren(position_weight(optimPortfolioTwoConstraints,'GOOG'),:,2));
timeUTC = paren(position_weight(optimPortfolioOneConstraints,'AAPL'),:,1);

util_plot2d([timeUTC,sumOfAbsWeightsOptimPortfolio],'Optimal Portfolio, with Constraints:Return>=0.02','Title','Portfolio Sum Of Abs Weigth AAPL and GOOG')+...
util_line2d([timeUTC,sumOfAbsWeightsOptimPortfolioTwoConstraints],'Optimal Portfolio, with Constraints:Return>=0.02, Sum of Abs Weights AAPL and GOOG >=0.5')
