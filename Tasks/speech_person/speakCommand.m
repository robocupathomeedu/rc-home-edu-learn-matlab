function speakCommand(r,cmd)
% Speaks a command for TurtleBot using ROS device (r)
%
% Copyright 2019 The MathWorks, Inc.

systemMsg = ['source ' r.ROSFolder '/setup.bash; ' ...
    'rosrun sound_play say.py "' cmd '"'];
system(r,systemMsg);

end

