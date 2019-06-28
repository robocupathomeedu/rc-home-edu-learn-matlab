% RoboCup@Home Education Workshop startup script
% Copyright 2018-2019 The MathWorks, Inc.

%% Setup
clear
clc
close all
disp('** Welcome to RoboCup@Home Education! **')

%% Add subfolders to the path
addpath(genpath('IntroROS'),    genpath('Manipulation'), ...
        genpath('Navigation'),  genpath('Speech'), ... 
        genpath('Vision'),      genpath('Tasks'), ...
        genpath('Utilities'));
    
%% Set cache and code generation folders to a "work" folder
% Make the work folder if it doesn't exist
if ~isfolder(fullfile(pwd,'work'))
    mkdir('work');
end
Simulink.fileGenControl('set','CacheFolder','work','CodeGenFolder','work');