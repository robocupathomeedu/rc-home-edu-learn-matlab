%% Image Classification Test with MobileNet
%
% Copyright 2019 The MathWorks, Inc.

%% Load the pretrained AlexNet model.
% To modify classes, edit the following function.
loadAlexNet;

%% Get an image and classify it

% Load an image
% img = imread('pears.png'); % Or use your own!
img = imread('2019-May-23_10-54-10.jpg');

% Find class predictions and maximum probability
imgResized = imresize(img,[227 227]);
predictions = predict(net,imgResized);
classPredictions = zeros(size(classNames));
for ii = 1:numel(classNames) 
   for jj = 1:numel(classIndices{ii})
       classPredictions(ii) = sum(predictions(classIndices{ii}));
   end
end
classPredictions = classPredictions./sum(classPredictions);
[maxP,maxIdx] = max(classPredictions);
[maxSubP,maxSubIdx] = max(predictions(classIndices{ii}));

% Display the image with its classification results
predictionText = sprintf('%s : %.2f%%',classNames{maxIdx}{maxSubIdx},maxP*100);
imgResized = insertText(imgResized,[0 0],predictionText,'FontSize',16);
imshow(imgResized)