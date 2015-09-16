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
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>
% 
% Examples
% 
% time = '2014-11-17 09:30:00';
% util_dateToPOSIXTime(time)
function [POSIXTime] = util_dateToPOSIXTime(DateTime)
% import java classes
DateTime=datestr(DateTime,'yyyy-mm-dd HH:MM:SS');
check=1414818000000-double(com.snowfallsystems.ice9.quant.client.util.DateTimeUtil.toPOSIXTime( datestr('2014-11-01 01:00:00','yyyy-mm-dd HH:MM:SS')));
POSIXTime=com.snowfallsystems.ice9.quant.client.util.DateTimeUtil.toPOSIXTime( DateTime);
POSIXTime=double(POSIXTime)+check;
end