function [ optimizer ] = setForecastTimeStep( optimizer,timeStep )
if isnumeric(timeStep)
		timeStep=strcat(timeStep,'s');
end
	optimizer.forecastTimeStep=timeStep;
end