% Speech recognition task

% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;
% Add current folder to python path
if count(py.sys.path,'') == 0
    insert(py.sys.path,int32(0),'');
end

%% Call speech recognizer, convert output to MATLAB string
clc
disp('Hearing audio clip...')
pyOut = py.mySpeechDetector.listenToText();
speechStr = string(pyOut);
disp('Listening done')
disp('Raw message:')
disp(speechStr)

%% Parse the command
[goalPoint,objType,outputMsg] = parseCommand(speechStr);
disp('Output message:')
disp(outputMsg)

%% Speak the command
% NOTE: This requires the soundplay_node to be running on your machine.
%       rosrun sound_play soundplay_node.py
systemMsg = ['source ' r.ROSFolder '/setup.bash; ' ...
             'rosrun sound_play say.py "' outputMsg '"'];         

% Use ros device object's system method, if MATLAB is on separate machine from ROS master
system(r,systemMsg); 

% Use built-in system function, if MATLAB is on the same machine as ROS master
%system(systemMsg); 