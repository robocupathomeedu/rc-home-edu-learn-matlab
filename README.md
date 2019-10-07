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
Start here to learn how to use MATLAB, Simulink, and ROS to interface with your robot.

### Speech
All files pertaining to speech detection and synthesis.

### Navigation
All files pertaining to autonomous navigation 
(localization, mapping, path planning, and path following).

### Vision
All files associated with perception, including processing of color images, 
depth images, and point clouds, using classical techniques all the way through 
deep learning.

### Manipulation
Inverse kinematics and robot arm control using ROS interface to Dynamixel motors.

### Logic
IN PROGRESS: Examples using Stateflow for building state machines to model robot behavior. 
This functionality requires MATLAB R2019a or later.
* `simpleBehavior.sfx` - Chart that represents simple finite-state machine
* `testSimpleBehavior.m` - Script to execute the chart above and test its behavior

## Tasks
Contains specialized service robotics tasks that serve as examples for 
performing the RoboCup@Home Education Challenge tasks.

* `depth_follower` - Simulink model that uses depth camera information to follow a person. Can be deployed as a standalone ROS node.
* `speech_person` - MATLAB based service robot application developed at European RoboCup@Home Education 2019
* `statemachine` - Stateflow based service robot application
