# RoboCup@Home Education
## Manipulation Files

Inverse kinematics and robot arm control using ROS interface to Dynamixel motors.

* `manipDescriptions.mat` - MAT-file containing Rigid Body Tree definitions of robot arms
* `importManipDescriptions.m` - Script that generates the above MAT file (requires the URDF and graphics files for the robot arm)
* `testManipulation.m` - Script that tests manipulation tasks in simulation
* `manipulationTask.m` - Script for manipulation using a real robot, with the Dynamixel ROS interface
* `plotTrajectory.m` - Function that plots a trajectory and waypoints