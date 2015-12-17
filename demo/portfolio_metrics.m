%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1 - Construct buy-and-hold portfolio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create empty portfolio
dateStart = '2014-10-01 09:30:00';
dateEnd = '2014-10-02 16:00:00';

portfolio=portfolio_create('fromTime',dateStart,'toTime',dateEnd);

% Add position AAPL and GOOG to portfolio
portfolio_addPosition(portfolio,'AAPL',100);
portfolio_addPosition(portfolio,'GOOG',200);

% Display general information about the portfolio at the end of the period
display(portfolio);
plot(portfolio)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2 - Compute portfolio value
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close
figure('position',[800 200 1000 700])

util_plot2d(portfolio_value(portfolio),'Portfolio value, in USD','Title','Portfolio value, in USD')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 3 - Compute portfolio & position expected return (daily)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(position_expectedReturn(portfolio,'AAPL'),'AAPL','Title','Expected Return, daily')+...
util_line2d(position_expectedReturn(portfolio,'GOOG'),'GOOG')+...
util_line2d(portfolio_expectedReturn(portfolio),'Portfolio')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 4 - Compute portfolio & position variance (daily)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(position_variance(portfolio,'AAPL'),'AAPL','Title','Variance, daily')+...
util_line2d(position_variance(portfolio,'GOOG'),'GOOG')+...
util_line2d(portfolio_variance(portfolio),'Portfolio')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 5 -  Compute portfolio & position Value-at-Risk (daily, 95% c.i.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(position_VaR(portfolio,'AAPL',0.95),'AAPL','Title','Value at Risk in %, daily (95% c.i.)')+...
util_line2d(position_VaR(portfolio,'GOOG',0.95),'GOOG')+...
util_line2d(portfolio_VaR(portfolio,0.95),'Portfolio')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 6 - Compute portfolio & position Sharpe Ratio (daily)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(position_sharpeRatio(portfolio,'AAPL'),'AAPL','Title','Sharpe Ratio, daily')+...
util_line2d(position_sharpeRatio(portfolio,'GOOG'),'GOOG')+...
util_line2d(portfolio_sharpeRatio(portfolio),'Portfolio')

