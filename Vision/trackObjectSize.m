function [v,w,grip] = trackObjectSize(objLocation,objSize,imgWidth)
% TRACKOBJECTSIZE Tracks an object using object location and pixel size

% Copyright 2018 The MathWorks, Inc.

% Initialize outputs
v = 0;
w = 0;
validPos = false;
validSize = false;

% Angular velocity
posThresh = 20; % pixels
if objLocation(1) > imgWidth/2 + posThresh
    w = -0.3;
elseif objLocation(1) < imgWidth/2 - posThresh
    w = 0.3;
else
    validPos = true;
end

% Linear velocity
sizeThresh = 10;     % pixels
targetSize = 250;    % pixels
if objSize > targetSize + sizeThresh
    v = -0.05;
elseif objSize < targetSize - sizeThresh
    v = 0.05;
else
    validSize = true;
end

% Find if both the size and position are valid for gripping
grip = validPos & validSize;

end

