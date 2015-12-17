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
%
% confidenceInterval
%        Confidence interval (in decimals) to be used as a cut-off point
%        Applicable for 'VaR', 'CVaR', 'ModifiedSharpeRatio', 'StarrRatio' metrics only.
%
%
% forecastPortfolioWindow
%        Rolling window length for metric estimations and position history (look-behind duration) 
%        used in computing forecast values. Available interval values are: 'Xs' - seconds, 
%        'Xm' - minutes, 'Xh' - hours, 'Xd' - trading days (6.5 hours in a trading day), 
%        'Xw' - weeks (5 trading days in 1 week), 'Xmo' - month (21 trading day in 1 month), 
%        'Xy' - years (256 trading days in 1 year), 'all' - all observations are used. Default value is 
%        '1d' - one trading day .
%
% forecastTimeStep
%        Forecast time step length (look-ahead duration). Available interval values are: 
%        'Xs' - seconds, 'Xm' - minutes, 'Xh' - hours, 'Xd' - trading days (6.5 hours in a trading day), 
%        'Xw' - weeks (5 trading days in 1 week), 'Xmo' - month (21 trading day in 1 month), 
%        'Xy' - years (256 trading days in 1 year). Default value is '1m' - one trading day .
%
% forecastType
%   	Forecast algorithm, if user-defined metric forecasts are not provided: \cr
%   	'simple' - use last available metric value,\cr
%   	'exp_smoothing' - use automatic exponential smoothing. \cr
%   	Default value is 'exp_smoothing'.
%
% forecastExponentialWindow
%   	Length of exponential window if forecastType is set to 'exp_smoothing'. vailable interval values are: 
%   	'Xs' - seconds, 'Xm' - minutes, 'Xh' - hours, 'Xd' - trading days (6.5 hours in a trading day), 
%   	'Xw' - weeks (5 trading days in 1 week), 'Xmo' - month (21 trading day in 1 month), 
%   	'Xy' - years (256 trading days in 1 year). Default value is '1m' - one trading day.
%
% errorInDecimalPoints
%   	Estimation error in decimal points for computing optimal weights. Smaller value slows down optimization algorithm, but increases precision.
%
% globalOptimumProbability
%   	Required probability level of a global optimum. Higher value slows down optimization algorithm, but increases chance of finding globally optimal solution.
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
defaultConfidenceInterval = 0.95;
defaultGoal = 'EquiWeight';
defaultDirection = 'minimize';
expectedGoal = {'EquiWeight','ContraintsOnly','Variance','VaR','CVaR','ExpectedReturn','Return','SharpeRatio','ModifiedSharpeRatio','StarrRatio'};
expectedDirection = {'minimize', 'maximize'};
defaultforecastTimeStep='1m';
defaultForecastExpWindow='5m';
defaultForecastPortfolioWindow='1m';
expectedType={'simple','exp_smoothing'};
defaultForecastType='exp_smoothing';
defaultErrorInDecimalPoints=1e-12;
defaultGlobalOptimumProbability=0.99;


addRequired(p,'portfolio');
addOptional(p,'goal',defaultGoal,@(x) all(validatestring(char(x),expectedGoal)));
addOptional(p,'direction',defaultDirection,@(x) all(validatestring(char(x),expectedDirection)));
addOptional(p,'confidenceInterval',defaultConfidenceInterval,@isnumeric);
addOptional(p,'forecastPortfolioWindow',defaultForecastPortfolioWindow);
addOptional(p,'forecastTimeStep',defaultforecastTimeStep);
addOptional(p,'forecastType',defaultForecastType,@(x) all(validatestring(char(x),expectedType)));
addOptional(p,'forecastExponentialWindow',defaultForecastExpWindow);
addOptional(p,'errorInDecimalPoints',defaultErrorInDecimalPoints);
addOptional(p,'globalOptimumProbability',defaultGlobalOptimumProbability);

parse(p,portfolio,varargin{:});

settings = portfolio_getSettings(portfolio);
if strcmp(settings.portfolioMetricsMode,'portfolio')
    optimizer_create=com.portfolioeffect.quant.client.portfolio.optimizer.StrategyOptimizer(portfolio.java,double(p.Results.errorInDecimalPoints),double(p.Results.globalOptimumProbability));
else
    optimizer_create=com.portfolioeffect.quant.client.portfolio.optimizer.PortfolioOptimizer(portfolio.java,double(p.Results.errorInDecimalPoints),double(p.Results.globalOptimumProbability));
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
optimizer_create.setPortfolioValue(double(-1));
optimiz.java=optimizer_create;
optimiz.portfolio=portfolio;
optimiz.errorInDecimalPoints=p.Results.errorInDecimalPoints;
optimiz.globalOptimumProbability=p.Results.globalOptimumProbability;
optimiz.goal=p.Results.goal;
optimiz.direction=p.Results.direction;
optimiz.confidenceInterval=p.Results.confidenceInterval;
optimiz.forecastTimeStep=p.Results.forecastTimeStep;
optimiz.forecastType=p.Results.forecastType;
optimiz.forecastExponentialWindow=p.Results.forecastExponentialWindow;
optimiz.forecastPortfolioWindow=p.Results.forecastPortfolioWindow;

end
