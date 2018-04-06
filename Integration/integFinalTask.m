% Final integrated task for RoboCup@Home Education

% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;

%% Wait for valid speech command and set target location and object
integSpeech;

%% Navigate to target location
integNavigation;

%% Search for target object
integVision;

%% Grasp target object
integManipulation;