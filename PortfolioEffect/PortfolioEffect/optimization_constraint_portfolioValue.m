% Portfolio Optimization - Portfolio Value Constraint
% 
% Adds portfolio optimization constraint restricting optimal portfolio's monetary value to a certain number at every step of optimization algorithm.
% 
% Usage
% 
% optimization_constraint_portfolioValue(optimizer,constraintValue)
% 
% optimizer
%        Optimizer object created using \link[=optimization_init]{optimization_goal( )} function
%
% constraintValue
%     
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
% optimizer=optimization_constraint_portfolioValue(optimizer,10^9);
% optimization_run(optimizer)
function [ optimizer ] = optimization_constraint_portfolioValue(optimizer, constraintValue )
optimizer.java.setPortfolioValue(int32(constraintValue));
optimizer.portfolioValue=int32(constraintValue);
end

