function [ result ] = util_getDataFromPOSIXTime( data,format )
result=[];
for formats = format
    if any(ismember(formats,{':','/'}))
        result=strcat(result,formats);
    else
   result=strcat(result,num2str(util_POSIXTimeToDate(int64(data),formats),strcat('%',num2str(length(char(formats))),'.',num2str(length(char(formats))),'d')));
    end
end
end

