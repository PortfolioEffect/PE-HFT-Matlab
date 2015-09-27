% Portfolio Expected Upside Return
%
% 
% Computes portfolio daily cumulative expected return above a certain threshold.
% 
% Usage
% 
% portfolio_expectedUpsideReturn(portfolio,thresholdReturn)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% thresholdReturn
%        Return value to be used as a cut-off point
%
% Return Value
% 
% Numeric vector of portfolio expected upside returns.
%
% Description
% https://www.portfolioeffect.com/docs/glossary/measures/absolute-return-measures/expected-upside-return
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
% util_plot2d(portfolio_expectedUpsideReturn(portfolioExample,0.05),'Portfolio Expected Upside Return ')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(portfolio_expectedUpsideReturn(portfolioExample,0.05),'Portfolio Expected Upside Return ')
function [portfolio_expectedUpsideReturn] = portfolio_expectedUpsideReturn(portfolio,thresholdReturn)
     portfolio_expectedUpsideReturn=position_metric(portfolio,'metric','PORTFOLIO_EXPECTED_UPSIDE_THRESHOLD_RETURN','thresholdReturn',num2str(thresholdReturn));
end
