# RoboCup@Home Education
## Navigation Files

### Main folder
* `getMapFromROS.m` - Simple script that gets an occupancy grid from a mapping topic, displays it, and saves it
* `saveMapToFile.m` - Saves occupancy grid to a MAT-file for future use
* `showMap.m` - Utility function that displays an occupancy grid received from mapping topic
* `drive_around.slx` - Simulink model that drives robot based on joystick input and displays/saves received map
* `driveParameters.m` - Data file for the model above
* `testMoveBaseAction.m` - Script to test the ROS `move_base` action server to reach a goal location
* `testPathPlanning.m` - Script to test path planning given a map, start location, and goal location
* `navigationTask.m` - Script to perform path planning and following on the robot

### `ExampleMaps` folder
Folder containing example maps in MATLAB format (MAT-files), 
as well as ROS format (`.pgm` and `.yaml` files).

### `turtlebot_follow` folder
* `testTurtleBotFollower.m` - Script to enable/disable the TurtleBot follower node using ROS services