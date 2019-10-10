% Manipulation algorithm test script

% Copyright 2018-2019 The MathWorks, Inc.

%% Load the robot description
load manipDescriptions
robot = tbArm; % TurtleBot Arm
% robot = pincher; % PhantomX Pincher
robot.DataFormat = 'row';

%% Inverse kinematics
% The end effector is at body "gripper_link"
targetPos = [0.1 0.15 0.25];
targetTform = trvec2tform(targetPos);
ik = inverseKinematics('RigidBodyTree',robot);
weights = [0.0 0.0 0 1 1 1];
initGuess = robot.homeConfiguration;
[ikSoln,ikInfo] = ik('gripper_link',targetTform,weights,initGuess);

%% Display IK solution
actualTform = getTransform(robot,ikSoln,'gripper_link');
actualPos = tform2trvec(actualTform)
posError = ikInfo.PoseErrorNorm
iters = ikInfo.Iterations
show(robot,ikSoln,'Frames','off');
hold on
plot3(targetPos(1),targetPos(2),targetPos(3),...
      'ro','MarkerSize',12,'LineWidth',2);
  
%% Repeat the process for an entire trajectory
hold off
initGuess = robot.homeConfiguration;
startPoint = tform2trvec(getTransform(robot,initGuess,'gripper_link'));
waypoints = [startPoint; 
          0.1 0 0.3; 
          0.1 0.1 0.3 ;
          startPoint];
    
% Create trajectory
numSteps = 31; 
numPts = numSteps*(size(waypoints,1)-1) + 1;
traj = trapveltraj(waypoints',numSteps,'EndTime',5);

%% Loop through trajectory and solve IK
ikSolns = zeros(size(traj,2),numel(robot.homeConfiguration));
for idx = 1:size(traj,2)
    targetPos = traj(:,idx)';
    targetTform = trvec2tform(targetPos);
    ikSoln = ik('gripper_link',targetTform,weights,initGuess);
    initGuess = ikSoln;

    % Plot the solution
    show(robot,ikSoln,'Frames','off','PreservePlot',false);
    plotTrajectory(waypoints,traj,false);
    drawnow
    
    % Package the solution into the array
    ikSolns(idx,:) = ikSoln;
end

%% Plot the IK solutions
figure
for idx = 1:4
    subplot(2,2,idx)
    plot(ikSolns(:,idx))
    title(['IK Solution for Joint ' num2str(idx)])
    ylabel('Angle [rad]')
    xlabel('Step number')
end