% Example Manipulation task using ROS interface to Dynamixel motors

% Copyright 2018-2019 The MathWorks, Inc.

%% Setup
% First, you must start the manipulation node
% roslaunch rchomeedu_arm arm.launch
connectToRobot;
% Create publishers and subscribers
jointNames = {'waist','shoulder','elbow','wrist','hand'};
numJoints = numel(jointNames);
for idx = 1:numJoints
    jSub(idx) = rossubscriber(['/' jointNames{idx} '_controller/state']);
    [jPub(idx),jMsg(idx)] = rospublisher(['/' jointNames{idx} '_controller/command']);
end
% Load robot description
load manipDescriptions
robot = tbArm;
robot.DataFormat = 'column'; % Change data format to make ROS interface easier

%% Get initial joint position and do forward kinematics
close all
jPos = zeros(6,1); % Needs to account for extra "fake" gripper joint
for idx = 1:numJoints
    jPos(idx) = jSub(idx).LatestMessage.CurrentPos;
end
tform = getTransform(robot,jPos,'gripper_link');
eePos = tform2trvec(tform);
fprintf('Starting gripper position is [%.2f %.2f %.2f]\n',eePos(1),eePos(2),eePos(3));

%% Compute a trajectory
close all
startPoint = eePos;
% NOTE: These waypoints assume you start the arm straight upwards
waypoints = [startPoint; 
          0.1 0 0.3; 
          0.1 0.1 0.3 ;
          startPoint];
    
% Create trajectory
numSteps = 100; 
totalTime = 15;
numPts = numSteps*(size(waypoints,1)-1) + 1;
traj = trapveltraj(waypoints',numSteps, ...
    'EndTime',totalTime/(size(waypoints,1)-1));

% Plot the solution
show(robot,jPos,'Frames','off');
plotTrajectory(waypoints,traj,false);
hold off

%% Navigate a trajectory
% Create IK solver
ik = inverseKinematics('RigidBodyTree',robot);
ik.SolverParameters.MaxIterations = 50;
weights = [0 0 0 1 1 1];
initGuess = jPos;

% Loop through trajectory and solve IK
disp('Starting trajectory...')
for idx = 1:size(traj,2)
    targetPos = traj(:,idx)';
    targetTform = trvec2tform(targetPos);
    ikSoln = ik('gripper_link',targetTform,weights,initGuess);
    initGuess = ikSoln;

    % Publish the joint angles
    for jIdx = 1:numJoints
        jMsg(jIdx).Data = ikSoln(jIdx);
        send(jPub(jIdx),jMsg(jIdx));
    end
        
    pause(totalTime/numSteps);

end

disp('Done.')