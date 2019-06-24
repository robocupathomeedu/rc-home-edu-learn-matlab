function setupAgeDetector()
% Setup function for age detection network

% NOTE 1: Please run this from the folder containing this function, 
% since the path to the models folder is relative.
% NOTE 2: You will need to install the Deep Learning Toolbox Importer 
% for Caffe Networks Add-On to successfully run this script

% Copyright 2019 The MathWorks, Inc.

% Define folder/model names and options
modelFolder = 'models';
modelAge = 'ageNetwork';
ageGenderMeanImage = 'age_gender_mean';
insertIntoProtoFile = @(modelFolder,filename,DataType) cat(2, ...
    'layer {', newline,'  top: "data"', newline, '  top: "label"', newline, ...
    '  name: "data"', newline, '  type: ', DataType, newline, ... 
    '  transform_param {', newline, '    crop_size: 224', newline, ...
    '    mirror: false', newline, ...
    '    mean_file: "', modelFolder, '/', filename, '.binaryproto"', newline, ...
    '  }', newline, '  include: { ', newline, '    phase: TEST', newline, ...
    '    stage: "test-on-test"', newline, ' }', newline, '}', newline);
options = weboptions('ContentType','text');

% Create a model folder if it doesn't exist
if ~exist(modelFolder,'dir')
    mkdir(modelFolder)
end

% Download Mean Image for age and gender classification
if ~isfile(fullfile(modelFolder,[ageGenderMeanImage,'.binaryproto']))
    fprintf(1,'Downloading mean image for age and gender classification...')

    % Download binaryproto
    ageGenderAuxiliaryFiles = websave(fullfile(modelFolder,'caffe_ilsvrc12.tar.gz'), ...
        'http://dl.caffe.berkeleyvision.org/caffe_ilsvrc12.tar.gz');
    untar(ageGenderAuxiliaryFiles,fullfile(modelFolder,'auxiliaryFiles'))
    copyfile(fullfile(modelFolder,'auxiliaryFiles','imagenet_mean.binaryproto'),...
        fullfile(modelFolder,[ageGenderMeanImage,'.binaryproto']))
    rmdir(fullfile(modelFolder,'auxiliaryFiles'),'s')
    delete(ageGenderAuxiliaryFiles)

    fprintf(1,'[DONE]\n')
end

% Download Caffe model and protofile for age classification
if ~isfile(fullfile(modelFolder,[modelAge,'.caffemodel']))
    fprintf(1,'Downloading Caffe model for age classification. This may take a few minutes...');
    netAgeModelFilename = websave(fullfile(modelFolder,[modelAge,'.caffemodel']), ...
        'https://data.vision.ee.ethz.ch/cvl/rrothe/imdb-wiki/static/dex_chalearn_iccv2015.caffemodel');
else
    netAgeModelFilename = fullfile(modelFolder,[modelAge,'.caffemodel']);
end

% Download and modify age protofile to include mean image    
netAgeProtoFilename = fullfile(modelFolder,[modelAge,'_deploy.prototxt']);
if ~isfile(fullfile(modelFolder,[modelAge,'._deploy.prototxt']))
    netAgeProtoFile = webread('https://data.vision.ee.ethz.ch/cvl/rrothe/imdb-wiki/static/age.prototxt',options);
    netAgeProtoFile = [netAgeProtoFile(1:29), insertIntoProtoFile(modelFolder,ageGenderMeanImage,'"ImageData"'), netAgeProtoFile(100:end)];
    fid = fopen(netAgeProtoFilename,'wt');
    fprintf(fid, '%s', netAgeProtoFile);
    fclose(fid);
end

fprintf(1,'[DONE]\n')
    
% Prepare age classification network in MATLAB format
if ~isfile(fullfile(modelFolder,[modelAge,'.mat']))
    fprintf(1,'Converting age classification network to MATLAB format...');
    classes = string(0:100);
    ageNet = importCaffeNetwork(netAgeProtoFilename,netAgeModelFilename,'Classes',classes,'InputSize',[224,224,3]);  % Average image to be taken from protofile
    save(fullfile(modelFolder,modelAge),'ageNet');
    fprintf(1,'[DONE]\n')
end

end