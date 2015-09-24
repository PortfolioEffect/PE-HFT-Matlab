% Color scheme for charts
%
% Custom color scheme for charts based on discrete scale.
% 
% 
% Usage
% 
% util_colorScheme(n)
% 
% n
%        number of plot line
%
% Return Value
% 
% Constructed discrete color scheme. 
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
% data_goog=importdata('data_goog.mat'); 
% data_aapl=importdata('data_aapl.mat');  
% data_spy=importdata('data_spy.mat'); 
%  plot(data_goog(:,1),data_goog(:,2),'Color',util_colorScheme(1),'LineWidth',2)
% util_plotTheme('Title','Price')
% hold all;
%  plot(data_aapl(:,1),data_aapl(:,2),'Color',util_colorScheme(2),'LineWidth',2)
%   plot(data_spy(:,1),data_spy(:,2),'Color',util_colorScheme(3),'LineWidth',2)
% hold off;

function [ result ] = util_colorScheme( n )
color=[[1 77 100];[1 162 217];[0 137 126];[238 143 113];[124 38 11];[173 173 173];[103 148 167];[122 210 246];[0 136 125];[118 192 193]];
result=color(n,:)/255;
end

