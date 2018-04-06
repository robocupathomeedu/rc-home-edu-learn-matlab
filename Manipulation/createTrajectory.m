function traj = createTrajectory(waypoints,numPts,interpType)
% CREATETRAJECTORY Builds a 3D trajectory given the following inputs.
%   waypoints   : N-by-3 matrix of XYZ waypoints 
%   numPts      : Total number of points in the trajectory
%   interpType  : Interpolation type (see INTERP1 documentation)

% Copyright 2018 The MathWorks, Inc.

% Find a list of indices from 1 to N that denote the trajectory points
N = size(waypoints,1);
trajIndices = linspace(1,N,numPts);

% Loop through and assign each trajectory point
traj = zeros(numPts,3);
for idx = 1:3
    traj(:,idx) = interp1(1:N,waypoints(:,idx),trajIndices,interpType);
end

end

