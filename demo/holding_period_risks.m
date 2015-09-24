%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1 - Define trading signals and construct portfolios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
portfolio=portfolio_create('fromTime','2014-10-10 09:30:00','toTime','2014-10-10 16:00:00');
portfolio_addPosition(portfolio,'GOOG',1);

goog=position_price(portfolio,'GOOG');
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
highFrequencyStrategy(11700:23400)=0;
lowFrequencyStrategy=zeros(length(googPrice),1);
lowFrequencyStrategy(googPrice>=googLFMA')=100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2 - Holding Times
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('position',[800 200 1000 700])
subplot(1,2,1);
highFrequencyStrategyPlot=[sum(highFrequencyStrategy>50),sum(highFrequencyStrategy<=50)];
h=pie(highFrequencyStrategyPlot);
th = findobj(h, 'Type', 'text');
set(th, 'FontSize', 16);
A=legend(h(1:2:end),'Has position','No position');
set(A, 'FontSize', 14);
title(sprintf('Intraday holding period for\n high-frequency strategy'), 'FontSize', 18);

subplot(1,2,2);
lowFrequencyStrategyPlot=[sum(lowFrequencyStrategy>50),sum(lowFrequencyStrategy<=50)];
h=pie(lowFrequencyStrategyPlot);
th = findobj(h, 'Type', 'text');
set(th, 'FontSize', 16);
A=legend(h(1:2:end),'Has position','No position');
set(A, 'FontSize', 14);
title(sprintf('Intraday holding period for\n low-frequency strategy'), 'FontSize',18);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 3 - Holding intervals visualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

highFrequencyPortfolioHoldOnly=portfolio_create('fromTime','2014-10-10 09:30:00','toTime','2014-10-10 16:00:00');
portfolio_settings(highFrequencyPortfolioHoldOnly,'holdingPeriodsOnly','true');
portfolio_addPosition(highFrequencyPortfolioHoldOnly,'GOOG',highFrequencyStrategy,'time',printTime);
highFrequencyPortfolioHoldOnly

highFrequencyPortfolioAllDay=portfolio_create('fromTime','2014-10-10 09:30:00','toTime','2014-10-10 16:00:00');
portfolio_settings(highFrequencyPortfolioAllDay,'holdingPeriodsOnly','false');
portfolio_addPosition(highFrequencyPortfolioAllDay,'GOOG',highFrequencyStrategy,'time',printTime);
highFrequencyPortfolioAllDay

lowFrequencyPortfolioHoldOnly=portfolio_create('fromTime','2014-10-10 09:30:00','toTime','2014-10-10 16:00:00');
portfolio_settings(lowFrequencyPortfolioHoldOnly,'holdingPeriodsOnly','true');
portfolio_addPosition(lowFrequencyPortfolioHoldOnly,'GOOG',lowFrequencyStrategy,'time',printTime);
lowFrequencyPortfolioHoldOnly

lowFrequencyPortfolioAllDay=portfolio_create('fromTime','2014-10-10 09:30:00','toTime','2014-10-10 16:00:00');
portfolio_settings(lowFrequencyPortfolioAllDay,'holdingPeriodsOnly','false');
portfolio_addPosition(lowFrequencyPortfolioAllDay,'GOOG',lowFrequencyStrategy,'time',printTime);
lowFrequencyPortfolioAllDay


close
figure('position',[800 200 1000 700])
subplot(2,1,1);
util_plot2d([printTime,highFrequencyStrategy],'HF Quantity','Title','High Frequency Portfolio Strategy')
subplot(2,1,2);
util_plot2d([printTime,lowFrequencyStrategy],'LF Quantity','Title','Low Frequency Portfolio Strategy')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 4 - Trading strategy variance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close
figure('position',[800 200 1000 700])
util_plot2d(portfolio_variance(highFrequencyPortfolioHoldOnly),'HF HoldOnly','Title','Variance, daily')+...
    util_line2d(portfolio_variance(highFrequencyPortfolioAllDay),'HF AllDay')+...
    util_line2d(portfolio_variance(lowFrequencyPortfolioHoldOnly),'LF HoldOnly')+...
    util_line2d(portfolio_variance(lowFrequencyPortfolioAllDay),'LF AllDay')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 5 - Trading strategy Value-at-Risk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(portfolio_VaR(highFrequencyPortfolioHoldOnly,0.05),'HF HoldOnly','Title','VaR, daily')+...
    util_line2d(portfolio_VaR(highFrequencyPortfolioAllDay,0.05),'HF AllDay')+...
    util_line2d(portfolio_VaR(lowFrequencyPortfolioHoldOnly,0.05),'LF HoldOnly')+...
    util_line2d(portfolio_VaR(lowFrequencyPortfolioAllDay,0.05),'LF AllDay')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 6 -  Trading strategy expected return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(portfolio_expectedReturn(highFrequencyPortfolioHoldOnly),'HF HoldOnly','Title','Return, daily')+...
    util_line2d(portfolio_expectedReturn(highFrequencyPortfolioAllDay),'HF AllDay')+...
    util_line2d(portfolio_expectedReturn(lowFrequencyPortfolioHoldOnly),'LF HoldOnly')+...
    util_line2d(portfolio_expectedReturn(lowFrequencyPortfolioAllDay),'LF AllDay')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 7 - Trading strategy Sharpe ratio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(portfolio_sharpeRatio(highFrequencyPortfolioHoldOnly),'HF HoldOnly','Title','Sharpe Ratio, daily')+...
    util_line2d(portfolio_sharpeRatio(highFrequencyPortfolioAllDay),'HF AllDay')+...
    util_line2d(portfolio_sharpeRatio(lowFrequencyPortfolioHoldOnly),'LF HoldOnly')+...
    util_line2d(portfolio_sharpeRatio(lowFrequencyPortfolioAllDay),'LF AllDay')
