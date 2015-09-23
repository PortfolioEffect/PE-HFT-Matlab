% Portfolio Hurst Exponent
%
% 
% Computes portfolio Hurst exponent as a weighted sum of the Hurst exponents of its position returns.
% 
% Usage
% 
% portfolio_hurstExponent(portfolio)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
%
% Return Value
% 
% numeric vector of portfolio Hurst exponent values.
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
% util_plot2d(portfolio_hurstExponent(portfolioExample),'Portfolio Hurst Exponent')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(portfolio_hurstExponent(portfolioExample),'Portfolio Hurst Exponent')
function [portfolio_hurstExponent] = portfolio_hurstExponent(portfolio)
     portfolio_hurstExponent=position_metric(portfolio,'metric','PORTFOLIO_HURST_EXPONENT');
end
