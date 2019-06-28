# Python speech recognition code using CMU PocketSphinx
# Source: https://pypi.python.org/pypi/SpeechRecognition/

import speech_recognition as sr
import os 

def listenToText():

    # Add your own keywords here
    keywords = [("robot",1.0),("kitchen",1.0),("bedroom",1.0),("bathroom",1.0)];

    # Link to a language model
    dir_path = os.path.dirname(os.path.realpath(__file__))
    lm_path = os.path.join(dir_path,'..','..','Tasks','speech_person','trieste.lm');
    dict_path = os.path.join(dir_path,'..','..','Tasks','speech_person','trieste.dic');

    myRec = sr.Recognizer();
    with sr.Microphone() as source:
        myRec.energy_threshold = 1000; # Increase to reduce noise
        audioData = myRec.listen(source);

    try:
        
        # Call speech recognizer with language model and dictionary (not sure if it works)
        # return myRec.recognize_sphinx(audioData, lm=lm_path, dict=dict_path);

        # Call speech recognizer with keywords (not sure if this works)
        # return myRec.recognize_sphinx(audioData, keyword_entries=keywords);

        # Call speech recognizer with all defaults
        return myRec.recognize_sphinx(audioData);

    except:
        return "";