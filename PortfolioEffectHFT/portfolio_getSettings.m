% Get Portfolio Settings
%
% 
% Method returns active list of settings of a given portfolio.
% 
% Usage
% 
% portfolio_getSettings(portfolio)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% Return Value
% 
% List with portfolio settings.
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
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_settings(portfolioExample,'portfolioMetricsMode','price','windowLength','3600s');
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% portfolio_getSettings(portfolio)
function [ output_args ] = portfolio_getSettings( portfolio )
output_args=struct('portfolioMetricsMode',char(portfolio.java.getParam('portfolioMetricsMode')),...
'windowLength',char(portfolio.java.getParam('windowLength')),...
'holdingPeriodsOnly',char(portfolio.java.getParam('isHoldingPeriodEnabled')),...
'shortSalesMode',char(portfolio.java.getParam('shortSalesMode')),...
'jumpsModel',char(portfolio.java.getParam('jumpsModel')),...
'noiseModel',char(portfolio.java.getParam('isNoiseModelEnabled')),...
'fractalPriceModel',char(portfolio.java.getParam('isFractalPriceModelEnabled')),...
'factorModel',char(portfolio.java.getParam('factorModel')),...
'resultsSamplingInterval',char(portfolio.java.getParam('samplingInterval')),...
'inputSamplingInterval',char(portfolio.java.getParam('priceSamplingInterval')),...
'timeScale',char(portfolio.java.getParam('timeScale')),...
'driftTerm',char(portfolio.java.getParam('isDriftEnabled')),...
'txnCostPerShare',char(portfolio.java.getParam('txnCostPerShare')),...
'txnCostFixed',char(portfolio.java.getParam('txnCostFixed')),...
'densityModel',char(portfolio.java.getParam('densityApproxModel')));
end
