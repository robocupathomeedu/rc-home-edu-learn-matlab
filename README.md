# RoboCup@Home Education Workshop
### MATLAB and Simulink Files
### Copyright 2018-2019 The MathWorks, Inc.

## Getting Started
First, run the `startWorkshop` script to set up your environment.

Take a look at `rosCommands.txt` for some of the ROS nodes that need to be 
running to work with this example.

Finally, open the ROS Configuration app by typing `rosConfigurationApp`.
Modify this with your robot's IP address and topic names as needed. 

## Folder and File Information
Refer to the folder-specific README files for more detailed information on each folder.

### IntroROS
Introduction to communicating with a ROS enabled robot.
* `simpleTalker.m` - Instructional example showing how to communicate between MATLAB and ROS
* `introRobotControl.m` - How to get robot pose and send velocity commands
* `displayScanData.m` - How to get and display data from the "lidar" sensor
* `displayImageData.m` - How to get and display color and depth images from the RGB-D sensor

### Speech
All files pertaining to speech detection and synthesis.

### Navigation
Mapping, path planning, and path following
* `ExampleMaps` - Folder containing example maps in MAT-files
* `getMapFromROS.m` - Simple script that gets an occupancy grid from a mapping topic, displays it, and saves it
* `saveMapToFile.m` - Saves occupancy grid to a MAT-file for future use
* `showMap.m` - Utility function that displays an occupancy grid received from mapping topic
* `drive_around.slx` - Simulink model that drives robot based on joystick input and displays/saves received map
* `driveParameters.m` - Data file for the model above
* `testMoveBaseAction.m` - Script to test the ROS `move_base` action server to reach a goal location
* `testPathPlanning.m` - Script to test path planning given a map, start location, and goal location
* `navigationTask.m` - Script to perform path planning and following on the robot

### Vision
Computer vision (RGB image, Depth image, point cloud)
* `processImage.m` - Simple script that reads RGB image and detects object
* `detectObject.m` - Main object detection function
* `createMaskBlue.m`/`createMaskRed.m` - Example files generated from Color Thresholder app, which take a color image and return a thresholded black-and-white image
* `printableCircleBlue.jpg`/`printableCircleRed.jpg` - Printable images to test color thresholding
* `getObjectDepth.m` - Gets the depth of an object in a depth image by querying its location
* `visionTaskDepth.m` - Main script that tracks a detected object using its location and depth
* `trackObjectDepth.m` - Function that determines robot speed based on object location and depth
* `visionTaskSize.m` - Main script that tracks a detected object using its location and pixel size
* `trackObjectSize.m` - Function that determines robot speed based on object location and size

#### Bonus/Advanced Vision Files
* `processPointCloud.m` - Example showing point cloud processing
* `apriltags\visionAprilTags.m` - Script that subscribes to AprilTag detection ROS topic and displays information
* `apriltags\README_APRILTAGS.md` - More information about the example above, including setup steps
* `mobilenet\importMobileNet.m` - Imports pretrained MobileNet object detector from Keras model and makes modifications as needed to get the model working in MATLAB
* `mobilenet\loadMobileNet.m` - Loads pretrained MobileNet object detector and filters down the number of classes to look for vs. the full ImageNet set
* `mobilenet\testMobileNet.m` - Script to test pretrained MobileNet object detector on a static image
* `mobilenet\visionMobileNet.m` - Script to run pretrained MobileNet object detector on webcam or ROS image feed
* `person_detection\visionPersonDetection.m` - Script to test pretrained face and person detectors from Computer Vision System Toolbox
* `person_detection\visionAgeDetection.m` - Script that combines pretrained face detector with deep learning based age classifier
* `person_detection\visionGenderDetection.m` - Script that combines pretrained face detector with deep learning based gender classifier
* `person_detection\README_GENDER.md` - More information about the example above, including setup steps

### Manipulation
Inverse kinematics and robot arm control (using ROS interface to Dynamixel motors)
* `manipDescriptions.mat` - MAT-file containing Rigid Body Tree definitions of robot arms
* `importManipDescriptions.m` - Script that generates the above MAT file (requires the URDF and graphics files for the robot arm)
* `testManipulation.m` - Script that tests manipulation tasks in simulation
* `manipulationTask.m` - Script for manipulation using a real robot, with the Dynamixel ROS interface
* `createTrajectory.m` - Function that generates a trajectory from waypoints
* `plotTrajectory.m` - Function that plots a trajectory and waypoints

### Logic
IN PROGRESS: Examples using Stateflow for building state machines to model robot behavior. 
This functionality requires MATLAB R2019a or later.
* `simpleBehavior.sfx` - Chart that represents simple finite-state machine
* `testSimpleBehavior.m` - Script to execute the chart above and test its behavior

### Integration
Putting it all together into one typical RoboCup@Home task!
* `integFinalTask.m` - Final script, which runs all the other scripts in this folder sequentially
* `integSpeech.m` - Final script for speech tasks
* `integNavigation.m` - Final script for navigation tasks
* `integVision.m` - Final script for vision tasks
* `integManipulation.m` - Final script for manipulation tasks
