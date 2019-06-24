%% Image Classification Example with MobileNet
%
% Copyright 2019 The MathWorks, Inc.

%% Setup
mode = 'ros'; % 'ros' or 'webcam'
switch mode
    case 'ros'
        % ROS image acquisition
        %connectToRobot;
        imgSub = rossubscriber(RGB_IMAGE);
        receive(imgSub);
    case 'webcam'
        % WEBCAM image acquisition
        if ~exist('cam','var')
            cam = webcam;
            cam.Resolution = '320x240'; % Comment out or change resolution
        end
end

% Load the pretrained MobileNet model. 
% To modify classes, edit the following function.
loadMobileNet;

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
    
    % Find class predictions and maximum probability
    imgResized = imresize(img,[224 224]);
    predictions = predict(mobilenet,imgResized);
    classPredictions = predictions(classIndices);
    classPredictions = classPredictions./sum(classPredictions);  
    [maxP,maxIdx] = max(classPredictions);
    
    % Display the image with its classification results 
    predictionText = sprintf('%s : %.2f%%',classNames{maxIdx},maxP*100);
    img = insertText(img,[0 0],predictionText,'FontSize',16);
    step(vidPlayer,img);
    
end