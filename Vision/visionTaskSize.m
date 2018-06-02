% Final vision algorithm (Size mode)

% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;
% Create publishers and subscribers for vision
imgSub = rossubscriber(RGB_IMAGE);
[vPub,vMsg] = rospublisher(ROBOT_CMD_VEL);

%% Get first images
close all
imgMsg = receive(imgSub);
img = readImage(imgMsg);
figure, imshow(img);

%% OBJECT DETECTION + TRACKING
objType = 'red';

% Create video player for visualization
vidPlayer = vision.DeployableVideoPlayer;

gripCount = 0;
while(gripCount < 20)
    % Get image data
    imgMsg = imgSub.LatestMessage;
    img = readImage(imgMsg);
    
    % Detect object location and depth
    [objLocation,objSize,objBox] = detectObject(img,objType);
    
    % Visualize and track only if an object is found
    if ~isempty(objLocation)
        % Visualize
        img = insertShape(img,'Rectangle',objBox,'LineWidth',2);
        img = insertText(img, [0 0], ...
            ['Size: ' num2str(round(objSize)) ' px'], 'FontSize',20);
        
        % Track object using area mode
        imgWidth = size(img,2);
        [v,w,grip] = trackObjectSize(objLocation,objSize,imgWidth);
        
        % Keep track of "ready to grip" counter
        if grip
            gripCount = gripCount + 1;
        else
            gripCount = 0;
        end
        
        % Publish velocity command
        vMsg.Linear.X = v;
        vMsg.Angular.Z = w;
        send(vPub,vMsg);
    end
    
    step(vidPlayer,img);
    
end
disp('Ready to grip!')
