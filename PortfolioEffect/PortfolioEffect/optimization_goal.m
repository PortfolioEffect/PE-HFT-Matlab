% Porfolio Optimization - Set Optimization Goal
%
%
% Usage
%
% optimization_goal(portfolio,goal,direction,confidenceInterval)
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% goal
%     Choose optimization goal:
%       'EquiWeight' -no optimization is performed, constraints are not processes. Portfolio positions are returned with equal weights.
%	    'ContraintsOnly' - no optimization is performed. This is used for returning portfolio that meets specified set of constraints.
%	    'Variance' - portfolio returns variance,
%	    'VaR' - portfolio Value-at-Risk,
%	    'CVaR' - portfolio Expected Tail Loss,
%	    'ExpectedReturn' - portfolio expected return,
%	    'Return' - portfolio return,
%	    'SharpRatio' - portfolio Sharpe Ratio,
%	    'ModifiedSharpeRatio' - portfolio modified Sharpe Ratio,
%	    'StarrRatio' - portfolio STARR Ratio,
%
%
% direction
%     Choose direction of optimization algorithm:
%       'minimize' - maximization goal,
%	    'maximize' - minimization goal

% confidenceInterval
%        Confidence interval (in decimals) to be used as a cut-off point
%        Applicable for 'VaR', 'CVaR', 'ModifiedSharpeRatio', 'StarrRatio' metrics only.
%
% Return Value
%
% Constructed optimizer object.
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
% optimizer=optimization_constraint_beta(optimizer,'<=',0.5);
% optimalPortfolio=optimization_run(optimizer);
% optimalPortfolio
function [optimiz] = optimization_goal(portfolio,varargin)
if ~util_validateConnection()
    return;
end
optimiz=optimizer();
p = inputParser;
defaultConfidenceInterval = 0.05;
defaultGoal = 'None';
defaultDirection = 'minimize';
expectedGoal = {'EquiWeight','ContraintsOnly','Variance','VaR','CVaR','ExpectedReturn','Return','SharpeRatio','ModifiedSharpeRatio','StarrRatio'};
expectedDirection = {'minimize', 'maximize'};
defaultWindowLength='1m';
defaultForecastLength='1m';
expectedType={'simple','exp_smoothing'};
defaultForecastType='simple';
defaultErrorInDecimalPoints=1e-12;
defaultGlobalOptimumProbability=0.99;


addRequired(p,'portfolio');
addOptional(p,'goal',defaultGoal,@(x) all(validatestring(char(x),expectedGoal)));
addOptional(p,'direction',defaultDirection,@(x) all(validatestring(char(x),expectedDirection)));
addOptional(p,'confidenceInterval',defaultConfidenceInterval,@isnumeric);
addOptional(p,'windowLength',defaultWindowLength);
addOptional(p,'forecastLength',defaultForecastLength);
addOptional(p,'forecastType',defaultForecastType,@(x) all(validatestring(char(x),expectedType)));
addOptional(p,'errorInDecimalPoints',defaultErrorInDecimalPoints);
addOptional(p,'globalOptimumProbability',defaultGlobalOptimumProbability);

parse(p,portfolio,varargin{:});

settings = portfolio_getSettings(portfolio);
if strcmp(settings.portfolioMetricsMode,'portfolio')
    optimizer_create=com.snowfallsystems.ice9.quant.client.portfolio.optimizer.StrategyOptimizer(portfolio.java,int32(p.Results.errorInDecimalPoints),int32(p.Results.globalOptimumProbability));
else
    optimizer_create=com.snowfallsystems.ice9.quant.client.portfolio.optimizer.PortfolioOptimizer(portfolio.java,int32(p.Results.errorInDecimalPoints),int32(p.Results.globalOptimumProbability));
end

switch p.Results.goal
    case 'Variance'
        optimizer_create.setOptimizationGoal('VARIANCE',p.Results.direction);
    case 'VaR'
        optimizer_create.setOptimizationGoal('VAR',p.Results.direction,p.Results.confidenceInterval);
    case 'CVaR'
        optimizer_create.setOptimizationGoal('CVAR',p.Results.direction,p.Results.confidenceInterval);
    case 'ExpectedReturn'
        optimizer_create.setOptimizationGoal('EXPECTED_RETURN',p.Results.direction);
    case 'Return'
        optimizer_create.setOptimizationGoal('RETURN',p.Results.direction);
    case 'SharpeRatio'
        optimizer_create.setOptimizationGoal('SHARPE_RATIO',p.Results.direction);
    case 'ModifiedSharpeRatio'
        optimizer_create.setOptimizationGoal('SHARPE_RATIO',p.Results.direction,p.Results.confidenceInterval);
    case 'StarrRatio'
        optimizer_create.setOptimizationGoal('STARR_RATIO',p.Results.direction,p.Results.confidenceInterval);
    case 'EquiWeight'
        optimizer_create.setOptimizationGoal('NONE',p.Results.direction);
    case 'ContraintsOnly'
        optimizer_create.setOptimizationGoal('ZERO',p.Results.direction);
    otherwise
        error('Optimization metric not supported');
        
end
optimizer_create.setPortfolioValue(int32(-1));
optimiz.java=optimizer_create;
optimiz.portfolio=portfolio;
      optimiz.errorInDecimalPoints=int32(p.Results.errorInDecimalPoints);
	  optimiz.globalOptimumProbability=int32(p.Results.globalOptimumProbability);
optimiz.goal=p.Results.goal;
optimiz.direction=p.Results.direction;
optimiz.confidenceInterval=p.Results.confidenceInterval;
optimiz.windowLength=p.Results.windowLength;
optimiz.forecastLength=p.Results.forecastLength;
optimiz.forecastType=p.Results.forecastType;

end
