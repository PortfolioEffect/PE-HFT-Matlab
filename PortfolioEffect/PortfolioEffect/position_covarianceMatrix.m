% Position covariance matrix
%
% 
% Computes daily covariance matrix of position returns.
% Function connect() should be called before any other requests to the server are made.
% 
% Usage
% 
% position_covarianceMatrix(portfolio)
% 
%
% portfolio
%       Portfolio object created using portfolio_create( ) function
% 
% Return Value
% 
% Numeric matrix of position covarianceS. 
%
% Description
% https://www.portfolioeffect.com/docs/glossary/measures/relative-risk-measures/covariance
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
% data_goog=importdata('data_goog.mat'); 
% data_aapl=importdata('data_aapl.mat');  
% data_spy=importdata('data_spy.mat'); 
% portfolioExample=portfolio_create('priceDataIx',data_spy); 
% portfolio_addPosition(portfolioExample,'GOOG',100,'priceData',data_goog);
% portfolio_addPosition(portfolioExample,'AAPL',300,'priceData',data_aapl);
% portfolio_addPosition(portfolioExample,'SPY',150,'priceData',data_spy);
% portfolio_settings(portfolioExample,'portfolioMetricsMode','price','windowLength','3600s');
% position_covarianceMatrix(portfolioExample)
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% position_covarianceMatrix(portfolioExample)
function [position_covarianceMatrix] = position_covarianceMatrix(portfolio)
change=false;
setting=portfolio_getSettings(portfolio);
if ~strcmp(setting.resultsSamplingInterval,'last')
settingTemp=setting;
settingTemp.resultsSamplingInterval='last';
portfolio_settings(portfolio,settingTemp);
change=true;
end

portfolioIce=getJava(portfolio);
symbols=portfolio_symbols(portfolio);
n=length(symbols);

           portfolioIce.startBatch();
for i = 2:n
    for j = 1:(i-1)
        position_metric(portfolio,'metric','POSITION_COVARIANCE','positionA',symbols(i),'positionB',symbols(j));
    end
end
for i = 1:n
       position_metric(portfolio,'metric','POSITION_VARIANCE','position',symbols(i));
end
           portfolioIce.finishBatch();



printMatrix=ones(n,n);
for i = 2:n
    for j = 1:(i-1)
        result=position_metric(portfolio,'metric','POSITION_COVARIANCE','positionA',symbols(i),'positionB',symbols(j));
        printMatrix(i,j)=result(2);
        printMatrix(j,i)=printMatrix(i,j);
    end
end
for i = 1:n
    result=position_metric(portfolio,'metric','POSITION_VARIANCE','position',symbols(i));
    printMatrix(i,i)=result(2);
end
if change
   portfolio_settings(portfolio,setting); 
end
position_covarianceMatrix=[{'---'},symbols';symbols,num2cell(printMatrix)];
end
