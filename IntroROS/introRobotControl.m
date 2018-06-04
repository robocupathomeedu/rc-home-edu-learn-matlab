% Introduction: Controlling the TurtleBot

% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;

%% View the list of topics and drill into the odometry topic
rostopic list
rostopic info /odom
% rostopic echo /odom % Ctrl+C to stop this

%% Create velocity publisher and send velocity commands
[vPub,vMsg] = rospublisher(ROBOT_CMD_VEL);
vMsg.Linear.X = 0.1;
vMsg.Angular.Z = 0.5;
send(vPub,vMsg);

%% Create odometry subscriber and view the results
odomSub = rossubscriber(ROBOT_ODOM);
odomMsg = receive(odomSub);

numSteps = 20; % Number of loop iterations
posData = zeros(numSteps,3);
for idx = 1:numSteps
    % Send velocity message
    send(vPub,vMsg);
    % Extract the odometry data
    odomMsg = odomSub.LatestMessage;
    posData(idx,:) = getRobotPose(odomMsg);
    pause(0.5);
end
% Visualize the data
plot(posData(:,1),posData(:,2),'bo-');
title('Robot Motion')
axis equal