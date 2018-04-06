% Final task: Speech

% Copyright 2018 The MathWorks, Inc.

%% Setup
% Add folder containing mySpeechDetector.py to python path
pathToSpeech = fileparts(which('mySpeechDetector.py'));
if count(py.sys.path,pathToSpeech) == 0
    insert(py.sys.path,int32(0),pathToSpeech);
end

%% Main task
speechDone = false;
while ~speechDone
    % Call speech recognizer, convert output to MATLAB string
    clc
    disp('Hearing audio clip...')
    pyOut = py.mySpeechDetector.listenToText();
    speechStr = string(pyOut);
    disp('Listening done')
    disp('Raw message:')
    disp(speechStr)
    
    % Parse the command
    [goalPoint,objType,outputMsg] = parseCommand(speechStr);
    disp('Output message:')
    disp(outputMsg)
    
    % Speak the command
    % NOTE: This requires the soundplay_node to be running on your machine.
    %       rosrun sound_play soundplay_node.py
    systemMsg = ['source ' r.ROSFolder '/setup.bash; ' ...
        'rosrun sound_play say.py "' outputMsg '"'];
    % Use ros device object's system method, if MATLAB is on separate machine from ROS master
    system(r,systemMsg);
    % Use built-in system function, if MATLAB is on the same machine as ROS master
    %system(systemMsg);
    
    % Exit the loop if the command is valid
    %(goal point and object type are not empty)
    if ~isempty(goalPoint) && ~isempty(objType)
        speechDone = true;
    else
        % Wait before listening for the next message
        pause(3);
    end
    
end

%% Cleanup
disp('Speech task complete!');