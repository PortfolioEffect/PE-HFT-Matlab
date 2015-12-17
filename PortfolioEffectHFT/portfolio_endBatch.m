% Ends Metrics Batch
%
% 
% Marks the end of a metrics batch and starts batch group processing. 
% Once the method finishes executing, you could retrieve computed metric values by calling same metrics once again. 
% The batch is finished by a call to \link[=portfolio_endBatch]{portfolio_endBatch( )} function. 
% To maximize speed improvements from batching, group those metrics that operate on the same portfolio or position. 
% This way they will be computed in one pass over the data.
% 
% Usage
% 
% portfolio_endBatch(portfolio)
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
% portfolio_VaR(portfolioExample,0.95);
% position_VaR(portfolioExample,'AAPL',0.95);
% position_VaR(portfolioExample,'GOOG',0.95);
%
% portfolio_endBatch(portfolioExample);
%
% util_plot2d(position_VaR(portfolioExample,'AAPL',0.95),'AAPL','Title','Value at Risk daily')+util_line2d(position_VaR(portfolioExample,'GOOG',0.95),'GOOG')+        util_line2d(portfolio_VaR(portfolioExample,0.05),'Portfolio')
function [] = portfolio_endBatch(portfolio)
 portfolioIce=getJava(portfolio);
     result=portfolioIce.finishBatch();
                     if result.hasError()
            disp(result.getErrorMessage())
            error(char(result.getErrorMessage()));
        end
end
