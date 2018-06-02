% Example Manipulation task using ROS interface to Dynamixel motors

% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;
% Create publishers and subscribers
jointSub = rossubscriber(JOINT_STATES);
jointNames = {'arm_shoulder_pan_joint', ...
              'arm_shoulder_lift_joint', ...
              'arm_elbow_flex_joint', ... 
              'arm_wrist_flex_joint', ...
              'gripper_joint'};
numJoints = numel(jointNames);
for idx = 1:numJoints
    topicName = ['/' jointNames{idx} '/command'];
    [jPub(idx),jMsg(idx)] = rospublisher(topicName);
end
% Load robot description
load manipDescriptions
robot = tbArm; % TurtleBot Arm
% robot = pincher; % PhantomX Pincher

robot.DataFormat = 'column'; % Change data format to make ROS interface easier

%% Get joint positions and do forward kinematics
close all
jPos = zeros(6,1); % Needs to account for extra "fake" gripper joint
received = false;
while ~received
    jPosMsg = receive(jointSub);
    if numel(jPosMsg.Position) == numJoints
        received = true;
    end
end
for idx = 1:numJoints
    for jIdx = 1:numJoints
        if strcmp(jPosMsg.Name(idx),jointNames{jIdx})
            jPos(jIdx) = jPosMsg.Position(idx);
            continue;
        end
    end
end
tform = getTransform(robot,jPos,'gripper_link');
eePos = tform2trvec(tform)

%% Compute a trajectory
close all
startPoint = eePos;
waypoints = [startPoint; ...
             0.0 0.0 0.3; ...
             0.1 0.1 0.15; ...
             -0.1 0.1 0.2; ...
             -0.1 -0.1 0.15; ...
             startPoint];
    
% Create trajectory
numSteps = 20; 
numPts = numSteps*(size(waypoints,1)-1) + 1;
traj = createTrajectory(waypoints,numPts,'spline');

% Plot the solution
show(robot,jPos,'Frames','off');
plotTrajectory(waypoints,traj,false);
hold off

%% Navigate a trajectory
% Create IK solver
ik = robotics.InverseKinematics('RigidBodyTree',robot);
ik.SolverParameters.MaxIterations = 100;
weights = [0 0 0 1 1 1];
initGuess = jPos;

% Loop through trajectory and solve IK
disp('Starting trajectory...')
for idx = 1:numPts
    targetPos = traj(idx,:);
    targetTform = trvec2tform(targetPos);
    ikSoln = ik('gripper_link',targetTform,weights,initGuess);
    initGuess = ikSoln;

    % Publish the joint angles
    for jIdx = 1:numJoints
        jMsg(jIdx).Data = ikSoln(jIdx);
        send(jPub(jIdx),jMsg(jIdx));
    end
        
    pause(0.1);

end

disp('Done.')