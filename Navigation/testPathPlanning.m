%% Path planning algorithm test script

% Copyright 2018-2019 The MathWorks, Inc.

%% Load and show the map
load myMapsV3
close all
show(map)
hold on

%% Interactively select points
title('STEP 1: Click on map to select start point');
startPoint = drawpoint;
startPos = startPoint.Position;
title('STEP 2: Click on map to select goal point');
goalPoint = drawpoint;
goalPos = goalPoint.Position;

%% Create a probabilistic roadmap (PRM)
inflate(map,0.2); % Optionally inflate the map to help avoid walls
prm = mobileRobotPRM(map);
prm.NumNodes = 300;
prm.ConnectionDistance = 2.5;

%% Find a path from start to end
myPath = findpath(prm,startPos,goalPos);
show(prm)