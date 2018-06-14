%% Face or Person Recognition Example
%
% Copyright 2018 The MathWorks, Inc.

%% Setup
mode = 'ros'; % 'ros' or 'webcam'
switch mode
    case 'ros'
        % ROS image acquisition
        connectToRobot;
        imgSub = rossubscriber(RGB_IMAGE);
        receive(imgSub);
    case 'webcam'
        % WEBCAM image acquisition
        if ~exist('cam','var')
            cam = webcam;
        end
end

% Create a detector object.
% NOTE: You can configure the detectors below with more options.
% For a full list of detectors, refer to 
% >> web(fullfile(docroot, 'vision/object-detectors.html'))
detectorType = 'personACF';  % 'face', 'personHOG', or 'personACF'
switch detectorType
    case 'face'
        detector = vision.CascadeObjectDetector;
    case 'personHOG'
        detector = vision.PeopleDetector;
    case 'personACF'
        detector = peopleDetectorACF;
end

% Create video player for visualization
vidPlayer = vision.DeployableVideoPlayer;

%% Loop
while(1)
    % Get an image
    switch mode
        case 'ros'
            imgMsg = imgSub.LatestMessage;
            img = readImage(imgMsg);
        case 'webcam'
            img = snapshot(cam);
    end
    
    % Run the detector
    switch detectorType
        case 'face'
            bboxes = step(detector,img);
        case 'personHOG'
            [bboxes,scores] = step(detector,img);
        case 'personACF'
            [bboxes,scores] = detect(detector,img);
    end

    % Draw the returned bounding boxes around the detected objects.
    img = insertShape(img,'Rectangle',bboxes);
    switch detectorType
        case {'personHOG','personACF'}
            img = insertText(img,bboxes(:,1:2),cellstr(num2str(scores)));
    end
    step(vidPlayer,img);
    
    pause(0.2);
end