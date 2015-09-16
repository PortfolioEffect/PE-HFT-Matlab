% Add position in portfolio
%
% 
% Add position in portfolio
% 
% Usage
% 
% portfolio_addPosition(portfolio, symbol, quantity, time)
% portfolio_addPosition(portfolio, symbol, quantity, time, priceData)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
% symbol
%        unique identifier of the instrument
% quantity
%        One dimensional vector of position quantities or an integer number if quantity is constant
% time
%        One dimensional vector of time values either as "yyyy-MM-dd hh:mm:ss" string or in milliseconds since the beginning of epoch.
% priceData
%        Vector of (time, price) observations for market asset when external market data is used.
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
% portfolioExample
% 
% portfolioExample=portfolio_create('priceDataIx',data_spy); 
% portfolio_settings(portfolioExample,'windowLength','3600s');
% portfolio_addPosition(portfolioExample,'GOOG',[100,200],'time',['2014-10-02 12:00:00';'2014-10-02 15:00:00'],'priceData',data_goog) ;
% portfolio_addPosition(portfolioExample,'AAPL',[300,150],'time',[1412266600000,1412276600000],'priceData',data_aapl) ;
% portfolio_addPosition(portfolioExample,'SPY',150,'priceData',data_spy);
% portfolio_settings(portfolioExample,'portfolioMetricsMode','price','windowLength','3600s');
% portfolioExample
% 
% portfolioExample=portfolio_create('index','SPY','fromTime','2014-09-10 09:30:01','toTime','2014-09-14 16:00:00');
% portfolio_addPosition(portfolioExample,'GOOG',200);
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'SPY',100);
% portfolio_settings(portfolioExample,'portfolioMetricsMode','price','windowLength','3600s');
% portfolioExample
% 
% portfolioExample=portfolio_create('index','SPY','fromTime','2014-10-02 09:30:01','toTime','2014-10-02 16:00:00');
% portfolio_addPosition(portfolioExample,'GOOG',[100,200],'time',[1412256601000,1412266600000]);
% portfolio_addPosition(portfolioExample,'AAPL',100,'priceData',data_aapl);
% portfolio_addPosition(portfolioExample,'SPY',100);
% portfolio_settings(portfolioExample,'windowLength','3600s');
% portfolioExample
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,{'C','GOOG'},[300,200]);
% util_plot2d(portfolio_variance(portfolioExample),'Portfolio Variance')
function [] = portfolio_addPosition(portfolio,symbol,quantity,varargin)
if ~util_validateConnection()
    return;
end
portfolioContainer=getJava(portfolio);
p = inputParser;
   
   defaultPriceData = 'Def';
   defaultTime = -100;
   
   addRequired(p,'portfolio');
   addRequired(p,'symbol');
   addRequired(p,'quantity');
   addOptional(p,'time',defaultTime);
   addOptional(p,'priceData',defaultPriceData,@isnumeric);
             
parse(p,portfolio,symbol,quantity,varargin{:});

if ischar(p.Results.priceData)
    if p.Results.time<0
result=portfolioContainer.addPosition(symbol,int32(quantity)); 
    else
        time=p.Results.time;
         if ischar(time)
             time=util_dateToPOSIXTime(time);
         end
            result=portfolioContainer.addPosition(symbol,int32(quantity),int64(time));
    end
else
    data=p.Results.priceData;
        if p.Results.time<0
    result=portfolioContainer.addPosition(symbol,double(data(:,2)),int32(quantity),int64(data(:,1)));
        else
             time=p.Results.time;
         if ischar(time)
             time=util_dateToPOSIXTime(time);
         end
         result=portfolioContainer.addPosition(symbol,double(data(:,2)),int64(data(:,1)),int32(quantity),int64(time));       
        end
end
if result.hasError()
    msgbox(char(result.getErrorMessage()));
    error(char(result.getErrorMessage()));
end
end
