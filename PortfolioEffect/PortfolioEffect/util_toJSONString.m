function [ result ] = util_toJSONString( x )
result='{';
t=0;
names=fieldnames(x);
for i = 1:length(names)
t=t+1;
if isnumeric(x.(names{i}))
    x.(names{i})=num2str(x.(names{i}));
end
if t<=1
    result=strcat(result,'"',names(i),'"',':','"',x.(names{i}),'"');
else
    result=strcat(result,',"',names(i),'"',':','"',x.(names{i}),'"');
end
end
 result=strcat(result,'}');
end
