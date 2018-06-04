% Final task: Navigation

% Copyright 2018 The MathWorks, Inc.

%% Setup
% Create publishers and subscribers for navigation
odomSub = rossubscriber(ROBOT_ODOM);
[vPub,vMsg] = rospublisher(ROBOT_CMD_VEL);
% Reset the odometry to zero
resetOdometry;
pause(1);
   
%% Path planning
% First, load the presaved map
load myMapsV3

% Then, create a probabilistic roadmap (PRM)
prm = robotics.PRM(map);
prm.NumNodes = 300;
prm.ConnectionDistance = 2.5;

% Retrieve the start point
pose = getRobotPose(receive(odomSub));
startPoint = pose(1:2);

% Find a path from start to goal
% NOTE: The goal point is defined from the previous task
myPath = findpath(prm,startPoint,goalPoint);
show(prm)

%% Perform navigation using Pure Pursuit
% First, create the controller and set its parameters
pp = robotics.PurePursuit;
pp.DesiredLinearVelocity = 0.2;
pp.LookaheadDistance = 0.5;
pp.Waypoints = myPath;

% Navigate until the goal is reached within threshold
show(prm); 
hold on
hPose = plot(pose(1),pose(2),'gx','MarkerSize',15,'LineWidth',2);
while norm(goalPoint-pose(1:2)) > 0.1 
    % Get latest pose
    pose = getRobotPose(odomSub.LatestMessage);     
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

%% Cleanup
disp('Navigation task complete!');
clear odomSub
close all