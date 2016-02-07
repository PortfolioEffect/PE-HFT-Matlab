% Portfolio N-th Order Central Moment
%
% 
% Computes N-th order central moment of portfolio return distribution.
% 
% Usage
% 
% portfolio_moment(portfolio, order)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% order
%       moment order (from 1 to 4)
%
% Return Value
% 
% numeric vector of portfolio return moment values.
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
% util_plot2d(portfolio_moment(portfolioExample,3),'Portfolio 3-th Order Central Moment')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(portfolio_moment(portfolioExample,4),'Portfolio 4-th Order Central Moment')
function [portfolio_moment] = portfolio_moment(portfolio,order)
if strcmp(order,'all')
    order = [3 4];
end
res=[];
for i = order
result=position_metric(portfolio,'metric',strcat('PORTFOLIO_MOMENT',num2str(i)));
        if isempty(res)
            res=result;
        else
            res=[res(ismember(res(:,1), result(:,1)),:),result(ismember(result(:,1), res(:,1)),2)];
        end
end
     portfolio_moment=res;

end
