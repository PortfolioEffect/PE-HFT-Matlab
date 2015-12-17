% Note
%
% PortfolioEffect - Matlab Interface to Quant API
% 
% Copyright (C) 2010 - 2015 Snowfall Systems, Inc.
%

classdef portfolioContainer
properties
      java = 0;
      optimization_info=null(1);
end
   methods
             function td = setJava(td,s)
            td.java = s;
      end 
   end
      methods
             function result = getJava(td)
            result = td.java;
      end 
      end
      methods
 function display(p)
           if ~util_validateConnection()
            return;
           end
           
portfolioTemp=portfolio_create(p);
setting=portfolio_getSettings(portfolioTemp);

if ~strcmp(setting.resultsSamplingInterval,'last')
settingTemp=setting;
settingTemp.resultsSamplingInterval='last';
portfolio_settings(portfolioTemp,settingTemp);
end



           format shortg
           symbols=portfolio_symbols(portfolioTemp);
           printMatrix1=zeros(length(symbols), 6);

           
           disp('PORTFOLIO SETTINGS ');
           disp(['Portfolio metrics mode ',char(setting.portfolioMetricsMode)]);
           disp(['Window length ',char(setting.windowLength)]);
           disp(['Time scale',char(setting.timeScale)]);
           disp(['Holding periods only ',char(setting.holdingPeriodsOnly)]);
           disp(['Short sales mode ',char(setting.shortSalesMode)]);
           disp(['Price jumps model ',char(setting.jumpsModel)]);
           disp(['Microtructure noise model ',char(setting.noiseModel)]);
           disp(['Portfolio factor model ',char(setting.factorModel)]);
           disp(['Density model ',char(setting.densityModel)]);
           disp(['Drift term enabled ',char(setting.driftTerm)]);
           disp(['Results sampling interval ',char(setting.resultsSamplingInterval)]);
           disp(['Input sampling interval ',char(setting.inputSamplingInterval)]);
           disp(['Transaction cost per share ',char(setting.txnCostPerShare)]);
           disp(['Transaction cost fixed ',char(setting.txnCostFixed)]);
           
           
           
           disp(' ');
           portfolioTemp.java.createCallGroup(int16(7));

           portfolio_startBatch(portfolioTemp);
%            for k = 1:length(symbols)
%                position_quantity(p,symbols(k));
%                position_weight(p,symbols(k));
%                position_profit(p,symbols(k));
%                position_return(p,symbols(k));
%                position_value(p,symbols(k));
%                position_price(p,symbols(k));
%            end
               portfolio_profit(portfolioTemp);
               portfolio_return(portfolioTemp);
               portfolio_value(portfolioTemp);
           portfolio_endBatch(portfolioTemp);
           
%                       j=1;
%            for i = 1:length(symbols)
               temp1=position_quantity(portfolioTemp,'all');
               temp2=position_weight(portfolioTemp,'all');
               temp3=position_profit(portfolioTemp,'all');
               temp4=position_return(portfolioTemp,'all');
               temp5=position_value(portfolioTemp,'all');
               temp6=position_price(portfolioTemp,'all');
               printMatrix1(:,1)=round(temp1(2:end));
               printMatrix1(:,2)=round(temp2(2:end)*1000)/10;
               printMatrix1(:,3)=round(temp3(2:end)*1000)/1000;
               printMatrix1(:,4)=round(temp4(2:end)*1000)/10;
               printMatrix1(:,5)=temp5(2:end);
               printMatrix1(:,6)=temp6(2:end);
