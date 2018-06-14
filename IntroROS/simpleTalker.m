% Introduction: Simple ROS Talker Example

% Copyright 2018 The MathWorks, Inc.

%% SETUP
% Runs the setup script provided in the 'Utilities' folder.
% You will be using this in many examples throughout the workshop.
connectToRobot;

%% INTRODUCTION TO SUBSCRIBERS

% First, open a Terminal and enter a command like the following
% rostopic pub /talker std_msgs/String "Hello from ROS" -1

% Run the following lines of code to create a subscriber
disp('Listening to /talker topic. Press Ctrl+C to stop')
mySub = rossubscriber('/talker');
rostopic echo /talker

%% INTRODUCTION TO PUBLISHERS

% Run the following lines of code to create a publisher
[talkerPub,talkerMsg] = rospublisher('/talker','std_msgs/String');

% Then, open a Terminal and enter
% rostopic echo /talker

% To create a message and send it, use the following lines
% NOTE: You can run these repeatedly
talkerMsg.Data = 'Hello from MATLAB';
send(talkerPub,talkerMsg)