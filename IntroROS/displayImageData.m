% Introduction: Display RGB and depth image data

% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;
imgSub = rossubscriber(RGB_IMAGE);
depthSub = rossubscriber(DEPTH_IMAGE);
[vPub,vMsg] = rospublisher(ROBOT_CMD_VEL);

%% Visualize the image data
close all
receive(imgSub); % Do this in case no image has been received yet
receive(depthSub);

% Read image data from the latest messages
rgbImg = readImage(imgSub.LatestMessage);
depthImg = readImage(depthSub.LatestMessage);

% Display RGB image
figure
imshow(rgbImg);

% Display depth image
% NOTE: Display range [0 3000] is in mm
% Change this if your topic returns depth in meters.
figure
imshow(depthImg,[0 3000]);