% Portfolio Optimization - Sum Of Absolute Position Weights Constraint
% 
% Adds portfolio optimization constraint restricting optimal portfolio's sum of absolute weights to a certain range.
% 
% Usage
% 
% optimization_constraint_sumOfAbsWeights(optimizer,constraintType,constraintValue,symbols)
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
% symbols
%     Vector of instrument symbols
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
% dateEnd = '2014-11-17 16:00:00';
% portfolio=portfolio_create('fromTime',dateStart,'toTime',dateEnd);
% portfolio_settings(portfolio,'portfolioMetricsMode','price','windowLength','3600s','resultsSamplingInterval','60s');
% portfolio_addPosition(portfolio,'AAPL',100);
% portfolio_addPosition(portfolio,'C',300) ;
% portfolio_addPosition(portfolio,'GOOG',100);
% optimizer=optimization_goal(portfolio,'goal','Return','direction','maximize');
% optimizer=optimization_constraint_sumOfAbsWeights(optimizer,'>=',0.8,{'C';'GOOG'});
% optimization_run(optimizer)
function [optimizer] =  optimization_constraint_sumOfAbsWeights(optimizer,constraintType,constraintValue,symbols)
if ~util_validateConnection()
    return;
end
	constraintMertic='POSITIONS_SUM_ABS_WEIGHT';
	optimizer=optimization_constraint(optimizer,constraintType,constraintMertic,constraintValue,[],symbols);

end



