% Robot Connection Script
% Copyright 2018 The MathWorks, Inc.

%% Shut down connection to ROS, if any
rosshutdown

%% Connect to ROS master
% Replace with your IP address information
% Set to '' if MATLAB is on the same machine as ROS master
robotIP = '';
matlabIP = '';

% Connect to ROS master
rosinit(robotIP,'NodeHost',matlabIP)

%% Set up ROS device for code generation and deployed node access
%r = rosdevice(robotIP,'turtlebot','turtlebot');
%r.ROSFolder = '/opt/ros/kinetic';
%r.CatkinWorkspace = '~/ros/catkin_ws';

%% ROS Topics and frames

% default
ROBOT_CMD_VEL = '/cmd_vel'; 
ROBOT_ODOM = '/odom';
ROBOT_RESET_ODOM = '/reset_odometry';
ROBOT_POSE = '/amcl_pose';
LASER_SCAN = '/scan';
RGB_IMAGE = '/camera/rgb/image_raw'; 
DEPTH_IMAGE = '/camera/depth/image_raw'; 
DEPTH_POINTS = '/camera/depth_registered/points';
MAP_TOPIC = '/map';
JOINT_STATES = '/joint_states';

%
% !!! Set your platform here !!!
%
robottype = 'Turtlebot';

% Platform specific names

% Turtlebot
if (strcmp(robottype,'Turtlebot'))
    ROBOT_CMD_VEL = '/mobile_base/commands/velocity'; 
    ROBOT_ODOM = '/odom';
    ROBOT_RESET_ODOM = '/mobile_base/commands/reset_odometry';
    LASER_SCAN = '/scan';
    RGB_IMAGE = '/camera/rgb/image_raw'; 
    DEPTH_IMAGE = '/camera/depth_registered/image_raw'; 
    DEPTH_POINTS = '/camera/depth_registered/points';

% MARRtino
elseif (strcmp(robottype,'MARRtino'))
    RGB_IMAGE = '/rgb/image_raw'; 
    DEPTH_IMAGE = '/depth/image_raw'; 

% Stage simulator
elseif (strcmp(robottype,'Stage'))

end

