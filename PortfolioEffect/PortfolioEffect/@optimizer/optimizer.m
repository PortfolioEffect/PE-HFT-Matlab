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

classdef optimizer
properties
      java = null(1);
      portfolio = null(1);
      errorInDecimalPoints=null(1);
	  globalOptimumProbability=null(1);
      constraintMerticFunctions = null(1);
      constraintTypeFunctions = null(1);
      functions = null(1);
      constraintConfidenceIntervalFunctions = null(1);
      constraintSymbolsFunctions = null(1);
      constraintMerticSimple = null(1);
      constraintTypeSimple = null(1);
      constraintValueSimple = null(1);
      constraintConfidenceInterval = null(1);
      constraintSymbols = null(1);
      portfolioValue = null(1);
      goal = null(1);
      direction = null(1);
      confidenceInterval = null(1);
      forecastedValueLists=null(1);
	  forecastLength=null(1);
      forecastType=null(1);
      windowLength=null(1);
end
end