% Portfolio Available Symbols
%
% 
% Get All Symbol List
% 
% Usage
% 
% portfolio_availableSymbols(portfolio)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% Return Value
% 
% dataset with VarNames ( 'id','description','exchange')
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
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% availableSymbols=portfolio_availableSymbols(portfolio);
% availableSymbols.id
function [ result ] = portfolio_availableSymbols(portfolio)
	data=portfolio.java.getAllSymbolsList;
	   dataNames=data.getDataNames();
       result=dataset();
                for i = 1:length(dataNames)
dataName=char(dataNames(i));
result.Var=char(data.getStringArray(dataName));
result.Properties.VarNames{i} = dataName;
end
end

