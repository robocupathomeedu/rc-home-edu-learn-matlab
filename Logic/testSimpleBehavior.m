% Test script for simple state machine behavior

% Copyright 2019 The MathWorks, Inc.

%% Setup
connectToRobot;
% Create publishers and subscribers for vision
imgSub = rossubscriber(RGB_IMAGE);
[vPub,vMsg] = rospublisher(ROBOT_CMD_VEL);
% Create video player for visualization
vidPlayer = vision.DeployableVideoPlayer;
% Create state machine instance
sm = simpleBehavior;

%% Get first images
close all
imgMsg = receive(imgSub);
img = readImage(imgMsg);
figure, imshow(img);

%% OBJECT DETECTION + TRACKING
objType = 'blue';
r = robotics.Rate(10); % Loop rate in Hz
while(1)
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
    end
    step(vidPlayer,img);
        
    % Execute state machine
    if mod(r.TotalElapsedTime,30) < 15
        sm.wref = 0.5;
    else
        sm.wref = -0.5;
    end
    sm.marker = (~isempty(objSize)) && (objSize > 100);
    step(sm);
    
    % Publish velocity command
    vMsg.Angular.Z = sm.w;
    send(vPub,vMsg);
    
    waitfor(r);
    
end