%% Test script for Service Robot Logic chart
% Copyright 2019 The MathWorks, Inc.

% Initialize service robot logic chart
connectToRobot
chart = serviceRobotLogic;

% Continue stepping the chart until the 'Stop' state is reached
while(any(contains(getActiveStates(chart),'Stop')))
    step(chart);
end