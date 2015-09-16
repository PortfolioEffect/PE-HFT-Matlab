% Remaining compute time
%
% Returns remaining/maximum compute time in seconds.
% Maximum time is limited by client's current subscription plan until.
% Remaining time is reset to maximum time every day at 12am ET.
%
%
% Usage
%
% util_getComputeTime(time)
%
%
% time
%        One of the following option:
%   	'timeMax' - maximum available compute time,
%   	'timeLeft' - remaining compute time.
%
%
% Return Value
%
% Time value in seconds.
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
% util_getComputeTime('timeMax')
% util_getComputeTime('timeLeft')
function [ result ] = util_getComputeTime( time )
util_validateConnection();
global clientConnection
Results=clientConnection.getComputeTimeLeft();
if Results.hasError()
    disp(Results.getErrorMessage())
    error(char(Results.getErrorMessage()));
end
result=char(Results.getInfoParam(time));
end

