% Robot Connection Script
% Copyright 2018 The MathWorks, Inc.

%% Shut down connection to ROS, if any
rosshutdown

%% Connect to ROS master
% Replace with your IP address information
% Set to '' if MATLAB is on the same machine as ROS master
robotIP = '192.168.119.129';
matlabIP = '';

% Connect to ROS master
rosinit(robotIP,'NodeHost',matlabIP)

%% Set up ROS device object for code generation, deployed node access, 
%  and shell access for system commands
%  NOTE: You only need to do this if your MATLAB and ROS machines are
%  different and connected over the network.

%r = rosdevice(robotIP,'turtlebot','turtlebot');
%r.ROSFolder = '/opt/ros/kinetic';
%r.CatkinWorkspace = '~/ros/catkin_ws';

%% ROS Topics and frames
ROBOT_CMD_VEL = '/cmd_vel'; 
ROBOT_ODOM = '/odom';
ROBOT_RESET_ODOM = '/reset_odometry';
ROBOT_POSE = '/amcl_pose';
LASER_SCAN = '/scan';
RGB_IMAGE = '/camera/rgb/image_raw'; 
DEPTH_IMAGE = '/camera/depth/image_raw'; 
DEPTH_POINTS = '/camera/depth_registered/points';
MAP_TOPIC = '/map';
MAP_FRAME = '/map';
JOINT_STATES = '/joint_states';
MOVE_BASE_ACTION = '/move_base';


%
% !!! Set your platform here !!!
%
robottype = 'TurtleBot';

% Platform specific names

% TurtleBot
switch lower(robottype) %  Use lowercase so it's case insensitive
    case 'turtlebot'
        ROBOT_CMD_VEL = '/mobile_base/commands/velocity'; 
        ROBOT_ODOM = '/odom';
        ROBOT_RESET_ODOM = '/mobile_base/commands/reset_odometry';
        LASER_SCAN = '/scan';
        RGB_IMAGE = '/camera/rgb/image_raw'; 
        DEPTH_IMAGE = '/camera/depth_registered/image_raw'; 
        DEPTH_POINTS = '/camera/depth_registered/points';

% MARRtino
    case 'marrtino'
        RGB_IMAGE = '/rgb/image_raw'; 
        DEPTH_IMAGE = '/depth/image_raw'; 

% Stage simulator
    case 'stage'

end