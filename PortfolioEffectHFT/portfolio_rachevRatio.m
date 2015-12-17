% Portfolio Rachev Ratio
%
% 
% Computes daily Rachev ratio of a portfolio at given confidence intervals.
% Computation employs distribution skewness and kurtosis to account for non-normality.
% 
% Usage
% 
% portfolio_rachevRatio(portfolio,confidenceIntervalAlpha,confidenceIntervalBeta)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% confidenceIntervalAlpha
%        Confidence interval (in decimals) to be used as a cut-off point in the numerator
%
% confidenceIntervalBeta
%        Confidence interval (in decimals) to be used as a cut-off point in the denominator
%
% Return Value
% 
% Numeric vector of portfolio Rachev ratio values.
%
% Description
% https://www.portfolioeffect.com/docs/glossary/measures/tail-risk-measures/rachev-ratio
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
% util_plot2d(portfolio_rachevRatio(portfolioExample,0.95,0.95),'Portfolio Rachev Ratio ')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(portfolio_rachevRatio(portfolioExample,0.95,0.95),'Portfolio Rachev Ratio ')
function [portfolio_rachevRatio] = portfolio_rachevRatio(portfolio,confidenceIntervalAlpha,confidenceIntervalBeta)
     portfolio_rachevRatio=position_metric(portfolio,'metric','PORTFOLIO_RACHEV_RATIO','confidenceIntervalAlpha',num2str(confidenceIntervalAlpha),'confidenceIntervalBeta',num2str(confidenceIntervalBeta));
end
