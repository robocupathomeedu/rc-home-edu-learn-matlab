%% Path planning algorithm test script

% Copyright 2018 The MathWorks, Inc.

%% Load and show the map
load myMapsV3
close all
show(map)
hold on

%% Interactively select points
title('STEP 1: Click on map to select start point');
startPoint = impoint;
startPos = getPosition(startPoint);
title('STEP 2: Click on map to select goal point');
goalPoint = impoint;
goalPos = getPosition(goalPoint);

%% Create a probabilistic roadmap (PRM)
prm = robotics.PRM(map);
prm.NumNodes = 300;
prm.ConnectionDistance = 2.5;

%% Find a path from start to end
myPath = findpath(prm,startPos,goalPos);
show(prm)