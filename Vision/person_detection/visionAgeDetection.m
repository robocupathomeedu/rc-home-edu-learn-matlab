%% Face and Age Recognition Example
%
% Copyright 2019 The MathWorks, Inc.

%% Setup
mode = 'webcam'; % 'ros' or 'webcam'
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

% Create a cascade detector object to find face bounding boxes
detector = vision.CascadeObjectDetector();

% Load pretrained neural network for age detection
load ageNet_imported
classNames = ageNet.Layers(end).ClassNames;

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
    
    % Run the face detector
    bboxes = step(detector, img);
    
    % Predict gender for each of the bounding boxes
    numFaces = size(bboxes,1);
    scores = zeros(numFaces,1);
    ageText = {''};
    for idx = 1:numFaces
        predictImg = imresize(imcrop(img,bboxes(idx,:)),[227 227]);
        score = predict(ageNet,predictImg);  % NOTE: Can also use 'classify' function if you do not want scores
        [scores(idx),maxIdx] = max(score);
        ageText{idx} = [classNames{maxIdx} ': ' num2str(scores(idx))];
    end
    
    % Draw the returned bounding box and text around the detected faces.
    img = insertShape(img,'Rectangle',bboxes);
    img = insertText(img,bboxes(:,1:2),ageText);
    step(vidPlayer,img);
    
    pause(0.2);
end