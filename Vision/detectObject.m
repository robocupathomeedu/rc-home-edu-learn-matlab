function [objLocation,objSize,objBox] = detectObject(img,objType)
% Detect object using color thresholding and blob analysis

% Copyright 2018 The MathWorks, Inc.

    % Create blob detector system object
    persistent blobDetector
    if isempty(blobDetector)
        blobDetector = vision.BlobAnalysis( ...
                        'MajorAxisLengthOutputPort',true, ...
                        'MinimumBlobArea',300, ...
                        'MaximumCount',10);
    end

    % Threshold the image based on autogenerated color thresholder code
    if strcmp(objType,'blue')
        imgBW = createMaskBlue(img);
    elseif strcmp(objType,'red')
        imgBW = createMaskRed(img);
    end
    
    % Find blobs
    [areas,centroids,bboxes,majAxis] = blobDetector(imgBW);
    
    % Find the centroid and depth of the biggest blob, if any
    objLocation = [];
    objSize = [];
    objBox = [];
    if ~isempty(areas)
       % Get area and centroid of biggest area blob
       [~,maxIdx] = max(areas);
       objLocation = round(centroids(maxIdx,:));
       objLocation(1) = min(objLocation(1),size(img,1));
       objLocation(2) = min(objLocation(2),size(img,2));

       % Get bounding box and major axis size of biggest area blob
       objBox = bboxes(maxIdx,:);
       objSize = majAxis(maxIdx,:);
    end
    
end