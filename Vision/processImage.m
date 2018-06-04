% Introduction to image processing

% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;
% Create publishers and subscribers for vision
imgSub = rossubscriber(RGB_IMAGE);
depthSub = rossubscriber(DEPTH_IMAGE);

%% Get images
imgMsg = receive(imgSub);
img = readImage(imgMsg);
figure, imshow(img);
depthMsg = receive(depthSub);
depthImg = readImage(depthMsg);
figure, imshow(depthImg,[0 3000]); % Plot up to 3 meters

%% Open the Color Thresholder App 
% Uncomment the line below, or open the app from the Apps tab
% colorThresholder(img) 

%% Object detection
close all
objType = 'blue';
[objLocation,objDepth,objBox] = detectObject(img,objType);
    
% Visualize only if an object is found
if ~isempty(objDepth) && (objDepth>0)
   % Visualize
   imgLabeled = insertShape(img,'Rectangle',objBox,'LineWidth',2);
   imgLabeled = insertText(imgLabeled,[0 0],['Depth: ' num2str(objDepth) ' m'],'FontSize',16);    
end
figure
imshow(imgLabeled)
