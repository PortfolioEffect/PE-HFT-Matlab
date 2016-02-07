function [ result ] = myConstraint( portfolio )
a=portfolio_beta(portfolio);
result=a(2)-1;
% result=0.8;
end

% function [ result ] = myConstraint( portfolio, time )
%   global bench_beta
%   bench_beta_value = bench_beta(bench_beta(:,1)==time, 2);
%   portfolio_beta_value = portfolio_beta(portfolio);
%   portfolio_beta_value = portfolio_beta_value[portfolio_beta_value[,1]==time,2];
%   
%   if portfolio_beta_value > bench_beta_value)
%     result = bench_beta_value;
%     else 
%           result = portfolio_beta_value;
%   end
% 
%   end