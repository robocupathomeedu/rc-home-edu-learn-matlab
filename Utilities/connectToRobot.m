% Robot Connection Script
% Copyright 2018-2019 The MathWorks, Inc.

%% Shut down connection to ROS, if any
rosshutdown

%% Connect to ROS master
% Replace with your ROS configuration
configName = 'myTopicConfig';
load(configName);

% Set environment variables
if ~isempty(matlabIP)
    setenv('ROS_IP',matlabIP);
end
if ~isempty(robotIP)
    setenv('ROS_MASTER_URI',"http://" + robotIP + ":11311");
end

% Connect to ROS master
rosinit(robotIP,'NodeHost',matlabIP)

%% Set up ROS device object for code generation, deployed node access, 
%  and shell access for system commands
%  NOTE: You only need to do this if your MATLAB and ROS machines are
%  different and connected over the network.

%r = rosdevice(robotIP,'turtlebot','turtlebot');
%r.ROSFolder = '/opt/ros/kinetic';
%r.CatkinWorkspace = '~/ros/catkin_ws';
