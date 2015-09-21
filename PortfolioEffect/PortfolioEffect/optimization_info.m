function [] = optimization_info( portfolio )
if ~isempty(portfolio.optimization_info)
    nFunctionExecute=str2double(portfolio.optimization_info(1));
    nGlobalStart=str2double(portfolio.optimization_info(2));
    nLocalSolution=str2double(portfolio.optimization_info(3));
    nOptimizations=str2double(portfolio.optimization_info(4));
    nConstraintSatisfied=str2double(portfolio.optimization_info(5));  
    
    disp(['Total number of calls to optimization goal method ',num2str(nFunctionExecute)]);
    disp(['Total number of search paths of the optimization algorithm ',num2str(nGlobalStart)]);
    disp(['Total number of times all optimization constraints were satisfied ',num2str(nConstraintSatisfied)]);
    disp(['Total number of local optima found by the optimization algorithm ',num2str(nLocalSolution)]);
    disp(['Total number of optimizations ',num2str(nOptimizations)]);
    disp(['Average number of calls to optimization goal method per optimization step ',num2str(round(nFunctionExecute/nOptimizations,3))]);
    disp(['Average number of search paths of the optimization algorithm per optimization step ',num2str(round(nGlobalStart/nOptimizations,3))]);
    disp(['Average number of times all optimization constraints were satisfied per optimization step ',num2str(round(nConstraintSatisfied/nOptimizations,3))]);
    disp(['Average number of local optima found by the optimization algorithm per optimization step ',num2str(round(nLocalSolution/nOptimizations,3))]);
    disp(['Total number of local optima skipped by the optimization algorithm ',num2str(	nLocalSolution-nOptimizations)]);
    disp(['Average number of search path per local optimum (the lower, the better) ',num2str(round(nGlobalStart/nLocalSolution,3))]);
    disp(['Average number of local optima skipped by the optimization algorithm per optimization step ',num2str(round((nLocalSolution-nOptimizations)/nOptimizations,3))]);
    
else
    error('given portfolio is not produced by optimization_run() method');
end
end

