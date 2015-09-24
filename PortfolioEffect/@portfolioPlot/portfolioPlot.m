% Note
% 
% PortfolioEffect - Matlab Interface to Quant API
% 
% Copyright (C) 2010 - 2015 Snowfall Systems, Inc.
%

classdef portfolioPlot
properties
      plotData = 0;
      realData=0;
      option=0;
      breaks=0;
      labels=0;
end
 methods
 function display(p)
plot(p)
end % disp
      end
      methods
     function plot(varargin)
p=varargin{1};
[v d] = version;
    Legend=unique(p.plotData.Legend);
    for i = 1:size(Legend,1)
         [tf1, loc1]=ismember(p.plotData.Legend',char(Legend(i,:)));
         if i ==1
        plot(p.plotData.Time(tf1(1,:)),p.plotData.Data(tf1(1,:)),'Color',util_colorScheme(i),'LineWidth',p.option.lines_size)

set(gca,'XTick',p.breaks');
set(gca,'XTickLabel',p.labels);
util_plotTheme('Title',p.option.Title,'Subtitle',p.option.Subtitle,'title_size',p.option.title_size,'base_size',p.option.base_size,'dkpanel',p.option.dkpanel,'bw',p.option.bw)
         else
hold all;
plot(p.plotData.Time(tf1(1,:)),p.plotData.Data(tf1(1,:)),'Color',util_colorScheme(i),'LineWidth',p.option.lines_size)
hold off;
         end
    end
    legend(Legend);
     end
      end
methods
function r = plus(a,b)
         r=a;
         r.realData=[a.realData;b.realData];
         Time =sortrows(unique(r.realData.Time'),1);

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
    
    % temp=Time-DateToPOSIXTime(datetime(POSIXTimeToDate(Time,'yyyy'),POSIXTimeToDate(Time,'MM'),POSIXTimeToDate(Time,'dd'),9,30,0))';
  
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
   
    [tf, loc]=ismember(r.realData.Time',Time);
    
    plotData=r.realData;
    plotData.Time(:)=loc(:);
    
r.plotData=plotData;
r.breaks=TimeStep;
    time =util_getDataFromPOSIXTime(r.realData.Time',format);
    tick_label = time(TimeStep,:);
    r.labels=tick_label;
     end
            end
end
