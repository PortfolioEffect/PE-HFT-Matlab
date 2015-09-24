% Position Expected Upside Return
%
% 
% Computes position daily cumulative expected return above a certain threshold.
% 
% Usage
% 
% position_expectedUpsideReturn(portfolio,symbol,thresholdReturn)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% symbol
%        unique identifier of the instrument
%
% thresholdReturn
%        Return value to be used as a cut-off point
%
% Return Value
% 
% Numeric vector of position expected upside returns.
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
% util_plot2d(position_expectedUpsideReturn(portfolioExample,'GOOG',0.05),'Position Expected Upside Return GOOG')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(position_expectedUpsideReturn(portfolioExample,'AAPL',0.05),'Position Expected Upside Return AAPL')
function [position_expectedUpsideReturn] = position_expectedUpsideReturn(portfolio,symbol,thresholdReturn)
     position_expectedUpsideReturn=position_metric(portfolio,'metric','POSITION_EXPECTED_UPSIDE_THRESHOLD_RETURN','position',symbol,'thresholdReturn',num2str(thresholdReturn));
end
