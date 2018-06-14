% Manipulation algorithm test script

% Copyright 2018 The MathWorks, Inc.

%% Load the robot description
load manipDescriptions
robot = tbArm; % TurtleBot Arm
% robot = pincher; % PhantomX Pincher

%% Inverse kinematics
% The end effector is at gripper_link (body index 24)
targetPos = [0.1 0.15 0.25];
targetTform = trvec2tform(targetPos);
ik = robotics.InverseKinematics('RigidBodyTree',robot);
weights = [0.0 0.0 0 1 1 1];
initGuess = robot.homeConfiguration;
[ikSoln,ikInfo] = ik('gripper_link',targetTform,weights,initGuess);

%% Display IK solution
actualTform = getTransform(robot,ikSoln,'gripper_link');
actualPos = tform2trvec(actualTform)
posError = ikInfo.PoseErrorNorm
iters = ikInfo.Iterations
show(robot,ikSoln,'Frames','off');
hold on;
plot3(targetPos(1),targetPos(2),targetPos(3),...
      'ro','MarkerSize',12,'LineWidth',2);
  
%% Repeat the process for an entire trajectory
hold off
initGuess = robot.homeConfiguration;
startPoint = tform2trvec(getTransform(robot,initGuess,'gripper_link'));
waypoints = [startPoint; ...
             0.3 0.0 0.0; ...
             0.2 0.2 -0.05; ...
             0.0 0.3 0.15; ...
             0.1 0.1 0.2];
    
% Create trajectory
numSteps = 5; 
numPts = numSteps*(size(waypoints,1)-1) + 1;
traj = createTrajectory(waypoints,numPts,'spline');

% Loop through trajectory and solve IK
for idx = 1:numPts
    targetPos = traj(idx,:);
    targetTform = trvec2tform(targetPos);
    ikSoln = ik('gripper_link',targetTform,weights,initGuess);
    initGuess = ikSoln;

    % Plot the solution
    clf
    show(robot,ikSoln,'Frames','off');
    plotTrajectory(waypoints,traj,false);
    hold off
    drawnow
end