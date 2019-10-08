% Loads a pretrained AlexNet model and returns a filtered set of class
% names and class indices.
%
% Copyright 2019 The MathWorks, Inc.

% Load the pretrained MobileNet model
net = alexnet;

% Filter classes by desired categories [MODIFY AS NEEDED]
classNames =  {
    {'banana', 'slug'}, {'orange', 'ping-pong ball'}, {'pineapple'}, ... 
    {'cup', 'coffee mug', 'coffeepot'}, {'water bottle','wine bottle'},...
    {'plastic bag'}, ...
    {'volleyball', 'soccer ball','rugby ball','basketball','football helmet'}, ...
    {'teddy', 'toy poodle'}, ...
    };
fullClassNames = net.Layers(end).Classes;
classIndices = cell(size(classNames));
for ii = 1:numel(classNames) 
    cidx = [];
    for jj = 1:numel(classNames{ii})
        cidx(jj) = find(fullClassNames==classNames{ii}{jj},1);
    end
    classIndices{ii} = cidx;
end