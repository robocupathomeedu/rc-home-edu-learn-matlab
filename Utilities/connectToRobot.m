% Robot Connection Script
% Copyright 2018 The MathWorks, Inc.

%% Shut down connection to ROS, if any
rosshutdown

%% Connect to ROS master
% Replace with your IP address information
% Set to '' if MATLAB is on the same machine as ROS master
robotIP = '172.31.28.38';

% OPTIONAL: Set environment variable to IP address of machine with ROS master
%setenv('ROS_IP','172.31.28.239')

% OPTIONAL: Set environment variable to URI of ROS master
%setenv('ROS_MASTER_URI','http://172.31.28.38:11311');

% Connect to ROS master
rosinit(robotIP)

%% Set up ROS device for code generation and deployed node access
r = rosdevice(robotIP,'turtlebot','turtlebot');
r.ROSFolder = '/opt/ros/kinetic';
r.CatkinWorkspace = '~/mw_catkin_ws';