function marrtinoTTS(m,textToSpeak,language)
% Text to speech (TTS) with MARRtino
% Inputs are
%   m : TCP/IP client created with marrtinoSpeech function
%   textToSpeak : text 
%   language : language to use for speech, for example
%               'en' (English) or  'it' (Italian)

% Copyright 2019 The MathWorks, Inc.
 
% Clear the buffer in the MARRtino client
read(m); 

% Configure default language if not defined
if nargin < 3
    language = 'en';
end

% Send TTS request
sendData = uint8(['TTS[' language '] ' textToSpeak newline char(13)]);
write(m,sendData)
