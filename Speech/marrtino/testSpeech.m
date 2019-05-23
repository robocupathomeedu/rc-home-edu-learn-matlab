% Automatic Speech Recognition (ASR) Test

% Copyright 2019 The MathWorks, Inc.

%% Create a TCP/IP Client
connectToRobot
t = tcpclient(robotIP,9001);

%% Send an ASR request, wait a few seconds, and read the data
sendData = uint8(['ASR' newline char(13)]);
write(t,sendData)

pause(3)

read(t)

%% Send a TTS request, wait a few seconds, and read the data
language = 'en'; 
textToSay = 'Hello world';
sendData = uint8(['TTS[' language '] ' textToSay newline char(13)]);
write(t,sendData)

pause(3)

read(t)
