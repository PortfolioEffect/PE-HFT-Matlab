% Adds line chart to existing plot
% 
% Adds another line chart on the existing plot using a time series of metric values.
% 
% 
% Usage
% 
% util_line2d(metric,legend)
% 
%
% metric
%        Time series  of (time, value) returned by metric functions.
%
% legend
%        Plot legend.
%
% Return Value
% 
% plot
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
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plot2d(position_VaR(portfolioExample,'AAPL',0.05),'AAPL','Title','Value at Risk daily')+util_line2d(position_VaR(portfolioExample,'GOOG',0.05),'GOOG')+util_line2d(portfolio_VaR(portfolioExample,0.05),'Portfolio')
function r= util_line2d( data,legend)
Data=data(:,2);
Time=data(:,1);
Legend=repmat(cellstr(legend), length(Data), 1);
realData=dataset(Data,Time,Legend);
r=portfolioPlot();
r.realData=realData;
end

