# Python speech recognition code using CMU PocketSphinx
# Source: https://pypi.python.org/pypi/SpeechRecognition/

import speech_recognition as sr

def listenToText():

    # Add your own keywords here
    # keywords = [("robot",1.0),("kitchen",1.0),("bedroom",1.0),("bathroom",1.0)];

    myRec = sr.Recognizer();
    with sr.Microphone() as source:
        myRec.energy_threshold = 1000; # Increase to reduce noise
        audioData = myRec.listen(source);
    try:
        return myRec.recognize_sphinx(audioData);
    except:
        return "";