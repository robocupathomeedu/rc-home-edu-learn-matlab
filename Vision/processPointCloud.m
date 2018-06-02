% Introduction to point cloud processing

% Copyright 2018 The MathWorks, Inc.

%% Setup
connectToRobot;
pcSub = rossubscriber(DEPTH_POINTS);
close all

%% Receive and visualize the point cloud data
pcMsg = receive(pcSub);
scatter3(pcMsg);

%% (Optional) Perform processing on the point cloud
close all
% Convert to Computer Vision System Toolbox point cloud
pCloud = pointCloud(readXYZ(pcMsg),'Color',double(readRGB(pcMsg)));
figure
pcshow(pCloud)
title('Raw Point Cloud');

% Filter the point cloud by maximum depth
maxDepth = 3;
maxHeight = 0.25;
indices = find((pCloud.Location(:,3) < maxDepth) & ... 
               (pCloud.Location(:,2) < maxHeight));
pCloud = select(pCloud,indices);
% Denoise the point cloud to remove outliers
pCloud = pcdenoise(pCloud,'NumNeighbors',10);
figure
pcshow(pCloud)
title('Filtered and Denoised Point Cloud');

% Segment the point cloud into clusters
minDistance = 0.1;
[labels,numClusters] = pcsegdist(pCloud,minDistance);
figure
pcshow(pCloud.Location,labels,'MarkerSize',15);
title(['Clustered Obstacle Point Cloud, N = ' num2str(numClusters)]);