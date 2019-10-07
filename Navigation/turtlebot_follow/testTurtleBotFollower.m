% Test TurtleBot follower control using services

% Copyright 2019 The MathWorks, Inc.

%% Setup
% NOTE: Requires ROS master on TurtleBot to run the following follower node
%       roslaunch rchomeedu_follower follower2.launch
connectToRobot;
[followSvc,followMsg] = rossvcclient('/turtlebot_follower/change_state');

%% Enable the follower
followMsg.State = followMsg.FOLLOW; 
call(followSvc,followMsg);

%% Disable the follower
followMsg.State = followMsg.STOPPED;
call(followSvc,followMsg);