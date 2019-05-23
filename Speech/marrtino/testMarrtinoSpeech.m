% Automatic Speech Recognition (ASR) Test

% Copyright 2019 The MathWorks, Inc.

%% Create a TCP/IP Client
robotIP = '10.3.1.1';
m = marrtinoSpeech(robotIP);

%% Send an ASR request with a wait time
waitTime = 100;
receivedText = marrtinoASR(m,waitTime);
disp('Received text!')
disp(receivedText)

%% Send a TTS request with the received text
language = 'it';
marrtinoTTS(m,receivedText,language);
