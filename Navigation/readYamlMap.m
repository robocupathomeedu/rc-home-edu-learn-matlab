function map = readYamlMap(filename)
% % Reads a YAML and corresponding PGM file as an occupancyMap
%
% Copyright 2018-2019 The MathWorks, Inc.

    %% Initialize outputs
    map = [];
    
    %% Parse the file
    f = fopen(filename);
    while ~feof(f)
        % Grab line from file
        tline = fgetl(f);

        % Read image file
        if contains(tline,'image:')
            % First, try read the full path
            try 
                [sIdx,eIdx] = regexp(tline,'image: ');
                img = imread(tline(eIdx:end));
            % If that doesn't work, read just the image name
            catch
                [sIdx,eIdx] = regexp(tline,'\w*.pgm');
                img = imread(tline(sIdx:eIdx));               
            end
            % Rescale the image to the right format
            occMat = 1 - double(img)/255;
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
    map = occupancyMap(occMat,resolution);
    map.OccupiedThreshold = occupied_thresh;
    map.FreeThreshold = free_thresh;
    map.GridLocationInWorld = origin(1:2);
   
end

