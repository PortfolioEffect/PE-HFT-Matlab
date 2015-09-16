function [ portfolioResult ] = util_optimizationFunction( optimizer )
balans=[];
portfolio=portfolio_create(optimizer.portfolio);
symbols=portfolio_symbols(portfolio);
rebalancingTimes=portfolio_value(portfolio);
rebalancingTimes=rebalancingTimes(:,1);
set=portfolio_getSettings(portfolio);
set.resultsSamplingInterval='last';
portfolio_settings(portfolio,set);
% 
% for i = 1:length(symbols)
%     quantity=position_quantity(optimizer.portfolio,symbols(i));
%     balans=[balans,quantity(2)];
% end
% portfolio=portfolioContainer();
% portfolio.java=com.snowfallsystems.ice9.quant.client.portfolio.Portfolio(optimizer.portfolio.java);
for time = rebalancingTimes
%     result=portfolioContainer.setToTime(util_POSIXTimeToDate(time));
%         if result.hasError()
%             disp(result.getErrorMessage())
%             error(char(result.getErrorMessage()));
%         end
optimizer_temp=optimization_goal(portfolio,optimizer.portfolioValue,optimizer.goal, optimizer.direction,optimizer.confidenceInterval);
temp_list=[];
for i = 1:length(optimizer.functions)
    funct=optimizer.functions{i};
    constraintValue=funct(portfolio,time);
    optimizer_temp=optimization_constraint(optimizer_temp,[],optimizer.constraintTypeFunctions{i},optimizer.constraintMerticFunctions{i},as.double(constraintValue),optimizer.constraintConfidenceIntervalFunctions{i},optimizer.constraintSymbolsFunctions{i});
end
    if ~isempty(optimizer.constraintMerticSimple)
        for j = 1:length(optimizer.constraintMerticSimple)
            					optimizer_temp=optimization_constraint(optimizer_temp,[],optimizer.constraintTypeSimple{j},optimizer.constraintMerticSimple{j},optimizer.constraintValueSimple{j},optimizer.constraintConfidenceInterval{j},optimizer.constraintSymbols{j});
        end
    end
    result=optimizer_temp.java.getOptimizedPortfolio();
            if result.hasError()
            disp(result.getErrorMessage())
            error(char(result.getErrorMessage()));
        end
    portfolio_TempOptim=portfolioContainer();
    portfolio_TempOptim.java=result.getResult;
    temp=[];
    for i = 1:length(symbols)
            quantity=position_quantity(portfolio_TempOptim,symbols(i));
			temp=[temp,quantity(2)];
    end
    balans=[balans;temp];
    
end
portfolioResult=portfolioContainer();
portfolioResult.java=com.snowfallsystems.ice9.quant.client.portfolio.Portfolio(optimizer.portfolio.java);
FromTime=portfolioResult.java.getFromTime;
	for i = 1:length(symbols)
		portfolio_addPosition(portfolioResult,symbols(i),balans(i,:),[FromTime,util_POSIXTimeToDate(optimizer.rebalancingTimes)]);
    end

end

