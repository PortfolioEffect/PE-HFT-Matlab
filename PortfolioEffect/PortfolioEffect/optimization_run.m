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
% optimizer=optimization_goal(portfolio,'goal','Return','direction','maximize');
% optimization_constraint_beta(optimizer,'<=',0.5);
% optimization_run(optimizer)
function [portfolio] = optimization_run(optimizer)
if ~util_validateConnection()
    return;
end
forecastingPortfolio=portfolio_create(optimizer.portfolio);
forecastingPortfolio.java.setParam('isRebalancingHistoryEnabled','false');
forecastingPortfolio.java.setParam('windowLength',optimizer.windowLength);
% --- BEGIN forecasting code -- %
 settings = portfolio_getSettings(forecastingPortfolio);
 if strcmp(settings.portfolioMetricsMode,'portfolio')
  forecastedValues=com.snowfallsystems.ice9.quant.client.portfolio.optimizer.ForecastedValues(optimizer.portfolio.java);
    result=forecastedValues.setForecastTimeStep(optimizer.forecastLength);
  if result.hasError()
            disp(result.getErrorMessage())
            error(char(result.getErrorMessage()));
        end
  result=forecastedValues.makeSimpleCumulantsForecast(forecastingPortfolio.java,optimizer.forecastType);
  if result.hasError()
            disp(result.getErrorMessage())
            error(char(result.getErrorMessage()));
        end
  if ~isempty(optimizer.forecastedValueLists)
     for forecastedValueList = optimizer.forecastedValueLists 
switch forecastedValueList.metricType
    case 'portfolio'
        portfolioIce.setRebalancingHistoryEnabled(true);
    case 'price'
        portfolioIce.setRebalancingHistoryEnabled(false);
end
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
    % TODO finish with the list
    % result<-.jcall(forecastedValues,returnSig="Lcom/snowfallsystems/ice9/quant/client/result/OptimizationMethodResult;",method="makeSimpleCumulantsForecast")
    % errorCheck(result)
    end
        if result.hasError()
            disp(result.getErrorMessage())
            error(char(result.getErrorMessage()));
        end
                end
                    end
  optimizer.java.setForecastedValue(forecastedValues);
                    end

% --- END forecasting code -- %

if isempty(optimizer.functions)
    portfolio=portfolioContainer();
optimizer_create=optimizer.java;
result=optimizer_create.getOptimizedPortfolio();
     portfolio.java=util_getResult(result);
else
%     portfolio=util_optimizationFunction(optimizer);
end
end
