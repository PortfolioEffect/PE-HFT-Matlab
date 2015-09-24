function [ result ] = position_metric(portfolio,varargin )
if ~util_validateConnection()
    return;
end
len=length(varargin);
data=struct();
if(len==0) return; end
i=1;
while(i<=len)
    if(isstruct(varargin{i}))
        data=mergestruct(data,varargin{i});
    elseif(ischar(varargin{i}) && i<len)
        data.(varargin{i})=varargin{i+1};
        i=i+1;
    else
        error('input must be in the form of ...,''name'',value,... pairs or structs');
    end
    i=i+1;
end

if ~isfield(data,'position')
    data.position='no';
end
if strcmp(data.position,'all')
    set=portfolio_getSettings(portfolio);
    if strcmp(set.resultsSamplingInterval,'last')
        data=rmfield(data,'position');
        data.value=data.metric;
        data.metric='POSITION_MATRIX';
        resultTemp=portfolio.java.getMetric(util_toJSONString(data));
     result=util_getResult(resultTemp);
    else
        result=[];
        symbols=portfolio_symbols(portfolio);
        portfolio.java.startBatch();
        		for i = 1:length(symbols)
data.position=symbols(i);
portfolio.java.getMetric(util_toJSONString(data));
                end
                        portfolio.java.finishBatch();
                               		for i = 1:length(symbols)
data.position=symbols(i);
        resultTemp=portfolio.java.getMetric(util_toJSONString(data));
     result=[result,double(resultTemp.getDoubleArray('value'))];
                                    end
    result=[double(resultTemp.getLongArray('time')),result];
    end
else
    if strcmp(data.position,'no')
                data=rmfield(data,'position');
    end
        resultTemp=portfolio.java.getMetric(util_toJSONString(data));
     result=util_getResult(resultTemp);
end
end

