function [goalPoint,objType,outputMsg] = parseCommand(speechStr)
% PARSECOMMAND Simple parser that searches for object types and locations 
% in a string. Fill this out with different commands and locations

% Copyright 2018 The MathWorks, Inc.

% Convert everything to lower case just in case (pun intended)
speechStr = lower(speechStr);

% Find the object type
if contains(speechStr,'blue')
    objType = 'blue';
elseif contains(speechStr,'red')
    objType = 'red';
elseif contains(speechStr,'green')
    objType = 'green';
else
    objType = '';
end

% Find the goal name
if contains(speechStr,'kitchen')
    goalPoint = [1.5 -10];
    goalName = 'kitchen';
elseif contains(speechStr,'living')
    goalPoint = [-5 4];
    goalName = 'living room';
elseif contains(speechStr,'bedroom')
    goalPoint = [0.5 0.5];
    goalName = 'bedroom';
else
    goalPoint = [];
    goalName = '';
end

% Define the output message
outputMsg = '';
if isempty(objType)
    outputMsg = 'I did not hear a valid object name. ';
end
if isempty(goalName)
    outputMsg = [outputMsg 'I did not hear a valid goal location. '];
end
if ~isempty(objType) && ~isempty(goalName)
    outputMsg = ['Finding the ' objType ' object in the ' goalName '.'];
end

end

