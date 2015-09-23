% Position Return Autocovariance
%
% 
% Computes autocovariance of position returns for a certain time lag.
% 
% Usage
% 
% position_returnAutocovariance(portfolio,symbol,lag)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% symbol
%        unique identifier of the instrument
%
% lag
%        Time lag (in seconds) between observations in question.
%
% Return Value
% 
% numeric vector of position returns.
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
% util_plot2d(position_returnAutocovariance(portfolioExample,'GOOG',10),'Position Return Autocovariance GOOG')
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(position_returnAutocovariance(portfolioExample,'AAPL',10),'Position Return Autocovariance AAPL')
function [position_return] = position_returnAutocovariance(portfolio,symbol,lag)
     position_return=position_metric(portfolio,'metric','POSITION_RETURN_AUTOCOVARIANCE','position',symbol,'lag',num2str(lag));
end