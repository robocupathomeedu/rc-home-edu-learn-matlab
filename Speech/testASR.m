% Automatic Speech Recognition (ASR) Test

% Copyright 2019 The MathWorks, Inc.

%% Create a TCP/IP Client
connectToRobot
t = tcpclient(robotIP,9002);

%% Send an ASR request, wait a few seconds, and read the data
sendData = uint8(['ASR' newline char(13)]);
write(t,sendData)

pause(3)

read(t)