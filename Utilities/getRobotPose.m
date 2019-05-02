function pose = getRobotPose(poseMsg)
% Helper function that extracts 2D pose (x y theta) from ROS pose message

% Copyright 2018-2019 The MathWorks, Inc.

    % Unwrap position
    position = poseMsg.Pose.Pose.Position;
    x = position.X;
    y = position.Y;

    % Unwrap orientation
    orientation = poseMsg.Pose.Pose.Orientation;
    q = [orientation.W, orientation.X, ...
         orientation.Y, orientation.Z];
    r = quat2eul(q);
    theta = r(1); % Extract Z component
    
    pose = [x y theta];

end
