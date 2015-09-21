% Creates new portfolio
%
% 
% Creates new empty portfolio.
% To add positions use portfolio_addPosition( ).
% To remove positions use portfolio_removePosition( ).
% Function connect() should be called before any other requests to the server are made.
% 
% Usage
% 
% portfolio_create(index, fromTime, toTime)
% portfolio_create(priceDataIx)
% 
% index
%     Index symbol that should be used in the Single Index Model. Defaults to "SPY".
% fromTime
%     Start of market data interval in "yyyy-MM-dd hh:mm:ss" format when internal market data is used. 
%    Offset from last available date/time by N days is denoted as "t-N" (e.g. "t-7" denotes offset by 7 days).
% toTime
%     End of market data interval in "yyyy-MM-dd hh:mm:ss" format when internal market data is used.
%    Offset from last available date/time by N days is denoted as "t-N" (e.g. "t-7" denotes offset by 7 days).
% priceDataIx
%     Vector of (time, price) observations for market index asset when external market data is used.
% 
% Return Value
% 
% portfolio object
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
% portfolio_addPosition(portfolioExample,'GOOG',[100,200],'time',[1412256601000,1412266600000],'priceData',data_goog) ;
% portfolio_addPosition(portfolioExample,'AAPL',[300,150],'time',[1412266600000,1412276600000],'priceData',data_aapl) ;
% portfolio_addPosition(portfolioExample,'SPY',150,'priceData',data_spy);
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
% portfolioExample=portfolio_create('index','SPY','fromTime','t-7','toTime','t');
% portfolio_addPosition(portfolioExample,'GOOG',200);
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'SPY',100);
% portfolio_settings(portfolioExample,'portfolioMetricsMode','price','windowLength','3600s');
% portfolioExample
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(portfolio_variance(portfolioExample),'Portfolio Variance')
function [portfolio] = portfolio_create(varargin)

global clientConnection
if ~util_validateConnection()
    return;
end

if isa(varargin{1},'portfolioContainer')
    portfolio=portfolioContainer();
    portfolio_create=com.portfolioeffect.quant.client.portfolio.Portfolio(varargin{1}.java);
    portfolio=setJava(portfolio,portfolio_create);
else
p = inputParser;
   defaultIndex = 'SPY';
   defaultFromTime = true;
   defaultToTime = true;
   defaultPriceDataIx = true;
   
   addParamValue(p,'index',defaultIndex,@ischar);
   addParamValue(p,'fromTime',defaultFromTime,@ischar);
   addParamValue(p,'toTime',defaultToTime,@ischar);
   addParamValue(p,'priceDataIx',defaultPriceDataIx,@isnumeric);
             
parse(p,varargin{:});
portfolio=portfolioContainer();
portfolio_create=com.portfolioeffect.quant.client.portfolio.Portfolio(clientConnection);
if ischar(p.Results.fromTime) && ischar(p.Results.toTime) && p.Results.priceDataIx
    Results=portfolio_create.setFromTime(p.Results.fromTime);
    if Results.hasError()
            disp(Results.getErrorMessage())
            error(char(Results.getErrorMessage()));
    end
           Results=portfolio_create.setToTime(p.Results.toTime);
    if Results.hasError()
            disp(Results.getErrorMessage())
            error(char(Results.getErrorMessage()));
    end
        Results=portfolio_create.addIndex(p.Results.index);
elseif p.Results.fromTime && p.Results.toTime && isnumeric(p.Results.priceDataIx)
    data=p.Results.priceDataIx;
    Results=portfolio_create.addIndex(double(data(:,2)),int64(data(:,1)));
end
if Results.hasError()
    msgbox(char(Results.getErrorMessage()));
    error(char(Results.getErrorMessage()));
end
portfolio=setJava(portfolio,portfolio_create);
portfolio_settings(portfolio,'portfolioMetricsMode','portfolio')
end
end
