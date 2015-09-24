% Note
%
% PortfolioEffect - Matlab Interface to Quant API
% 
% Copyright (C) 2010 - 2015 Snowfall Systems, Inc.
%

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