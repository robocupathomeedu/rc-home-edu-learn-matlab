%% Train gender detection neural network
%
% For setup steps, see README_GENDER.md
%
% Source: 
% Age and Gender Classification using Convolutional Neural Networks
% Gil Levi and Tal Hassner, The Open University of Israel
% https://www.openu.ac.il/home/hassner/projects/cnn_agegender/
%
% Copyright 2018 The MathWorks, Inc.

addpath(genpath(pwd));

%% Import Caffe model layers
% NOTE: There will be a warning regarding an average pooling layer since
% the padding computation is different in MATLAB vs. Caffe. This is why we
% need to retrain the model instead of importing the already-trained one.
layers = importCaffeLayers('deploy_gender.prototxt');

%% Load image datastore and split into training/validation/test data
load faceDatastoreAligned
countEachLabel(imds)
[imdsTrain,imdsVal,imdsTest] = splitEachLabel(imds,5000,1000,'randomized');

%% Train the network
options = trainingOptions('sgdm', ...
                          'MaxEpochs',100,...
                          'InitialLearnRate',1e-3,...
                          'LearnRateSchedule','piecewise',...
                          'LearnRateDropPeriod',50,...
                          'MiniBatchSize',512,...
                          'ValidationFrequency',20,...
                          'ValidationPatience',10,...
                          'ValidationData',imdsVal,...
                          'Plots','training-progress');
[genderNet,trainingInfo] = trainNetwork(imdsTrain,layers,options);
disp('Network trained.');
save genderNet genderNet

%% Test neural network
YPred = classify(genderNet,imdsTest);
YTest = imdsTest.Labels;
testAccuracy = 100 * sum(YPred == YTest)/numel(YTest)