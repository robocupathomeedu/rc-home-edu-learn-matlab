# Python speech recognition code using CMU PocketSphinx
# Source: https://pypi.python.org/pypi/SpeechRecognition/

import speech_recognition as sr

def listenToText():

    myRec = sr.Recognizer();
    with sr.Microphone() as source:
        audioData = myRec.listen(source);

    try:
        return myRec.recognize_sphinx(audioData);
    except:
        return "";