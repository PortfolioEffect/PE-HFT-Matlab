% Position covariance
%
% 
% Computes daily covariance of position returns.
% 
% Usage
% 
% position_covariance(portfolio, symbol1, symbol2)
% 
%
% portfolio
%       Portfolio object created using portfolio_create( ) function
% symbol1
%       First symbol name
% symbol2
%       Second symbol name
% 
% Return Value
% 
% Vector of covariances between two positions. 
%
% Description
% https://www.portfolioeffect.com/docs/glossary/measures/relative-risk-measures/covariance
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
% util_plot2d(position_covariance(portfolioExample,'GOOG','AAPL'),'Position Covariance GOOG and AAPL')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(position_covariance(portfolioExample,'AAPL','C'),'Position Covariance AAPL and C')
function [position_covariance] = position_covariance(portfolio,symbol1,symbol2)
if strcmp(symbol1,symbol2)
    result=position_metric(portfolio,'metric','POSITION_VARIANCE','position',symbol1);
else
result=position_metric(portfolio,'metric','POSITION_COVARIANCE','positionA',symbol1,'positionB',symbol2);
end
     position_covariance=result;
end
