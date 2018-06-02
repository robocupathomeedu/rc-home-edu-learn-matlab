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

robottype = 'Turtlebot';

% Turtlebot
if (strcmp(robottype,'Turtlebot')
    ROBOT_CMD_VEL = '/mobile_base/commands/velocity'; 
    ROBOT_ODOM = '/odom';
    LASER_SCAN = '/scan';
    RGB_IMAGE = '/camera/rgb/image_raw'; 
    DEPTH_IMAGE = '/camera/depth_registered/image_raw'; 


% MARRtino
elseif (strcmp(robottype,'MARRtino')
    ROBOT_CMD_VEL = '/cmd_vel'; 
    ROBOT_ODOM = '/odom';
    LASER_SCAN = '/scan';
    RGB_IMAGE = '/rgb/image_raw'; 
    DEPTH_IMAGE = '/depth/image_raw'; 

% default
else
    ROBOT_CMD_VEL = '/cmd_vel'; 
    ROBOT_ODOM = '/odom';
    LASER_SCAN = '/scan';
    RGB_IMAGE = '/camera/rgb/image_raw'; 
    DEPTH_IMAGE = '/camera/depth/image_raw'; 

end

