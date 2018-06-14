%% Train gender detection neural network
%
% For setup steps, see README_GENDER.txt
%
% Source: 
% Age and Gender Classification using Convolutional Neural Networks
% Gil Levi and Tal Hassner, The Open University of Israel
% https://www.openu.ac.il/home/hassner/projects/cnn_agegender/
%
% Copyright 2018 The MathWorks, Inc.

addpath(genpath(pwd));

%% Import model
layers = importCaffeLayers('deploy_gender.prototxt');

%% Load data and split into training and testing data
load faceDatastoreAligned
countEachLabel(imds)
[imdsTrain,imdsVal,imdsTest] = splitEachLabel(imds,5000,1000,'randomized');

%% Train the network
options = trainingOptions('sgdm', ...
                          'MaxEpochs',80,...
                          'InitialLearnRate',1e-3,...
                          'MiniBatchSize',512,...
                          'ValidationFrequency',20,...
                          'ValidationData',imdsVal,...
                          'Plots','training-progress');
genderNet = trainNetwork(imdsTrain,layers,options);
disp('Network trained.');
save genderNet genderNet

%% Test neural net
YPred = classify(genderNet,imdsTest);
YTest = imdsTest.Labels;
testAccuracy = 100 * sum(YPred == YTest)/numel(YTest)