% Photo taking example with ROS subscribers
% Copyright 2019 The MathWorks, Inc.

close all
% Connect to ROS master
connectToRobot;
% Create subscriber to camera topic
imgSub = rossubscriber(RGB_IMAGE);
% Create subscriber and publisher to the /take_photo topic
disp('Listening to the /take_photo topic...');
takePhotoSub = rossubscriber('/take_photo','std_msgs/String',@(src,msg)takePhotoCallback(src,msg,imgSub));

% NOTE: 
% To take a photo from MATLAB, run the following:
%   [takePhotoPub,takePhotoMsg] = rospublisher('/take_photo','std_msgs/String');
%   takePhotoMsg.Data = "take photo"
%   send(takePhotoSub,takePhotoMsg)
% To take a photo from the Terminal, run the following:
%   rostopic pub -1 /take_photo std_msgs/String "take photo"

% Callback function to take a photo
function takePhotoCallback(~,msg,imgSub)

    if strcmpi(msg.Data,"take photo")
        disp('Taking photo!')
        imgMsg = receive(imgSub);
        img = readImage(imgMsg);
        imshow(img);
        filename = datestr(now,'yyyy-mmm-DD_HH-MM-ss.jpg');
        imwrite(img,filename);
    end

end
