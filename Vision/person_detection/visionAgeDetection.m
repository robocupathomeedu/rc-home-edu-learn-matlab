%% Face and Age Recognition Example
%
% Copyright 2019 The MathWorks, Inc.

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

% Create a cascade detector object to find face bounding boxes
detector = vision.CascadeObjectDetector();

% Load pretrained neural network for age detection
load ageNetwork
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
    
    % Predict age for each of the bounding boxes
    numFaces = size(bboxes,1);
    scores = zeros(numFaces,1);
    ageText = cell(numFaces,1);
    for idx = 1:numFaces
        
        % Create a buffer zone
        bufSize = 0.3;
        bbox = bboxes(idx,:);
        bufx = floor(bufSize*bbox(3));
        bufy = floor(bufSize*bbox(4));
        xs = max(bbox(1)-bufx, 1);
        ys = max(bbox(2)-bufy, 1);
        xe = min(bbox(1)+bbox(3)-1+bufx, size(img,2));
        ye = min(bbox(2)+bbox(4)-1+bufy, size(img,1));

        % Cropping original image not to lose resolution
        faceImg = img(floor(ys):floor(ye), ...
                      floor(xs):floor(xe),:);
        
        % Predict age
        predictImg = imresize(faceImg,[224 224]);
        ageText{idx} = char( classify(ageNet,predictImg) );
    end
    
    % Draw the returned bounding box and text around the detected faces.
    if numFaces > 0
        img = insertShape(img,'Rectangle',bboxes);
        img = insertText(img,bboxes(:,1:2),ageText);
    end
    step(vidPlayer,img);
    
    pause(0.2);
end