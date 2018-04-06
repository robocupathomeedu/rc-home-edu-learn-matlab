function objDepth = getObjectDepth(depthImg,objLocation)
% GETOBJECTDEPTH Returns the depth values for a depth image given a
% specified location. This could either be a 2-element [X,Y] location or a 4-element
% [X,Y,width,height] bounding box. If you choose a bounding box, this
% function returns the mean depth value in the bounding box.

% Copyright 2018 The MathWorks, Inc.

depthData = []; 

% Get depth at that location
% If the location is a 2-element vector, get depth at that pixel
if numel(objLocation) == 2
    depthData = depthImg(objLocation(1),objLocation(2));
% If it's a 4-element vector, get mean depth of that bounding box
% Ignores zero-depth values
elseif numel(objLocation) == 4
    depthCropped = imcrop(depthImg,objLocation);
    depthData = mean(mean(depthCropped(depthCropped>0)));
end
% Convert from mm (uint16) to m (double)
% If you are using a metric depth image, comment out the line below
objDepth = double(depthData)/1000;

end

