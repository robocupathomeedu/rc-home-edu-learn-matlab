% Helper script that resets odometry

% Copyright 2018 The MathWorks, Inc.

odomResPub = rospublisher(ROBOT_RESET_ODOM);
odomResetMsg = rosmessage('std_msgs/Empty');
send(odomResPub, odomResetMsg)