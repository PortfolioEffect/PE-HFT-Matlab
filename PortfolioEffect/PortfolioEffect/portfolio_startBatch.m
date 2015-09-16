% Starts Metrics Batch
%
% 
% Marks the start of a metrics batch. 
% All metrics called after the marker would be grouped in one compute batch. 
% The batch is finished by a call to \link[=portfolio_endBatch]{portfolio_endBatch( )} function. 
% To maximize speed improvements from batching, group those metrics that operate on the same portfolio or position. 
% This way they will be computed in one pass over the data.
% 
% Usage
% 
% portfolio_startBatch(portfolio)
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
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
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'GOOG',150);
%
% portfolio_startBatch(portfolioExample);
%
% portfolio_VaR(portfolioExample,0.05);
% position_VaR(portfolioExample,'AAPL',0.05);
% position_VaR(portfolioExample,'GOOG',0.05);
%
% portfolio_endBatch(portfolioExample);
%
% util_plot2d(position_VaR(portfolioExample,'AAPL',0.05),'AAPL','Title','Value at Risk daily')+util_line2d(position_VaR(portfolioExample,'GOOG',0.05),'GOOG')+        util_line2d(portfolio_VaR(portfolioExample,0.05),'Portfolio')
function [] = portfolio_startBatch(portfolio)
 portfolioIce=getJava(portfolio);
     portfolioIce.startBatch();
end
