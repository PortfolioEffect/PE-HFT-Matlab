% Portfolio Modified Sharpe Ratio
%
% 
% Computes daily Modified Sharpe Ratio of a portfolio at a given confidence interval.
% Computation employs distribution's skewness and kurtosis to account for non-normality.
% 
% Usage
% 
% portfolio_modifiedSharpeRatio(portfolio,confidenceInterval)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% confidenceInterval
%        Confidence interval (in decimals) to be used as a cut-off point
%
% Return Value
% 
% numeric vector of portfolio modified Sharpe Ratio values.
%
% Description
% https://www.portfolioeffect.com/docs/glossary/measures/tail-risk-measures/modified-sharpe-ratio.php
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
% util_plot2d(portfolio_modifiedSharpeRatio(portfolioExample,0.95),'Portfolio Modified Sharpe Ratio ')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(portfolio_modifiedSharpeRatio(portfolioExample,0.95),'Portfolio Modified Sharpe Ratio ')
function [portfolio_modifiedSharpeRatio] = portfolio_modifiedSharpeRatio(portfolio,confidenceInterval)
     portfolio_modifiedSharpeRatio=position_metric(portfolio,'metric','PORTFOLIO_SHARPE_RATIO_MOD','confidenceInterval',num2str(confidenceInterval));
end
