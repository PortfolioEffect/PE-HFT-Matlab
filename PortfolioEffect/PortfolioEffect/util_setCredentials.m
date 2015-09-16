% Set Credentials
% 
% Set client authentication credentials. To find your account credentials, please log in to your account. 
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