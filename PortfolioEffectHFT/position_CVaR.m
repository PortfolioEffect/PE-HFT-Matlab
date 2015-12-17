% Position Conditional Value-at-Risk
%
% 
% Computes position conditional Value-at-Risk (Expectaed Tail Loss) at a given confidence interval.
% Computation employs distribution's skewness and kurtosis to account for non-normality.
% 
% Usage
% 
% position_CVaR(portfolio,symbol,confidenceInterval)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% symbol
%        unique identifier of the instrument
%
% confidenceInterval
%        Confidence interval (in decimals) to be used as a cut-off point
%
% Return Value
% 
% numeric vector of position CVaR values.
%
% Description
% https://www.portfolioeffect.com/docs/glossary/measures/tail-risk-measures/cvar
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
% util_plot2d(position_CVaR(portfolioExample,'GOOG',0.95),'Position Conditional Value-at-Risk GOOG')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(position_CVaR(portfolioExample,'AAPL',0.95),'Position Conditional Value-at-Risk AAPL')
function [position_CVaR] = position_CVaR(portfolio,symbol,confidenceInterval)
     position_CVaR=position_metric(portfolio,'metric','POSITION_CVAR','position',symbol,'confidenceInterval',num2str(confidenceInterval));
end