%                j=j+1;
%            end
           cdes={'Quantity','Weight(in %)','Profit','Return(in %)','Value','Price'};
           r1=[{'---'},cdes;symbols,num2cell(printMatrix1)];
            printMatrix2=zeros(1, 3);
               temp1=portfolio_profit(portfolioTemp);
               temp2=portfolio_return(portfolioTemp);
               temp3=portfolio_value(portfolioTemp);
               printMatrix2(1,1)=round(temp1(2)*1000)/1000;
               printMatrix2(1,2)=round(temp2(2)*1000)/10;
               printMatrix2(1,3)=round(temp3(2));
           cdes={'Profit','Return(in %)','Value'};
           r2=[cdes;num2cell(printMatrix2)];
           disp(' ');
           disp('POSITION SUMMARY');
           disp(r1);
           disp(' ');
           disp('PORTFOLIO SUMMARY');
           disp(r2); 
 end % disp
      end
      methods
     function plot(varargin)
         global clientConnection
if ~util_validateConnection()
    return;
end
portfolioTemp=varargin{1};

p=portfolio_create(portfolioTemp);
setting=portfolio_getSettings(p);
porfolioSet=portfolio_getSettings(p);

tempSet=porfolioSet;
if strcmp(tempSet.resultsSamplingInterval,'last')
    tempSet.resultsSamplingInterval='1s';
    portfolio_settings(p,tempSet);
end
symbols=portfolio_symbols(p);
clientConnection.proggressBarOff();
            p.java.startBatch();
               portfolio_variance(p);
               portfolio_expectedReturn(p);
               portfolio_value(p);
            p.java.finishBatch();
           
           value=portfolio_value(p);
           expectedReturn=portfolio_expectedReturn(p);
            variance=portfolio_variance(p);
clientConnection.proggressBarOn();
 p.java.setParam('samplingInterval','last');
% tempSet.resultsSamplingInterval='last';
% portfolio_settings(p,tempSet);


   p.java.startBatch();
           for k = 1:length(symbols)
               position_weight(p,symbols(k));
               position_profit(p,symbols(k));
           end
               portfolio_profit(p);
     p.java.finishBatch();
    
               printMatrix=zeros(length(symbols), 2);
       j=1;
           for i = 1:length(symbols)
               temp1=position_weight(p,symbols(i));
               temp2=position_profit(p,symbols(i));
               printMatrix(j,1)=round(temp1(2)*1000)/10;
               printMatrix(j,2)=round(temp2(2)*1000)/1000;
               j=j+1;
           end
           
 
           r1=[symbols,num2cell(printMatrix)];
           r1=sortrows(r1,2);
           figure
subplot(4,2,[1,2]);
util_plot2d(value,'Portfolio Value ($)','Title','Portfolio Value')
     subplot(4,2,[5,6]);
util_plot2d(expectedReturn,'Portfolio Expected Return','Title','Portfolio Expected Return')
hline = refline([0 0]);
set(hline,'Color', 'r'); 

       subplot(4,2,[7,8]);
       util_plot2d(variance,'Portfolio Variance','Title','Portfolio Variance')

subplot(4,2,3);
barh(cell2mat(r1(:,2)),'FaceColor',[0 74/255 97/255],'EdgeColor',[0 74/255 97/255]); % groups by row
set(gca,'YTickLabel',r1(:,1));
set(gca,'Color',[213/255 228/255 235/255]);
set(gcf,'Color',[213/255 228/255 235/255]);
set(gca,'FontSize',12);
grid on
title('Positon Weight (%)','FontSize',15,'FontWeight','bold');
% pos = get ( handle, 'Position' );
% set(handle,'Position',[1 pos(2) pos(3)]);    

                  subplot(4,2,4);
barh(cell2mat(r1(:,3)),'FaceColor',[0 163/255 220/255],'EdgeColor',[0 163/255 220/255]); % groups by row
set(gca,'YTickLabel',r1(:,1));
set(gca,'Color',[213/255 228/255 235/255]);
set(gcf,'Color',[213/255 228/255 235/255]);
set(gca,'FontSize',12);
grid on
title('Positon Profit ($)','FontSize',15,'FontWeight','bold');
fh=findall(0,'type','figure');
hFig = fh(1);
set(hFig, 'Position', [800 1 1000 9000])
     end
      end
end