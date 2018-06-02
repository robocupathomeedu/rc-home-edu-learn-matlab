function saveMapToFile(varargin)
% SAVEMAPTOFILE Saves an occupancy grid to a specified MAT file.
% Optionally allows for map inflation.

% Copyright 2018 The MathWorks, Inc.

%% Confirm map saving with user dialog
answer = questdlg('Save map to file?','Save Map','Yes','No','No');
options.Resize = 'on';

switch answer
    case 'Yes'
        
        % If there is an input map, use that.
        if nargin > 0
            map = varargin{1};
        
        % Else, try get a map from the /map topic. 
        % Throw an error message if no map can be read.
        else
            mapSub = rossubscriber(MAP_TOPIC);
            try
                mapMsg = receive(mapSub);
            catch
                errordlg('No map found on the map topic');
            end
            map = readOccupancyGrid(mapMsg);   
        end
        
        % Request file name and inflation radius
        answer = inputdlg({'Enter file name','Inflation radius'},'Save Map',2,{'myMap','0.1'},options);
        filename = answer{1};
        infRadius = str2double(answer{2});
        if infRadius > 0
            inflate(map,infRadius);
        end
        if ~isempty(filename)
            save(filename,'map');
            disp(['Map saved to ' filename '.mat']);
        end
end