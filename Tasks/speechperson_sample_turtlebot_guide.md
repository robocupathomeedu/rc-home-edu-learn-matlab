##SETUP

You will need the age detection network to run this sample task.

In the Vision/person_recognition folder, run the setupAgeDetector function to download and set up the network.

##BRINGUP ON TURTLEBOT

Start the TurtleBot minimal node
roslaunch turtlebot_bringup minimal.launch

Start the sound play node
roslaunch sound_play soundplay_node.launch

Start the speech recognition with the custom PocketSphinx dictionary and language model
roslaunch rchomeedu_speech lm.launch dict:=/path/to/trieste.dic lm:=/path/to/trieste.lm

Start the follower node
roslaunch rchomeedu_follower follower2.launch