%% IMPORT
% Import from file
lgraph = importKerasLayers('mobilenet.h5','ImportWeights',true, ...
    'OutputLayerType','classification');

% Replace unsupported layers
lgraph = removeLayers(lgraph,{'reshape_1','reshape_2'});
lgraph = connectLayers(lgraph,'global_average_pooling2d_1','dropout');
lgraph = connectLayers(lgraph,'act_softmax','ClassificationLayer_reshape_2');

% Get class information
data = webread('https://storage.googleapis.com/download.tensorflow.org/data/imagenet_class_index.json');
numClasses = numel(fields(data));
classNames = cell(numClasses,1);
for idx = 1:numClasses
    classNames{idx} = data.(['x' num2str(idx-1)]){2};
end
% Replace nonunique class names (manual for now)
classNames{135} = [classNames{135} '1'];
classNames{639} = [classNames{639} '1'];
lgraph = replaceLayer(lgraph,'ClassificationLayer_reshape_2', ...
    classificationLayer('Name','Classification','Classes',classNames));

% Assemble the network
mobilenet = assembleNetwork(lgraph);
analyzeNetwork(mobilenet);

% Save the network
save mobilenet mobilenet