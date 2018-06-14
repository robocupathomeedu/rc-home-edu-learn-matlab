### README: Gender Detection Example

### Source: 
Age and Gender Classification using Convolutional Neural Networks
Gil Levi and Tal Hassner, The Open University of Israel
https://www.openu.ac.il/home/hassner/projects/cnn_agegender/

### Setup steps:

1.  Download the image data from 
    https://www.openu.ac.il/home/hassner/Adience/data.html#agegender

2.  Extract the archive and make sure the following files are on the MATLAB path
    * Label text files, e.g. `fold_0_data.txt` 
    * Aligned face folders, e.g., `aligned\7153718@N04`

3.  Run the `createGenderDatastore.m` script to parse the data into a MATLAB 
    ImageDatastore object that is usable for neural networks
    
4.  Download the Caffe models from one of the following links and make sure 
    the `deploy_gender.prototxt` file is on the MATLAB search path.
    * https://github.com/GilLevi/AgeGenderDeepLearning
    * https://gist.github.com/GilLevi/c9e99062283c719c03de

5.  Install the Neural Network Toolbox Importer for Caffe Models 
    from the Add-On Manager (Home > Add-Ons > Get Add-Ons)

6.  Run the `trainGenderNet.m` script