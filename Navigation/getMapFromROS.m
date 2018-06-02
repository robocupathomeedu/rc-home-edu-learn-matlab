% Receive, show, and save the latest map from the /map topic
% Assumes you are using a gmapping tutorial like this one:
% http://wiki.ros.org/turtlebot_navigation/Tutorials/indigo/Build%20a%20map%20with%20SLAM

% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;
mapSub = rossubscriber(MAP_TOPIC);

%% Receive a map message and convert it to an occupancy grid
mapMsg = receive(mapSub);
map = readOccupancyGrid(mapMsg);
show(map)

%% Optionally, save the map to a file for future use
saveMapToFile(map);