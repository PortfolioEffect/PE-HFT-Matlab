% Set Position Quantity
%
% 
% Sets new position quantity.
% 
% Usage
% 
% position_setQuantity(portfolio,symbol,quantity)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% symbol
%        unique identifier of the instrument
%
% quantity
%        one dimensional vector of position quantities or an integer number if quantity is constant
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
% data_goog=importdata('data_goog.mat'); 
% data_aapl=importdata('data_aapl.mat');  
% data_spy=importdata('data_spy.mat'); 
% portfolioExample=portfolio_create('priceDataIx',data_spy); 
% portfolio_addPosition(portfolioExample,'GOOG',100,'priceData',data_goog);
% portfolio_addPosition(portfolioExample,'AAPL',300,'priceData',data_aapl);
% portfolio_addPosition(portfolioExample,'SPY',150,'priceData',data_spy);
% portfolio_settings(portfolioExample,'portfolioMetricsMode','price','windowLength','3600s');
% portfolioExample;
% position_setQuantity(portfolioExample,'GOOG',500);
% portfolioExample;
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% portfolioExample;
% position_setQuantity(portfolioExample,'AAPL',600);
% portfolioExample;
function [] = position_setQuantity(portfolio,symbol,quantity)
if ~util_validateConnection()
    return;
end
portfolioContainer=getJava(portfolio);
result=portfolioContainer.setPositionQuantity(symbol,int32(quantity));
if result.hasError()
    msgbox(char(result.getErrorMessage()));
    error(char(result.getErrorMessage()));
end
end
