% Line plot of portfolio metric (for a dataset)
%
% Draws a new line plot using a a dataframe with one or many metric values.
% 
% 
% Usage
% 
% util_plot2df(formula,data,Title,Subtitle,title_size,base_size,dkpanel, bw)
% 
%
% formula
%        Formula that describes data titles to be plotted.
%
% data
%        dataset with metric data.
%
% Title
%        Plot title.
%
% Subtitle
%        Plot subtitle.
%
% title_size
%        Title font size.
%
% base_size
%        Base font size.
%
% dkpanel
%        dkpanel flag.
%
% bw
%        Black and white color scheme flag.
%
%
% Return Value
% 
% plot
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
% data= position_return(portfolioExample,'AAPL');
% Data=data(:,2);
% Time=data(:,1);
% Legend=repmat(cellstr('Return'), length(Data), 1);
% plotData=dataset(Data,Time,Legend);
% plot=util_plot2df('Data~Time',plotData)
function [plot] = util_plot2df( formula,data,varargin)

p = inputParser;
   defaultTitle = cellstr('No title');
   defaultSubtitle =cellstr('No subtitle');
   defaultTitle_size = 18;
   defaultLines_size = 1.5;
   defaultBase_size = 14;
   defaultDkpanel= false;
   defaultBw = false;
% if (datenum(version('-date')))

if verLessThan('matlab','8.2')
    %    addParameter(p,'legend',defaultLegend);
    addParamValue(p,'Title',defaultTitle);
    addParamValue(p,'Subtitle',defaultSubtitle);
    addParamValue(p,'title_size',defaultTitle_size,@isnumeric);
    addParamValue(p,'lines_size',defaultLines_size,@isnumeric);
    addParamValue(p,'base_size',defaultBase_size,@isnumeric);
    addParamValue(p,'dkpanel',defaultDkpanel,@islogical);
    addParamValue(p,'bw',defaultBw,@islogical);
else
    %    addParameter(p,'legend',defaultLegend);
    p.addParameter('Title',defaultTitle);
    p.addParameter('Subtitle',defaultSubtitle);
    p.addParameter('title_size',defaultTitle_size,@isnumeric);
    p.addParameter('lines_size',defaultLines_size,@isnumeric);
    p.addParameter('base_size',defaultBase_size,@isnumeric);
    p.addParameter('dkpanel',defaultDkpanel,@islogical);
    p.addParameter('bw',defaultBw,@islogical);
end
             
parse(p,varargin{:});

nameList=util_strsplit(formula,'~');

