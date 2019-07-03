%% Text-to-Speech (TTS) Example Script using ROS sound_play package (Actions)

% Run the following command in a terminal before running this script
% roslaunch sound_play soundplay_node.launch

% For more detailed documentation about the message being sent, 
% refer to the following link
% http://docs.ros.org/kinetic/api/sound_play/html/msg/SoundRequest.html

% Copyright 2019 The MathWorks, Inc.

%% Setup: Connect to ROS master and create a publisher
connectToRobot;
[speechClient,speechGoal] = rosactionclient('/sound_play');
speechClient.FeedbackFcn = '';

%% Send action goal
% The command given (play pre-defined sound, from a custom file or use text)
speechGoal.SoundRequest.Sound = speechGoal.SoundRequest.SAY;
% The execution type (play once, stop or loop)
speechGoal.SoundRequest.Command = speechGoal.SoundRequest.PLAYONCE;
% The volume (0 to 1)
speechGoal.SoundRequest.Volume = 1.0;
% The text to be said
speechGoal.SoundRequest.Arg = 'Saying text sent from matlab';
% The voice to be used
speechGoal.SoundRequest.Arg2 = 'voice_kal_diphone';
% Send the goal
sendGoal(speechClient,speechGoal);  

