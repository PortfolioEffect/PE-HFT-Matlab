function [optimizer] = optimization_constraint(optimizer,constraintType,constraintMertic,constraintValue,confidenceInterval,symbols)
    switch constraintType
    case '='
        constraintTypeFinal='equals';
    case '>='
        constraintTypeFinal='greaterOrEquals';
    case '<='
        constraintTypeFinal='lessOrEquals';
    case 'equals'
        constraintTypeFinal='equals';
    case 'greaterOrEquals'
        constraintTypeFinal='greaterOrEquals';
    case 'lessOrEquals'
        constraintTypeFinal='lessOrEquals';
    end
    if isa(constraintValue, 'char')
        constraintValue=str2func(constraintValue);
    end
if isa(constraintValue, 'function_handle')
		optimizer.constraintMerticFunctions=[optimizer.constraintMerticFunctions,{constraintMertic}];
		optimizer.constraintTypeFunctions=[optimizer.constraintTypeFunctions,{constraintTypeFinal}];
		optimizer.functions=[optimizer.functions,{constraintValue}];
		optimizer.constraintConfidenceIntervalFunctions=[optimizer.constraintConfidenceIntervalFunctions,{confidenceInterval}];
		optimizer.constraintSymbolsFunctions=[optimizer.constraintSymbolsFunctions,{symbols}];
else
    if size(constraintValue,2)==2
                   switch constraintMertic
    case 'BETA'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)));
    case 'POSITION_WEIGHT'
                    optimizer.java.addPositionConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)),symbols);
    case 'POSITION_ALL_WEIGHT'
                optimizer.java.addPositionConstraint('POSITION_WEIGHT',constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)));
    case 'RETURN'
       optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)));
    case 'EXPECTED_RETURN'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)));
    case 'VARIANCE'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)));
    case 'SHARPE_RATIO'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)));
            case 'MODIFIED_SHARPE_RATIO'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)),double(confidenceInterval));
            case 'STARR_RATIO'
       optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)),double(confidenceInterval));
            case 'VAR'
       optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)),double(confidenceInterval));
            case 'CVAR'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)),double(confidenceInterval));
            case 'POSITIONS_SUM_ABS_WEIGHT'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue(:,2)),int64(constraintValue(:,1)),symbols);
    end
    else
           switch constraintMertic
    case 'BETA'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue));
    case 'POSITION_WEIGHT'
        optimizer.java.addPositionConstraint(constraintMertic,constraintTypeFinal,double(constraintValue),symbols);
    case 'POSITION_ALL_WEIGHT'
        optimizer.java.addPositionConstraint('POSITION_WEIGHT',constraintTypeFinal,double(constraintValue));
    case 'RETURN'
       optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue));
    case 'EXPECTED_RETURN'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue));
    case 'VARIANCE'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue));
    case 'SHARPE_RATIO'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue));
            case 'MODIFIED_SHARPE_RATIO'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue),double(confidenceInterval));
            case 'STARR_RATIO'
       optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue),double(confidenceInterval));
            case 'VAR'
       optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue),double(confidenceInterval));
            case 'CVAR'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue),double(confidenceInterval));
            case 'POSITIONS_SUM_ABS_WEIGHT'
        optimizer.java.addPortfolioConstraint(constraintMertic,constraintTypeFinal,double(constraintValue),symbols);
    end
    end
        optimizer.constraintValueSimple=[optimizer.constraintValueSimple,{constraintValue}];
		optimizer.constraintMerticSimple=[optimizer.constraintMerticSimple,{constraintMertic}];
		optimizer.constraintTypeSimple=[optimizer.constraintTypeSimple,{constraintTypeFinal}];
		optimizer.constraintConfidenceInterval=[optimizer.constraintConfidenceInterval,{confidenceInterval}];
		optimizer.constraintSymbols=[optimizer.constraintSymbols,{symbols}];
end
end