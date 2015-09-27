% Set Credentials
% 
% Saves platform client log-in credentials. To retrieve your account credentials, please 
% log in to your account or register for a free account at https://www.portfolioeffect.com/registration. 
% This function should be called before any other requests to the server are made.
% 
% Usage
% 
% util_setCredentials(username,password,apiKey,host)
% 
% username
%     User name
% password
%     User password
% apiKey
%     Unique apiKey
% hostname
%     Server host address
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
% util_setCredentials("JohnDow", "samplePass", "d9822d83d796427b6aa078d792090b47");
function [] = util_setCredentials(username,password,apiKey,host)

% Fill in unset optional values.
switch nargin
    case 3
        host = 'snowfall04.snowfallsystems.com';
end

login={char(username); char(password); char(apiKey); char(host);};
save(fullfile(prefdir,'matICE9Remote.mat'),'login');
clearvars -global clientConnection
end