function pose = getRobotPose(odomMsg)
% Helper function that extracts pose from odometry message

% Copyright 2018 The MathWorks, Inc.

    % Unwrap position
    position = odomMsg.Pose.Pose.Position;
    x = position.X;
    y = position.Y;

    % Unwrap orientation
    orientation = odomMsg.Pose.Pose.Orientation;
    q = [orientation.W, orientation.X, ...
         orientation.Y, orientation.Z];
    r = quat2eul(q);
    theta = r(1); % Extract Z component
    
    pose = [x y theta];

end