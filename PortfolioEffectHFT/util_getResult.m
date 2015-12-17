function [ result ] = util_getResult( data )
                if data.hasError()
            disp(data.getErrorMessage())
            error(char(data.getErrorMessage()));
                end
                result=[];
                dataNames=data.getDataNames();
                for i = 1:length(dataNames)
        dataName=char(dataNames(i));
		dataType=char(data.getDataType(dataName));
         switch dataType
   case 'DOUBLE'
       result=[result,double(data.getDouble(dataName))];
   case 'DOUBLE_VECTOR'
       result=[result,double(data.getDoubleArray(dataName))];     
   case 'DOUBLE_MATRIX'
       result=[result,double(data.getDoubleMatrix(dataName))];     
   case 'INT_VECTOR'
       result=[result,int16(data.getIntArray(dataName))];       
   case 'LONG_VECTOR'
       result=[result,double(data.getLongArray(dataName))];       
   case 'STRING_VECTOR'
 result=dataset(result,char(data.getStringArray(dataName)));    
        if(size(result)==0)
set(result,'VarNames',{dataName})
       else
set(result,'VarNames',{namesTemp,dataName})    
end
       
   case 'PORTFOLIO'
       result=data.getPortfolio(dataName);       
         end
    end
end

