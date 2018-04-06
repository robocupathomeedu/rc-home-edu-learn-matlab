% TurtleBot Arm Rigid Body Tree Creation

% NOTE: This script requires the turtlebot_arm_description folder from
% https://github.com/turtlebot/turtlebot_arm

% If you have command-line Git installed on your system, 
% uncomment and run the following line:
% !git clone https://github.com/turtlebot/turtlebot_arm

% Copyright 2018 The MathWorks, Inc.

%% Import TurtleBot arm
tbArm = importrobot('turtlebot_arm.urdf');
show(tbArm);

%% Import PhantomX Pincher arm
pincher = importrobot('pincher_arm.urdf'); 
pincher = pincher.subtree(pincher.BodyNames{2}); % Remove extra base link
show(pincher);

%% Save rigid body trees to MAT-file
% For convenience, these MAT-files have been provided
save manipDescriptions tbArm pincher