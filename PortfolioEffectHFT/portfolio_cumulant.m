% Portfolio N-th Cumulant
%
% 
% Computes N-th cumulant of portfolio return distribution.
% 
% Usage
% 
% portfolio_cumulant(portfolio, order)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% order
%        moment order (3 or 4).
%
% Return Value
% 
% numeric vector of portfolio return distribution cumulant values.
% 
% Note
%
% PortfolioEffect - Matlab Interface to Quant API
% 
% Copyright (C) 2010 - 2015 Snowfall Systems, Inc.
%
%
% Examples
% 
% data_goog=importdata('data_goog.mat'); 
% data_aapl=importdata('data_aapl.mat');  
% data_spy=importdata('data_spy.mat'); 
% portfolioExample=portfolio_create('priceDataIx',data_spy); 
% portfolio_addPosition(portfolioExample,'GOOG',100,'priceData',data_goog);
% portfolio_addPosition(portfolioExample,'AAPL',300,'priceData',data_aapl);
% portfolio_addPosition(portfolioExample,'SPY',150,'priceData',data_spy);
% portfolio_settings(portfolioExample,'portfolioMetricsMode','price','windowLength','3600s');
% util_plot2d(portfolio_cumulant(portfolioExample,3),' Portfolio 3-th Cumulant')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(portfolio_cumulant(portfolioExample,'all'),' Portfolio 4-th Cumulant')
function [portfolio_cumulant] = portfolio_cumulant(portfolio,order)
if strcmp(order,'all')
    order = [3 4];
end
res=[];
for i = order
result=position_metric(portfolio,'metric',strcat('PORTFOLIO_CUMULANT',num2str(i)));
        if isempty(res)
            res=result;
        else
            res=[res(ismember(res(:,1), result(:,1)),:),result(ismember(result(:,1), res(:,1)),2)];
        end
end
     portfolio_cumulant=res;

end