%Time = sortrows([data.(char(nameList(1)))', data.(char(nameList(2)))', data.Legend], 1);
Time =sortrows(unique(data.(char(nameList(2)))'),1);

n=length(Time);
days=(Time(end)-Time(1))/86400000;
if days<0.001
       TimeStep=util_POSIXTimeToDate(Time,'ss');
       format={'ss'};
elseif days<0.0025
          TimeStep=find((~([0;diff(util_POSIXTimeToDate(Time,'ss'))]==0))&([0;diff(mod(util_POSIXTimeToDate(Time,'ss'),10))]<0));
           format={'mm',':','ss'};
elseif days<0.008
         TimeStep=find((~([0;diff(util_POSIXTimeToDate(Time,'ss'))]==0))&([0;diff(mod(util_POSIXTimeToDate(Time,'ss'),30))]<0));
           format={'mm',':','ss'};
elseif days<0.015
        TimeStep=find(~([0;diff(util_POSIXTimeToDate(Time,'mm'))]==0));
         format={'mm',':','ss'};
elseif days<0.03
        TimeStep=find((~([0;diff(util_POSIXTimeToDate(Time,'mm'))]==0))&([0;diff(mod(util_POSIXTimeToDate(Time,'mm'),5))]<0));
         format={'HH',':','mm'};
elseif days<0.01
        TimeStep=find((~([0;diff(util_POSIXTimeToDate(Time,'mm'))]==0))&([0;diff(mod(util_POSIXTimeToDate(Time,'mm'),10))]<0));
         format={'HH',':','mm'};
elseif days<2
        TimeStep=find(~([0;diff(util_POSIXTimeToDate(Time,'HH'))]==0));
         format={'HH',':','mm'};
elseif days<20
        TimeStep=find(~([0;diff(util_POSIXTimeToDate(Time,'uu'))]==0));
         format={'MM','/','dd'};
elseif days<90
        TimeStep=find([0;diff(util_POSIXTimeToDate(Time,'uu'))]<0);
         format={'MM','/','dd'};
elseif days<365
        TimeStep=find(~([0;diff(util_POSIXTimeToDate(Time,'MM'))]==0));
         format={'MM','/','yyyy'};
elseif days<365*3
    TimeStep=find((~([0;diff(util_POSIXTimeToDate(Time,'MM'))]==0))&([0;diff(mod(util_POSIXTimeToDate(Time,'MM'),3))]<0));
     format={'MM','/','yyyy'};
else
       TimeStep=find(~([0;diff(util_POSIXTimeToDate(Time,'yyyy'))]==0));
        format={'yyyy'};
end

if ((TimeStep(1)-1)/n>0.2)&&(~all(char(util_getDataFromPOSIXTime(Time(1),format))==char(util_getDataFromPOSIXTime(Time(TimeStep(1)),format))))
    TimeStep=[1;TimeStep];
end

if ((n-TimeStep(end))/n>0.05)&&(~all(char(util_getDataFromPOSIXTime(Time(end),format))==char(util_getDataFromPOSIXTime(Time(TimeStep(end)),format))))
    TimeStep=[TimeStep;n];
end

% temp=diff(TimeStep)/n>0.07;
% TimeStep=TimeStep([temp' true]);
i = 1;
while i < length(TimeStep)
  i = i + 1;
    if (TimeStep(i)-TimeStep(i-1))/n<0.06
        TimeStep(i) = [];
		i=1;
    end   
end

	dateTime = zeros(length(Time), 6);
	year = util_POSIXTimeToDate(Time,'yyyy');
    month = util_POSIXTimeToDate(Time,'MM');
    day = util_POSIXTimeToDate(Time,'dd');
       
	for i = 1:length(Time)
       dateTime(i,:) = [year(i), month(i), day(i), 9, 30, 0];
    end

    temp=Time-util_dateToPOSIXTime(dateTime)';
    temp=temp/1000;
    temp1=find([0 diff(temp)]<0);
  if any(diff(temp)<0) 
      for i = 1:length(temp1)
        temp((temp1(i)):length(temp))=temp((temp1(i)):length(temp))+23400;
      end
  end
  	if all(diff(temp)==0)
		temp=1:length(Time);
    end
   Time=[Time, temp];
   
    [tf, loc]=ismember(data.(char(nameList(2)))',Time);
    
    plotData=data;
    plotData.Time(:)=loc(:);
    
    
    Legend=unique(plotData.Legend);
    plotDataSampling=[];
    for leg = Legend
      temp1=plotData(strcmp(plotData.Legend,leg),:);
      n=length(temp1);
      if n>=46800
        s=round(n/23400);
        cumsumTemp=cumsum([0;temp1.Data]);
        tempSum=[zeros(1,s-1)';(cumsumTemp((s+1):end)-cumsumTemp(1:(n-s+1)))/s];
        Data=tempSum(rem(1:n,s)==0);
        Time=plotData.Time(rem(1:n,s)==0);
        Legend=plotData.Legend(rem(1:n,s)==0);
        plotData=dataset(Data,Time,Legend);
        plotDataSampling=[plotDataSampling;dataset(Data,Time,Legend)]	;
      else
        plotDataSampling=[plotDataSampling;temp1];
        end
      end
        
    Title=cellstr(p.Results.Title);
    Subtitle=cellstr(p.Results.Subtitle);
    title_size=p.Results.title_size;
    lines_size=p.Results.lines_size;
    base_size=p.Results.base_size;
    dkpanel=p.Results.dkpanel;
    bw=p.Results.bw;

    plot=portfolioPlot(); 
plot.plotData=plotDataSampling;
plot.realData=data;
plot.option=dataset(Title,Subtitle,title_size,lines_size,base_size,dkpanel,bw);
plot.breaks=TimeStep;
    time = util_getDataFromPOSIXTime(data.(char(nameList(2))),format);
    tick_label = time(TimeStep,:);
plot.labels=tick_label;
end    
