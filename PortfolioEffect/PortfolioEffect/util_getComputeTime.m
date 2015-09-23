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

