% Robot Connection Script
% Copyright 2018 The MathWorks, Inc.

%% Shut down connection to ROS, if any
rosshutdown

%% Connect to ROS master
% Replace with your IP address information
% Set to '' if MATLAB is on the same machine as ROS master
robotIP = '192.168.0.30';
matlabIP = '192.168.0.205';

% Connect to ROS master
rosinit(robotIP,'NodeHost',matlabIP)

%% Set up ROS device for code generation and deployed node access
%r = rosdevice(robotIP,'turtlebot','turtlebot');
%r.ROSFolder = '/opt/ros/kinetic';
%r.CatkinWorkspace = '~/ros/catkin_ws';

%% ROS Topics and frames

% ROBOT_CMD_VEL = '/mobile_base/commands/velocity'; % Turtlebot
ROBOT_CMD_VEL = '/cmd_vel'; % MARRtino
ROBOT_ODOM = '/odom';

LASER_SCAN = '/scan';

RGB_IMAGE = '/camera/rgb/image_raw'; % Turtlebot
DEPTH_IMAGE = '/camera/depth_registered/image_raw'; % Turtlebot
RGB_IMAGE = '/rgb/image_raw'; % MARRtino
DEPTH_IMAGE = '/depth/image_raw'; % MARRtino

