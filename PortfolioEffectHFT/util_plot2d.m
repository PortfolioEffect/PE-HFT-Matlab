% Line plot of portfolio metric (for a time series)
%
% Draws a new line plot using a time series of metric values.
%
%
% Usage
%
% util_plot2d(metric,legend,Title,Subtitle,font_size,line_size,dkpanel,bw)
%
%
% metric
%        Time series  of (time, value) returned by metric functions.*
%
% legend
%        Plot legend.*
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
% util_plot2d(position_sortinoRatio(portfolioExample,'GOOG',0.05),'Position Sortino Ratio GOOG','Title','Position Sortino Ratio')
function [plot] = util_plot2d(metric,legend,varargin)
p = inputParser;
%    defaultLegend='';
defaultTitle = cellstr('No title');
defaultSubtitle =cellstr('No subtitle');
defaultTitle_size = 18;
defaultLines_size = 1.5;
defaultBase_size = 14;
defaultDkpanel= false;
defaultBw = false;
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

Data=metric(:,2);
Time=metric(:,1);
Legend=repmat(cellstr(legend), length(Data), 1);
plotData=dataset(Data,Time,Legend);
plot=util_plot2df('Data~Time',plotData,'Title',p.Results.Title,'Subtitle',p.Results.Subtitle,'title_size',p.Results.title_size,'lines_size',p.Results.lines_size,'base_size',p.Results.base_size,'dkpanel',p.Results.dkpanel,'bw',p.Results.bw);
end

