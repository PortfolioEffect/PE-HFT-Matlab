function [ portfolioResult ] = util_optimizationFunction( optimizer )
balans=[];
portfolio=portfolio_create(optimizer.portfolio);
symbols=portfolio_symbols(portfolio);
rebalancingTimes=portfolio_value(portfolio);
rebalancingTimes=rebalancingTimes(:,1);
set=portfolio_getSettings(portfolio);
set.resultsSamplingInterval='last';
portfolio_settings(portfolio,set);
for t = 1:length(rebalancingTimes(:))
    time=rebalancingTimes(t);
    result=portfolio.java.setToTime(util_POSIXTimeToDate(time));
        if result.hasError()
            disp(result.getErrorMessage())
            error(char(result.getErrorMessage()));
        end
optimizer_temp=optimization_goal(portfolio,optimizer.goal, optimizer.direction,optimizer.confidenceInterval);
if ~isempty(optimizer.portfolioValue)
    optimization_constraint_portfolioValue(optimizer_temp,optimizer.portfolioValue);
end
temp_list=[];
for i = 1:length(optimizer.functions)
    funct=optimizer.functions{i};
    funct_info=functions(funct);
    args=get_arg_names(funct_info.file);
    for j = 1:length(args{1})
        if j == 1
        args_data={eval(char(args{1}(j)))};
        else
       args_data=[args_data eval(char(args{1}(j)))];
        end
            end
    constraintValue=funct(args_data{:});
    optimizer_temp=optimization_constraint(optimizer_temp,optimizer.constraintTypeFunctions{i},optimizer.constraintMerticFunctions{i},double(constraintValue),optimizer.constraintConfidenceIntervalFunctions{i},optimizer.constraintSymbolsFunctions{i});
end
    if ~isempty(optimizer.constraintMerticSimple)
        for j = 1:length(optimizer.constraintMerticSimple)
            					optimizer_temp=optimization_constraint(optimizer_temp,optimizer.constraintTypeSimple{j},optimizer.constraintMerticSimple{j},optimizer.constraintValueSimple{j},optimizer.constraintConfidenceInterval{j},optimizer.constraintSymbols{j});
        end
    end
    result=optimizer_temp.java.getOptimizedPortfolio();
            if result.hasError()
            disp(result.getErrorMessage())
            error(char(result.getErrorMessage()));
        end
    portfolio_TempOptim=portfolioContainer();
    portfolio_TempOptim.java=util_getResult(result);
    temp=[];
    for i = 1:length(symbols)
            quantity=position_quantity(portfolio_TempOptim,symbols(i));
			temp=[temp,quantity(2)];
    end
    balans=[balans;temp];
    
end
disp('check')
portfolioResult=portfolioContainer();
portfolioResult.java=com.snowfallsystems.ice9.quant.client.portfolio.Portfolio(optimizer.portfolio.java);
FromTime=portfolioResult.java.getFromTime;
	for i = 1:length(symbols)
		portfolio_addPosition(portfolioResult,symbols(i),balans(:,i),'time',rebalancingTimes);
    end

end

