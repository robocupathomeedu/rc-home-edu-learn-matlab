% Example navigation task

% Copyright 2018-2019 The MathWorks, Inc.

%% Setup
connectToRobot;
% Create publishers and subscribers for navigation
odomSub = rossubscriber(ROBOT_ODOM);
[vPub,vMsg] = rospublisher(ROBOT_CMD_VEL);
% Reset the odometry to zero
resetOdometry;
   
%% Path planning
% First, load the presaved map
load myTestMap
inflate(map,0.2); % Optionally inflate the map to help avoid walls
show(map)

% Then, create a probabilistic roadmap (PRM)
prm = mobileRobotPRM(map);
prm.NumNodes = 300;
prm.ConnectionDistance = 2.5;

% Define a start and goal point interactively
title('STEP 1: Click on map to select start point');
startPoint = drawpoint;
startPos = startPoint.Position;
title('STEP 2: Click on map to select goal point');
goalPoint = drawpoint;
goalPos = goalPoint.Position;

% Find a path
myPath = findpath(prm,startPos,goalPos);
close all, show(prm)

%% Perform navigation using Pure Pursuit
% First, create the controller and set its parameters
pp = controllerPurePursuit;
pp.DesiredLinearVelocity = 0.2;
pp.LookaheadDistance = 0.5;
pp.Waypoints = myPath;

% Navigate until the goal is reached within threshold
show(prm); 
hold on
initPos = [startPos 0] - getRobotPose(odomSub.LatestMessage);
pose = initPos;
hPose = plot(pose(1),pose(2),'gx','MarkerSize',15,'LineWidth',2);
while norm(goalPos-pose(1:2)) > 0.1 
    % Get latest pose
    pose = initPos + getRobotPose(odomSub.LatestMessage);     
    % Run the controller
    [v,w] = pp(pose); 
    % Assign speeds to ROS message and send
    vMsg.Linear.X = v;
    vMsg.Angular.Z = w;
    send(vPub,vMsg);   
    % Plot the robot position
    delete(hPose);
    hPose = plot(pose(1),pose(2),'gx','MarkerSize',15,'LineWidth',2);
    drawnow;  
end
disp('Reached Goal!');