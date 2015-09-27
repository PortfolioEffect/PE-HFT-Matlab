% Portfolio Optimization - VaR Constraint
% 
% Adds portfolio optimization constraint restricting optimal portfolio's Value-at-Risk to a certain range.
% 
% Usage
% 
% optimization_constraint_VaR(optimizer,constraintType,constraintValue,confidenceInterval)
% 
% optimizer
%        Optimizer object created using \link[=optimization_init]{optimization_goal( )} function
%
% constraintType
%        Optimization constraint type:
%          '=' - an equality constraint,
%          '>=' - an inclusive lower bound constraint,
%          '<=' - an inclusive upper bound constraint
%
% constraintValue
%     Value to be used as a constraint equality or boundary
% 
% confidenceInterval
%     Confidence interval (in decimals) to be used as a cut-off point.
% 
% Return Value
% 
% Optimizer object.
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
% dateEnd = '2014-11-17 16:00:00';
% portfolio=portfolio_create('fromTime',dateStart,'toTime',dateEnd);
% portfolio_settings(portfolio,'portfolioMetricsMode','price','windowLength','3600s','resultsSamplingInterval','60s');
% portfolio_addPosition(portfolio,'AAPL',100);
% portfolio_addPosition(portfolio,'C',300) ;
% optimizer=optimization_goal(portfolio,'goal','Return','direction','maximize');
% optimizer=optimization_constraint_VaR(optimizer,'>=',-2000,0.05);
% optimization_run(optimizer)
function [optimizer] = optimization_constraint_VaR(optimizer,constraintType,constraintValue,confidenceInterval)
if ~util_validateConnection()
    return;
end

	constraintMertic='VAR';
	optimizer=optimization_constraint(optimizer,constraintType,constraintMertic,constraintValue,confidenceInterval,[]);

end





