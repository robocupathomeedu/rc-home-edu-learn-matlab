function m = marrtinoSpeech(robotIP)
% Creates TCP/IP interface for MARRtino robot
%
% Copyright 2019 The MathWorks, Inc.

portNumber = 9001;
m = tcpclient(robotIP,portNumber);

end

