# RoboCup@Home Education
## Speech Files

### Main folder
* `testSpeechAction.m` - Simple script that receives detected speech from PocketSphinx node and uses ROS actions to synthesize speech (recommended approach)
* `testSpeechTopic.m` - Simple script that receives detected speech from PocketSphinx node and uses ROS topics to synthesize speech
* `speechTask.m` - Script that takes a voice command, parses it, and outputs speech
* `parseSpeechCommand.m` - Function that parses the received text from speech recognition

### `python` folder
Uses MATLAB interface to Python to directly call speech recognition using PocketSphinx, without ROS.
* `mySpeechDetector.py` - Simple Python file that uses the SpeechRecognition package
* `testSpeechPython.m` - Simple script that wraps around the Python code and returns speech detection results, then uses ROS actions to synthesize speech.
* `speechTaskPython.m` - Script that takes a voice command using Python interface, parses it, and outputs speech

### `marrtino` folder
Perform speech recognition and text-to-speech on MARRtino robots using TCP/IP communication from MATLAB.

NOTE: Speech recognition requires speaking into a mobile phone with the LU4R app installed.
https://sites.google.com/dis.uniroma1.it/marrtino/software/app-speech

* `testMarrtinoSpeech.m` - Simple script that detects speech and plays it back on the MARRtino robot
* `marrtinoSpeech.m` - Utility function that returns a TCP/IP interface to MARRtino
* `marrtinoASR.m` - Utility function that returns speech recognition results from received packet
* `marrtinoTTS.m` - Utility function that synthesizes speech packet