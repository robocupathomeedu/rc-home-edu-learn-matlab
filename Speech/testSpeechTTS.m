%% Setup

% Text-to-Speech (TTS) Example Script using ROS sound_play package

% Run the following command in a terminal before running this script
% roslaunch sound_play soundplay_node.launch

% For more detailed documentation about the message being sent, 
% refer to the following link
% http://docs.ros.org/kinetic/api/sound_play/html/msg/SoundRequest.html

% Copyright 2019 The MathWorks, Inc.

%% Setup: Connect to ROS master and create a publisher
connectToRobot;
[spkPub,spkMsg] = rospublisher('/robotsound');

%% Publish message

% The command given (play pre-defined sound, from a custom file or use text)
spkMsg.Sound = -3;
% The execution type (play once, stop or loop)
spkMsg.Command = 1;
% The text to be said
spkMsg.Arg = 'Saying text sent from matlab';
% The voice to be used
spkMsg.Arg2 = 'voice_kal_diphone';
% Send the message
send(spkPub, spkMsg);  