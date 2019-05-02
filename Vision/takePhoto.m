% Photo taking example
% Copyright 2019 The MathWorks, Inc.
function takePhoto(filename)

    close all
    % Connect to ROS master
    connectToRobot;
    % Create subscriber to camera topic
    imgSub = rossubscriber(RGB_IMAGE);
    
    % Handle no filename input
    if nargin < 1
        filename = datestr(now,'yyyy-mmm-DD_HH-MM-ss.jpg');
    end

    % Take a photo and save it with the given filename
    imgMsg = receive(imgSub);
    img = readImage(imgMsg);
    figure, imshow(img);
    imwrite(img,filename);

end