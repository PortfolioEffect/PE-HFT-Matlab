% Date To POSIX Time
%
% Numerical vector of milliseconds since the beginning of the epoch. 
% 
% 
% Usage
% 
% util_dateToPOSIXTime(time)
% 
%
% time
%        One dimensional vector of time values in "yyyy-MM-dd hh:mm:ss" string format.
%
%
% Return Value
% 
% Numerical vector of milliseconds since the beginning of the epoch. 
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
% time = '2014-11-17 09:30:00';
% util_dateToPOSIXTime(time)
function [POSIXTime] = util_dateToPOSIXTime(DateTime)
% import java classes
DateTime=datestr(DateTime,'yyyy-mm-dd HH:MM:SS');
check=1414818000000-double(com.portfolioeffect.quant.client.util.DateTimeUtil.toPOSIXTime( datestr('2014-11-01 01:00:00','yyyy-mm-dd HH:MM:SS')));
POSIXTime=com.portfolioeffect.quant.client.util.DateTimeUtil.toPOSIXTime( DateTime);
POSIXTime=double(POSIXTime)+check;
end