%% Sample Task: Speech and Person Recognition
% Daniele Gusmini, Alberto Lucchini - Politecnico de Milano
% Sebastian Castro - MathWorks
% 2019
%
% Refer to the setup instructions in this folder for details on what to
% bringup on the TurtleBot.

%% Setup: Create all needed connections to the robot and vision utilities
connectToRobot

% ROS publishers, subscribers, and service servers
speechSub = rossubscriber('/lm_data');
imgSub = rossubscriber('/camera_top/rgb/image_raw');
[followSvc,followMsg] = rossvcclient('/turtlebot_follower/change_state');
followMsg.State = followMsg.STOPPED;
call(followSvc,followMsg)

% Vision setup
% Load pretrained neural network for age detection
if ~exist('ageNet','var')
    load ageNetwork
end
classNames = ageNet.Layers(end).ClassNames;
% Load face detector and video player
detector = vision.CascadeObjectDetector;
vidPlayer = vision.DeployableVideoPlayer;

% Create ROS device object (requires OpenSSH-server on machine)
r = rosdevice(robotIP,'mustar','ubuntu'); % Replace with your own user/pass
r.ROSFolder = '/opt/ros/kinetic'; % Replace with your own ROS install folder
outputMsg = 'What do you want me to do';
speakCommand(r,outputMsg);

disp('Setup complete.')

%% Main Loop
while(1)
    
    % Wait to receive speech and parse it
    speechMsg = receive(speechSub);
    speechStr = speechMsg.Data;
    disp(['Received speech: ' speechStr])
    follow = contains(speechStr,'FOLLOW');
    photo = contains(speechStr,'PHOTO') || contains(speechStr,'PICTURE');
    stop = contains(speechStr,'STOP');
    age = contains(speechStr,'AGE');
    
    % Switch case
    % START FOLLOWING
    if follow && ~stop
        outputMsg = 'Ok I follow you';
        speakCommand(r,outputMsg);       
        followMsg.State = followMsg.FOLLOW;
        call(followSvc,followMsg)     
    end
    
    % STOP FOLLOWING
    if stop
        outputMsg = 'Ok I stop following you';
        speakCommand(r,outputMsg);
        followMsg.State = followMsg.STOPPED;
        call(followSvc,followMsg)
    end
    
    % TAKE PHOTO
    if photo
        outputMsg = 'Ok I take you a photo, 3 2 1 say cheese';
        speakCommand(r,outputMsg);
        imgMsg = receive(imgSub);
        img = readImage(imgMsg);
        figure, imshow(img);
        outputMsg = 'awww, You are not so beautiful';
        speakCommand(r,outputMsg);
    end
    
    % GUESS AGE FROM PHOTO
    if age
        outputMsg = 'Ok I check your age';
        speakCommand(r,outputMsg);
        detectAge;
        
        if numFaces == 1
            outputMsg = ['There is one person and their age is ' num2str(ageText{1})];
        else
            outputMsg = ['There are ' num2str(numFaces) ' people. '];
            if numFaces > 1
                outputMsg = [outputMsg 'and their ages are: '];
                for idx = 1:numFaces
                    outputMsg = [outputMsg num2str(ageText{idx}) ','];
                end
            end
        end
        speakCommand(r,outputMsg);
    end
    
    % Pause the loop
    pause(0.5)
    
end