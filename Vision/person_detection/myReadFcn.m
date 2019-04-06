%% Custom file reader function - Resizes images to [227 227]
% Copyright 2018 The MathWorks, Inc.
function im = myReadFcn(f)
    im = imresize((imread(f)),[227 227]);
end