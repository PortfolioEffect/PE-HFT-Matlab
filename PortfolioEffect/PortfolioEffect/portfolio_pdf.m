% Probability Density Function of Portfolio Returns
%
% 
% Computes probability density of position returns for a given interval (pValueLeft, pValueRight) at nPoints of approximation. 
% Probability density is computed based on a "densityModel" specified in portfolio_settings( ) method.
% 
% Usage
% 
% portfolio_pdf(portfolio, pValueLeft, pValueRight, nPoints, addNormalDensity)
% 
%
% portfolio
%        Portfolio object created using portfolio_create( ) function
%
% pValueLeft
%        Left limit of probability density value in decimals.
%
% pValueRight
%        Right limit of probability density value in decimals.
%
% nPoints
%        Number of approximation points for the PDF function.
%
% addNormalDensity
%        Flag used to add normal density to the final result. Defaults to FALSE.
%
% Return Value
% 
% List of probability density values
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
% util_plotDensity(portfolio_pdf(portfolioExample,0.2,0.8,100,true))
% 
% dateStart = '2014-11-17 09:30:00';
% dateEnd = '2014-11-19 16:00:00';
% portfolioExample=portfolio_create('index','SPY','fromTime',dateStart ,'toTime',dateEnd );
% portfolio_addPosition(portfolioExample,'AAPL',100);
% portfolio_addPosition(portfolioExample,'C',300); 
% portfolio_addPosition(portfolioExample,'GOOG',150);
% util_plotDensity(portfolio_pdf(portfolioExample,0,1,100,true))
function [ result ] = portfolio_pdf( portfolio,pValueLeft,pValueRight,nPoints,addNormalDensity )
portfolioTemp=portfolio_create(portfolio);

	set=portfolio_getSettings(portfolioTemp);
    portfolioTemp.java.setParam('samplingInterval','last');
		
    z=portfolioTemp.java.getPDF(double(pValueLeft),double(pValueRight),int16(nPoints));
	resultTemp=util_getResult(z);
	result=struct('pdf',resultTemp(2:(nPoints+1)),'value',resultTemp((nPoints+2):(2*nPoints+1)));
    
	if addNormalDensity
        portfolioTemp.java.setParam('densityApproxModel','NORMAL');
		z1=portfolioTemp.java.getPDF(double(pValueLeft),double(pValueRight),int16(nPoints));
		resultTemp1=util_getResult(z1);
        
		result.pdfNormal=resultTemp1(2:(nPoints+1));
		result.valueNormal=resultTemp1((nPoints+2):(2*nPoints+1));
    end

end

