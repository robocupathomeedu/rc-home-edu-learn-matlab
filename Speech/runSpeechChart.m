%% Test script for Speech chart
% Copyright 2019 The MathWorks, Inc.

% Initialize speech chart
connectToRobot
chart = speechChart;

% Continue stepping the chart until the 'Stop' state is reached
while(~any(contains(getActiveStates(chart),'Stop')))
    step(chart);
end