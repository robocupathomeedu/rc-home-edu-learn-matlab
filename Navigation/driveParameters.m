%% Drive parameters for Simulink model
% Copyright 2018 The MathWorks, Inc.

sampleTime = 0.1;       % Overall sample time
mapUpdateTime = 5;      % Sample time for map visualizer

linearGain = 0.3;       % Proportional gain for linear velocity
angularGain = 1.5;      % Proportional gain for angular velocity

maxLinearRate = 0.5;    % Max rate for linear velocity
maxAngularRate = 1.5;   % Max rate for angular velocity