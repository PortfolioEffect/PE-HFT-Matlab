% POSIX Time To Date
%
% Converts timestamps in milliseconds to corresponding date strings.
% 
% 
% Usage
% 
% util_POSIXTimeToDate(time)
% 
%
% time
%        One dimensional vector of milliseconds since the beginning of epoch.
%
%
% Return Value
% 
% One dimensional vector of time values in 'yyyy-MM-dd hh:mm:ss' string format.
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
% util_POSIXTimeToDate(data_goog(:,1))
function [date_str] = util_POSIXTimeToDate(POSIXTime,format)
if nargin ==1
date_str=com.portfolioeffect.quant.client.util.DateTimeUtil.POSIXTimeToDateStr( int64(POSIXTime));
date_str = char(cell(date_str));
else
date_str=com.portfolioeffect.quant.client.util.DateTimeUtil.POSIXTimeToDateInt( int64(POSIXTime),format);
end
end