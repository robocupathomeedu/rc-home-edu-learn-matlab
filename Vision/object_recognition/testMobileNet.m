%% Image Classification Test with MobileNet
%
% Copyright 2019 The MathWorks, Inc.

%% Load the pretrained MobileNet model.
% To modify classes, edit the following function.
loadMobileNet;

%% Get an image and classify it

% Load an image
% img = imread('pears.png'); % Or use your own!
img = imread('2019-May-23_10-54-10.jpg');

% Find class predictions and maximum probability
imgResized = imresize(img,[224 224]);
predictions = predict(mobilenet,imgResized);
classPredictions = predictions(classIndices);
classPredictions = classPredictions./sum(classPredictions);
[maxP,maxIdx] = max(classPredictions);
[~,sortIdx] = sort(classPredictions,'descend');
classNames{sortIdx(1:5)}

% Display the image with its classification results
predictionText = sprintf('%s : %.2f%%',classNames{maxIdx},maxP*100);
imgResized = insertText(imgResized,[0 0],predictionText,'FontSize',16);
imshow(imgResized)