function pose = getRobotMapPose(locMsg)
% Helper function that extracts pose from localizer message

% Copyright 2018 The MathWorks, Inc.

    % Unwrap position
    position = locMsg.Pose.Pose.Position;
    x = position.X;
    y = position.Y;

    % Unwrap orientation
    orientation = locMsg.Pose.Pose.Orientation;
    q = [orientation.W, orientation.X, ...
         orientation.Y, orientation.Z];
    r = quat2eul(q);
    theta = r(1); % Extract Z component
    
    pose = [x y theta];

end