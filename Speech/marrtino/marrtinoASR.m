function recognizedText = marrtinoASR(m,waitTime)
% Automatic Speech Recognition (ASR) with MARRtino
% Inputs are
%   m : TCP/IP client created with marrtinoSpeech function
%   waitTime : wait time in seconds

% Copyright 2019 The MathWorks, Inc.

% Send an ASR request, wait a few seconds, and read the data
sendData = uint8(['ASR' newline char(13)]);
write(m,sendData)

% Wait for the prescribed wait time
if nargin < 2
    waitTime = 3; % Default wait time
end

% Receive the data and convert it to text
received = false;
tic;
while ~received || toc > waitTime
    sendData = uint8(['ASR' newline char(13)]);
    write(m,sendData)
    recvData = read(m);
    if ~isempty(recvData) && (recvData(1) ~= 10) % Check for a first character that isn't newline   
        received = true;
        recognizedText = char(recvData(1:end-2));
    end
    pause(0.5);
end