function map = readYamlMap(filename)
% % Reads a YAML and corresponding PGM file as a robotics.OccupancyGrid
%
% Copyright 2018 The MathWorks, Inc.

    %% Initialize outputs
    map = [];
    
    %% Parse the file
    f = fopen(filename);
    while ~feof(f)
        % Grab line from file
        tline = fgetl(f);

        % Read image file
        if contains(tline,'image:')
            [sIdx,eIdx] = regexp(tline,'\w*.pgm');
            occMat = 1 - double(imread(tline(sIdx:eIdx)))/255;
        end
        % Read resolution
        if contains(tline,'resolution:')
            [sIdx,eIdx] = regexp(tline,'resolution: ');
            resolution = 1/str2double(tline(eIdx:end));
        end
        % Read origin
        if contains(tline,'origin:')
            [sIdx,eIdx] = regexp(tline,'origin: ');
            origin = str2num(tline(eIdx:end));
        end
        % Read probabilities
        if contains(tline,'occupied_thresh:')
            [sIdx,eIdx] = regexp(tline,'occupied_thresh: ');
            occupied_thresh = str2double(tline(eIdx:end));
        end
        if contains(tline,'free_thresh:')
            [sIdx,eIdx] = regexp(tline,'free_thresh: ');
            free_thresh = str2double(tline(eIdx:end));
        end
    end
    fclose(f);

    %% Create occupancy grid
    map = robotics.OccupancyGrid(occMat,resolution);
    map.OccupiedThreshold = occupied_thresh;
    map.FreeThreshold = free_thresh;
    map.GridLocationInWorld = origin(1:2);
   
end

