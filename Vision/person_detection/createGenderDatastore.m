%% Creates an imageDatastore of the Adience faces database
%
% Source: 
% Age and Gender Classification using Convolutional Neural Networks
% Gil Levi and Tal Hassner, The Open University of Israel
% https://www.openu.ac.il/home/hassner/projects/cnn_agegender/
%
% Copyright 2018 The MathWorks, Inc.

%% Load the label data from the files and remove invalid indices
allData = [];
for idx = 0:4
    filename = sprintf('fold_%d_data.txt',idx);
    T = readtable(filename,'Delimiter','\t');

    % Convert age and gender to categorical and remove invalid data
    validIdx = ~(strcmp(T.gender,'') | strcmp(T.gender,'u')) ...
               & (contains(string(T.age),"("));
    T = T(validIdx,:);
    T.age = categorical(T.age);
    T.gender = categorical(T.gender);

    allData = [allData; T];
end

%% Create an image datastore
imds = imageDatastore('aligned','IncludeSubfolders',true,'ReadFcn',@myReadFcn);
% Create variables from table variables to minimize indexing
imgData = allData.original_image;
faceIdData = allData.face_id;
userIdData = allData.user_id;
fileData = imds.Files;
genderData = allData.gender;
% Loop through and match datastore indices with label table indices
labels = repmat(allData.gender(1),size(allData,1),1);
indicesToDelete = zeros(size(allData,1),1);
for idx = 1:size(allData,1)
    fileName = [num2str(faceIdData(idx)) '.' imgData{idx}];
    fileIdx = find( contains(fileData,fileName) & ...
                    contains(fileData,userIdData{idx}) );
    if isempty(fileIdx)
       indicesToDelete(fileIdx) = 1;
    else
       labels(fileIdx) = genderData(idx);
    end
end
imds.Labels = labels;

% Delete the indices that did not have a label
imds.Files(find(indicesToDelete)) = [];
imds.Files(~(imds.Labels=='m' | imds.Labels=='f')) = [];

% Save the datastore to a MAT-file
save faceDatastoreAligned imds
disp('Saved Datastore');