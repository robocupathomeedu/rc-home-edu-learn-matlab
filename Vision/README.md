# RoboCup@Home Education
## Vision Files

All files associated with perception, including processing of color images, 
depth images, and point clouds, using classical techniques all the way through 
deep learning.

### Main folder
* `takePhoto.m` - Takes a photo and saves it to a file
* `takePhotoTopic.m` - Sets up a ROS node that waits for a message to take photos
* `processImage.m` - Simple script that reads RGB image and detects object
* `detectObject.m` - Main object detection function
* `createMaskBlue.m`/`createMaskRed.m` - Example files generated from Color Thresholder app, which take a color image and return a thresholded black-and-white image
* `printableCircleBlue.jpg`/`printableCircleRed.jpg` - Printable images to test color thresholding
* `getObjectDepth.m` - Gets the depth of an object in a depth image by querying its location
* `visionTaskDepth.m` - Main script that tracks a detected object using its location and depth
* `trackObjectDepth.m` - Function that determines robot speed based on object location and depth
* `visionTaskSize.m` - Main script that tracks a detected object using its location and pixel size
* `trackObjectSize.m` - Function that determines robot speed based on object location and size
* `processPointCloud.m` - Example showing point cloud processing

### `apriltags` folder
Connect to ROS AprilTag detection package to use in MATLAB
* `visionAprilTags.m` - Script that subscribes to AprilTag detection ROS topic and displays information
* `README_APRILTAGS.md` - More information about the example above, including setup steps

### `object_recognition` folder
Uses pretrained neural networks to classify objects from color images.
* `loadAlexNet.m` - Loads pretrained AlexNet object detector and filters down the number of classes to look for vs. the full ImageNet set
* `testAlexNet.m` - Script to test pretrained AlexNet object detector on a static image
* `visionAlexNet.m` - Script to run pretrained AlexNet object detector on webcam or ROS image feed
* `importMobileNet.m` - Imports pretrained MobileNet object detector from Keras model and makes modifications as needed to get the model working in MATLAB
* `loadMobileNet.m` - Loads pretrained MobileNet object detector and filters down the number of classes to look for vs. the full ImageNet set
* `testMobileNet.m` - Script to test pretrained MobileNet object detector on a static image
* `visionMobileNet.m` - Script to run pretrained MobileNet object detector on webcam or ROS image feed

### `person_detection` folder
Examples using pretrained face and person detectors, both with classical and 
deep learning techniques.
* `visionPersonDetection.m` - Script to test pretrained face and person detectors from Computer Vision System Toolbox
* `visionAgeDetection.m` - Script that combines pretrained face detector with deep learning based age classifier
* `visionGenderDetection.m` - Script that combines pretrained face detector with deep learning based gender classifier
* `README_GENDER.md` - More information about the example above, including setup steps
