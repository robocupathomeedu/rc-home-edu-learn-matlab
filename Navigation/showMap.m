function success = showMap(varargin)
% SHOWMAP Displays an occupancy grid on the /map ROS topic.
% Optional input is the inflation radius

% Copyright 2018 The MathWorks, Inc.

    %% Create map subscriber
    persistent mapSub
    if isempty(mapSub)
        mapSub = rossubscriber(MAP_TOPIC);
    end

    %% Receive, show, and save the latest map from the /map topic
    % Assumes you are using a gmapping tutorial like this one:
    % http://wiki.ros.org/turtlebot_navigation/Tutorials/indigo/Build%20a%20map%20with%20SLAM
    success = 0;
    mapMsg = mapSub.LatestMessage;
    if ~isempty(mapMsg)
        map = readOccupancyGrid(mapMsg);
        if nargin > 0
            infRadius = varargin{1};
            if infRadius > 0
               inflate(map,infRadius); 
            end
        end
        show(map);
        drawnow;
        success = 1;
    end
    
end