% Portfolio Optimization - Runs Optimization Algorithm
% 
% 
% Usage
% 
% optimization_run(optimizer)
% 
% optimizer        
%   Optimizer object created using \link[=optimization_init]{optimization_init( )} function
%
% Return Value
% 
% Portfolio object
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
% optimization_constraint_beta(optimizer,'<=',0.5);
% optimization_run(optimizer)
function [portfolio] = optimization_run(optimizer)
if ~util_validateConnection()
    return;
end
 settings = portfolio_getSettings(optimizer.portfolio);
 if strcmp(settings.portfolioMetricsMode,'portfolio')
  forecastedValues=com.portfolioeffect.quant.client.portfolio.optimizer.ForecastedValues(optimizer.portfolio.java);
    result=forecastedValues.setForecastTimeStep(optimizer.forecastTimeStep);
  if result.hasError()
            disp(result.getErrorMessage())
            error(char(result.getErrorMessage()));
        end
optimizer.java.setForecasterType(optimizer.forecastType);
optimizer.java.setForecastExpWindow(optimizer.forecastExponentialWindow);
optimizer.java.setForecastPortfolioWindow(optimizer.forecastPortfolioWindow);
  if ~isempty(optimizer.forecastedValueLists)
     for forecastedValueList = optimizer.forecastedValueLists 
    switch forecastedValueList.metricType
   case 'ExpReturn'
                result=forecastedValues.setSymbolForecastedExpReturn(forecastedValueList.symbol,double(forecastedValueList.value),int64(DateToPOSIXTime(forecastedValueList.time)));
  case 'Beta'
           result=forecastedValues.setSymbolForecastedBeta(forecastedValueList.symbol,double(forecastedValueList.value),int64(DateToPOSIXTime(forecastedValueList.time)));
  case 'Variance'
            result=forecastedValues.setSymbolForecastedVariance(forecastedValueList.symbol,double(forecastedValueList.value),int64(DateToPOSIXTime(forecastedValueList.time)));
  case 'Skewness'
            result=forecastedValues.setSymbolForecastedSkewness(forecastedValueList.symbol,double(forecastedValueList.value),int64(DateToPOSIXTime(forecastedValueList.time)));
  case 'Kurtosis'
            result=forecastedValues.setSymbolForecastedKurtosis(forecastedValueList.symbol,double(forecastedValueList.value),int64(DateToPOSIXTime(forecastedValueList.time)));
  case 'Cumulant1'
            result=forecastedValues.setSymbolForecastedCumulant1(forecastedValueList.symbol,double(forecastedValueList.value),int64(DateToPOSIXTime(forecastedValueList.time)));
  case 'Cumulant2'
            result=forecastedValues.setSymbolForecastedCumulant2(forecastedValueList.symbol,double(forecastedValueList.value),int64(DateToPOSIXTime(forecastedValueList.time)));
  case 'Cumulant3'
            result=forecastedValues.setSymbolForecastedCumulant3(forecastedValueList.symbol,double(forecastedValueList.value),int64(DateToPOSIXTime(forecastedValueList.time)));
  case 'Cumulant4'
            result=forecastedValues.setSymbolForecastedCumulant4(forecastedValueList.symbol,double(forecastedValueList.value),int64(DateToPOSIXTime(forecastedValueList.time)));
    end
        if result.hasError()
            disp(result.getErrorMessage())
            error(char(result.getErrorMessage()));
        end
                end
                    end
  optimizer.java.setForecastedValue(forecastedValues);
                    end
if isempty(optimizer.functions)
    portfolio=portfolioContainer();
optimizer_create=optimizer.java;
result=optimizer_create.getOptimizedPortfolio();
     portfolio.java=util_getResult(result);
     portfolio.optimization_info={char(result.getInfoParam('nFunctionExecute')) char(result.getInfoParam('nGlobalStart')) char(result.getInfoParam('nLocalSolution')) char(result.getInfoParam('nOptimizations')) char(result.getInfoParam('nConstraintSatisfied'))};
else
    portfolio=util_optimizationFunction(optimizer);
end
end
