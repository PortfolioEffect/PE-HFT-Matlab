% Clean Credentials
% 
% Removes existing records of client API credentials from the system.
% 
% Usage
% 
% util_cleanCredentials()
% 
% Return Value
% 
% Void
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
% util_cleanCredentials()
function [] = util_cleanCredentials()
delete(fullfile(prefdir,'matICE9Remote.mat'));
end

