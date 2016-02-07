% Position correlation matrix
%
% 
% Computes daily correlation matrix of position returns.
% Function connect() should be called before any other requests to the server are made.
% 
% Usage
% 
% position_correlationMatrix(portfolio)
% 
%
% portfolio
%       Portfolio object created using portfolio_create( ) function
%
% Return Value
% 
% Numeric matrix of position correlation. 
%
% Description
% https://www.portfolioeffect.com/docs/glossary/measures/relative-risk-measures/correlation
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
% portfolioExample=portfolio_create('priceDataIx',data_spy); 
% portfolio_addPosition(portfolioExample,'GOOG',100,'priceData',data_goog);
% portfolio_addPosition(portfolioExample,'AAPL',300,'priceData',data_aapl);
% portfolio_addPosition(portfolioExample,'SPY',150,'priceData',data_spy);
% portfolio_settings(portfolioExample,'portfolioMetricsMode','price','windowLength','3600s');
% position_correlationMatrix(portfolioExample)
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% position_correlationMatrix(portfolioExample)
function [position_correlationMatrix] = position_correlationMatrix(portfolio)
portfolioTemp=portfolio_create(portfolio);
setting=portfolio_getSettings(portfolioTemp);
setting.resultsSamplingInterval='last';
portfolio_settings(portfolioTemp,setting);
portfolioIce=getJava(portfolioTemp);
symbols=portfolio_symbols(portfolioTemp);
n=length(symbols);
printMatrix=ones(n,n);

           portfolioIce.startBatch();
for i = 2:n
    for j = 1:(i-1)
        position_metric(portfolioTemp,'metric','POSITION_CORRELATION','positionA',symbols(i),'positionB',symbols(j));
    end
end
           portfolioIce.finishBatch();


for i = 2:n
    for j = 1:(i-1)
        result=position_metric(portfolioTemp,'metric','POSITION_CORRELATION','positionA',symbols(i),'positionB',symbols(j));
        printMatrix(i,j)=result(2);
        printMatrix(j,i)=printMatrix(i,j);
    end
end
position_correlationMatrix=[{'---'},symbols';symbols,num2cell(printMatrix)];
end
