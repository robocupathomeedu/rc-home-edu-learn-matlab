function lidarPlotHelper(ranges,angles)
% LIDARPLOTHELPER Function to display Lidar scans given angle and ranges
%
% Copyright 2019 The MathWorks, Inc.

% Create a lidarScan object
scan = lidarScan(ranges,angles);

% Initialize the axes
persistent ax1 ax2 f
if isempty(ax1)
    f = figure('Name','Lidar Scans');
    ax1 = subplot(1,2,1,'Parent',f);
    ax2 = subplot(1,2,2,'Parent',f);
end

% Plot the angles, ranges, and Cartesian scan locations
plot(angles,ranges,'b.','Parent',ax1);
xlabel(ax1,'Angles [rad]'); ylabel(ax1,'Ranges [m]');
plot(scan.Cartesian(:,2),scan.Cartesian(:,1), ...
    'b.','Parent',ax2);
xlabel(ax2,'X [m]'); ylabel(ax2,'Y [m]');

% Enable the grid
subplot(1,2,1), grid on
subplot(1,2,2), grid on

end

