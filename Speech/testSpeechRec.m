% Speech recognition test script

% Copyright 2018 The MathWorks, Inc.

%% Add current folder to python path
% To use Python with MATLAB, you need to follow the setup in 
% https://www.mathworks.com/help/matlab/getting-started-with-python.html
pathToSpeech = fileparts(which('mySpeechDetector.py'));
if count(py.sys.path,pathToSpeech) == 0
    insert(py.sys.path,int32(0),pathToSpeech);
end

%% Call speech recognizer, convert output to MATLAB string
disp('Hearing audio clip...')
pyOut = py.mySpeechDetector.listenToText();
myText = string(pyOut);
disp('Listening done')
disp(myText)