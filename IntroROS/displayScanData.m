% Introduction: Display lidar scan data

% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;
[vPub,vMsg] = rospublisher(ROBOT_CMD_VEL);
scanSub = rossubscriber(LASER_SCAN);
receive(scanSub); % Do this in case no scan data has been received yet

%% Move the robot around and display scan results
vMsg.Linear.X = 0.1;
vMsg.Angular.Z = 0.5;

for idx = 1:20
    % Send velocity message
    send(vPub,vMsg);
    
    % Visualize the scan data
    plot(scanSub.LatestMessage);
    
    pause(0.5);
end