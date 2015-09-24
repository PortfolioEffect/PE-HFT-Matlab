% Plot style settings for PortfolioEffect theme
%
% Customizable plot style for PortfolioEffect color theme.
% 
% 
% Usage
% 
% util_plotTheme(Title,Subtitle,title_size,base_size,dkpanel, bw)
% 
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
% Void
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
% plot(data_goog(:,2));
% util_plotTheme('Title','GOOG','Subtitle','Price')

function util_plotTheme(varargin)

p = inputParser;
   defaultTitle = 'No title';
   defaultSubtitle ='No subtitle';
   defaultTitle_size = 18;
   defaultBase_size = 14;
   defaultDkpanel= false;
   defaultBw = false;
   
   addParameter(p,'Title',defaultTitle);
   addParameter(p,'Subtitle',defaultSubtitle);
   addParameter(p,'title_size',defaultTitle_size,@isnumeric);
   addParameter(p,'base_size',defaultBase_size,@isnumeric);
   addParameter(p,'dkpanel',defaultDkpanel,@islogical);
   addParameter(p,'bw',defaultBw,@islogical);
             
parse(p,varargin{:});
if strcmp(char(p.Results.Subtitle),char('No subtitle'))&&~strcmp(char(p.Results.Title),'No title')
   title({strcat('\fontsize{',num2str(p.Results.title_size),'}',char(p.Results.Title))})
elseif ~strcmp(char(p.Results.Subtitle),'No subtitle')&&~strcmp(char(p.Results.Title),'No title')
title({strcat('\fontsize{',num2str(p.Results.title_size),'}',char(p.Results.Title)),strcat('\fontsize{',num2str(p.Results.title_size/1.5),'}',char(p.Results.Subtitle))})
end
  if p.Results.bw
    bgcolors = [255/255 255/255 255/255;178/255 191/255 203/255];	
  else
    bgcolors = [213/255 228/255 235/255;195/255 214/255 223/255];	
  end

if p.Results.dkpanel
   set(gca,'Color',bgcolors(2,:));
else
   set(gca,'Color',bgcolors(1,:));
end
set(gcf,'Color',bgcolors(1,:));
set(gca,'FontSize',p.Results.base_size);
grid on
end

