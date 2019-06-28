%% Text-to-Speech (TTS) Example Script using ROS sound_play package (Topics)

% Run the following command in a terminal before running this script
% roslaunch sound_play soundplay_node.launch

% For more detailed documentation about the message being sent, 
% refer to the following link
% http://docs.ros.org/kinetic/api/sound_play/html/msg/SoundRequest.html

% Copyright 2019 The MathWorks, Inc.

%% Setup: Connect to robot and create a publisher
connectToRobot;
[speechPub,speechMsg] = rospublisher('/robotsound');

%% Publish message
% The command given (play pre-defined sound, from a custom file or use text)
speechMsg.Sound = speechMsg.SAY;
% The execution type (play once, stop or loop)
speechMsg.Command = speechMsg.PLAYONCE;
% The volume (0 to 1)
speechMsg.Volume = 1;
% The text to be said
speechMsg.Arg = 'Saying text sent from MATLAB';
% The voice to be used
speechMsg.Arg2 = 'voice_kal_diphone';
% Send the message
send(speechPub, speechMsg);  