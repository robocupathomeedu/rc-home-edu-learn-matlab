% Helper script that resets odometry

% Copyright 2018 The MathWorks, Inc.

odomResPub = rospublisher('/mobile_base/commands/reset_odometry');
odomResetMsg = rosmessage('std_msgs/Empty');
send(odomResPub, odomResetMsg)