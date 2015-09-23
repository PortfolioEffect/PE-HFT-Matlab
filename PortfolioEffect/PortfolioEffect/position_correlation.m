% Position correlation
%
% 
% Computes daily correlation of position returns.
% 
% Usage
% 
% position_correlation(portfolio, symbol1, symbol2)
% 
%
% portfolio
%       Portfolio object created using portfolio_create( ) function
% symbol1
%       First symbol name
% symbol2
%       Second symbol name
% 
% 
% Return Value
% 
% Vector of correlationss between two positions. 
%
% Description
% https://www.portfolioeffect.com/docs/glossary/measures/relative-risk-measures/correlation
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
% util_plot2d(position_correlation(portfolioExample,'GOOG','AAPL'),'Position Correlation GOOG and AAPL')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(position_correlation(portfolioExample,'AAPL','C'),'Position Correlation AAPL and C')
function [position_correlation] = position_correlation(portfolio,symbol1,symbol2)
% if strcmp(symbol1,symbol2)
%     position_correlation={-1,1};
% else
result=position_metric(portfolio,'metric','POSITION_CORRELATION','positionA',symbol1,'positionB',symbol2);
     position_correlation=result;
%      end
end
