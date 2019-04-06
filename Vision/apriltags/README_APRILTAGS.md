### AprilTag Example Setup Steps
 
1.  Check out the apriltags_ros package from 
    https://bitbucket.org/iocchi/apriltags_ros

2.  Install the Robotics System Toolbox Interface for ROS Custom Messages
    `>> roboticsAddons`
      
3.  Set up the AprilTags custom messages. 
    From the folder containing the apriltags_ros folder, enter
    `>> rosgenmsg .`

4.  Download the printable AprilTags from 
    https://april.eecs.umich.edu/software/apriltag/

5.  Configure a launch file and run a ROS node such that there is a 
    `/tag_detections` topic available. 

6.  Finally, you can use the `visionAprilTags.m` script provided.