% Porfolio Optimization - Set Optimization Forecast
% 
% Adds portfolio optimization constraint restricting optimal portfolio weight of selected positions to a certain range.
%
% Usage
% 
% optimization_forecast(optimizer,metricType,symbol,value,time)
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
% metricType
%     Choose forecast metric type:
%       'Beta' - position beta,
%       'Variance' - position variance,
%       'Skewness' - position skewness,
%       'Kurtosis' - position kurtosis,
%       'Cumulant1' - position 1-th cumulant,
%       'Cumulant2' - position 2-th cumulant,
 %      'Cumulant3' - position 3-th cumulant,
%       'Cumulant4' - position 4-th cumulant
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
% data_goog=importdata('data_goog.mat'); 
% data_aapl=importdata('data_aapl.mat');  
% data_spy=importdata('data_spy.mat'); 
% portfolioExample=portfolio_create('priceDataIx',data_spy); 
% portfolio_addPosition(portfolioExample,'GOOG',100,'priceData',data_goog);
% portfolio_addPosition(portfolioExample,'AAPL',300,'priceData',data_aapl);
% portfolio_addPosition(portfolioExample,'SPY',150,'priceData',data_spy);
% portfolio_settings(portfolioExample,'price','3600s') 
% optimizer=optimization_goal(portfolioExample,'Return','maximize');
% optimizer=optimization_constraint_weight(optimizer,'>=',0.5,'GOOG');
% optimization_run(optimizer)
function [ optimizer ] = optimization_forecast( optimizer,metricType,symbol,value,time )
	optimizer.forecastedValueLists=[optimizer.forecastedValueLists,struct('metricType',metricType,'symbol',symbol,'value',value,'time',time)];
end

