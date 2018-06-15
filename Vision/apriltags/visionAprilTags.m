%% AprilTag Example
%
% For setup steps, see README_APRILTAGS.md
%
% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;
% Create publishers and subscribers for vision
imgSub = rossubscriber(RGB_IMAGE);
tagSub = rossubscriber('/tag_detections');

%% Get first image
close all
imgMsg = receive(imgSub);
img = readImage(imgMsg);
figure, imshow(img);

%% OBJECT DETECTION
while(1)
    % Get image and tag data
    imgMsg = imgSub.LatestMessage;
    img = readImage(imgMsg);
    tagMsg = tagSub.LatestMessage;
 
    % Extract and display tag information
    if ~isempty(tagMsg) && numel(tagMsg.Detections)>0
        fprintf('Detections:\n')
        for idx = 1:numel(tagMsg.Detections) 
            tag = tagMsg.Detections(idx);
            tagPos = tag.Pose.Pose.Position;
            fprintf('Tag ID %d at [%.2f, %.2f, %.2f]\n', ...
                    tag.Id,tagPos.X,tagPos.Y,tagPos.Z);
        end
    end
        
    pause(0.2);
end