%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 1 - Define trading signals and construct portfolios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
symbol = 'GOOG';
dateStart = '2014-10-10 09:30:00';
dateEnd = '2014-10-10 16:00:00';
portfolio=portfolio_create('fromTime',dateStart,'toTime',dateEnd);

portfolio_addPosition(portfolio,symbol,1);

goog=position_price(portfolio,symbol);
printTime=goog(:,1);
googPrice=goog(:,2);
n=length(googPrice);


MA=150;
googHFMA=tsmovavg(googPrice','S',MA);
googHFMA(1:(MA-1))=rdivide(cumsum(googPrice(1:(MA-1)))',1:(MA-1));
MA=800;
googLFMA=tsmovavg(googPrice','S',MA);
googLFMA(1:(MA-1))=rdivide(cumsum(googPrice(1:(MA-1)))',1:(MA-1));

highFrequencyStrategy=zeros(length(googPrice),1);
highFrequencyStrategy(googPrice>googHFMA')=100;
lowFrequencyStrategy=zeros(length(googPrice),1);
lowFrequencyStrategy(googPrice>googLFMA')=100;


figure('position',[800 200 1000 700])

y = [length(highFrequencyStrategy([false;diff(highFrequencyStrategy)~=0])') length(lowFrequencyStrategy([false;diff(lowFrequencyStrategy)~=0])')];
bar(y)

set(gca,'xticklabel',{'High Frequency Strategy' 'Low Frequency Strategy'})
util_plotTheme('Title','Number of transaction')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2 - Holding intervals visualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
highFrequencyPortfolioWithTransactionCosts=portfolio_create('fromTime',dateStart,'toTime',dateEnd);
portfolio_settings(highFrequencyPortfolioWithTransactionCosts,'txnCostPerShare',0.02);
portfolio_addPosition(highFrequencyPortfolioWithTransactionCosts,symbol,highFrequencyStrategy,'time',printTime);

highFrequencyPortfolioWithoutTransactionCosts=portfolio_create('fromTime',dateStart,'toTime',dateEnd);
portfolio_addPosition(highFrequencyPortfolioWithoutTransactionCosts,symbol,highFrequencyStrategy,'time',printTime);

lowFrequencyPortfolioWithTransactionCosts=portfolio_create('fromTime',dateStart,'toTime',dateEnd);
portfolio_settings(lowFrequencyPortfolioWithTransactionCosts,'txnCostPerShare',0.02);
portfolio_addPosition(lowFrequencyPortfolioWithTransactionCosts,symbol,lowFrequencyStrategy,'time',printTime);

lowFrequencyPortfolioWithoutTransactionCosts=portfolio_create('fromTime',dateStart,'toTime',dateEnd);
portfolio_addPosition(lowFrequencyPortfolioWithoutTransactionCosts,symbol,lowFrequencyStrategy,'time',printTime);

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
varianceHF=portfolio_variance(highFrequencyPortfolioWithoutTransactionCosts);
varianceLF=portfolio_variance(highFrequencyPortfolioWithoutTransactionCosts);
util_plot2d(portfolio_variance(highFrequencyPortfolioWithTransactionCosts),'HF With Transaction Costs','Title','Variance, daily')+...
    util_line2d(varianceHF+[zeros(length(varianceHF),1)  ones(length(varianceHF),1)/500000],'HF Without Transaction Costs')+...
    util_line2d(portfolio_variance(lowFrequencyPortfolioWithTransactionCosts),'LF With Transaction Costs')+...
    util_line2d(varianceLF+[zeros(length(varianceLF),1)  ones(length(varianceLF),1)/500000],'LF Without Transaction Costs')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 4 - Trading strategy expected return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

util_plot2d(portfolio_expectedReturn(highFrequencyPortfolioWithTransactionCosts),'HF With Transaction Costs','Title','Expected Return, daily')+...
    util_line2d(portfolio_expectedReturn(highFrequencyPortfolioWithoutTransactionCosts),'HF Without Transaction Costs')+...
    util_line2d(portfolio_expectedReturn(lowFrequencyPortfolioWithTransactionCosts),'LF With Transaction Costs')+...
    util_line2d(portfolio_expectedReturn(lowFrequencyPortfolioWithoutTransactionCosts),'LF Without Transaction Costs')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 5 - Trading strategy Transactional Costs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
txnLF=portfolio_txnCosts(lowFrequencyPortfolioWithoutTransactionCosts);
util_plot2d(portfolio_txnCosts(highFrequencyPortfolioWithTransactionCosts),'HF With Transaction Costs','Title','Transactional Costs')+...
    util_line2d(portfolio_txnCosts(highFrequencyPortfolioWithoutTransactionCosts),'HF Without Transaction Costs')+...
    util_line2d(portfolio_txnCosts(lowFrequencyPortfolioWithTransactionCosts),'LF With Transaction Costs')+...
    util_line2d(txnLF+[zeros(length(txnLF),1)  ones(length(txnLF),1)*10],'LF Without Transaction Costs')

