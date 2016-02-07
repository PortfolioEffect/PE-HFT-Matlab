% Position N-th Cumulant
%
% 
% Computes N-th cumulant of position return distribution.
% 
% Usage
% 
% position_cumulant(portfolio,symbol,order)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% symbol
%        unique identifier of the instrument
%
% order
%        cumulant order (3 or 4).
%
% Return Value
% 
% numeric vector of position return distribution cumulant values.
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
% util_plot2d(position_cumulant(portfolioExample,'GOOG',3),'Position 3-th Cumulant GOOG')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(position_cumulant(portfolioExample,'AAPL',4),'Position 4-th Cumulant AAPL')
function [position_cumulant] = position_cumulant(portfolio,symbol,order)
if strcmp(order,'all')
    order = [3 4];
end
res=[];
for i = order
result=position_metric(portfolio,'metric',strcat('POSITION_CUMULANT',num2str(i)),'position',symbol);
        if isempty(res)
            res=result;
        else
            res=[res(ismember(res(:,1), result(:,1)),:),result(ismember(result(:,1), res(:,1)),2)];
        end
end
     position_cumulant=res;
end
