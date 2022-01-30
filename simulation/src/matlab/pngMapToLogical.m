
clear; clc;

myFolder = '..\MapImgs';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isfolder(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', myFolder);
    uiwait(warndlg(errorMessage));
    myFolder = uigetdir(); % Ask for a new one.
    if myFolder == 0
         % User clicked Cancel
         return;
    end
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.png'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

load '..\EnvOccupancyMapDb\objects\chargingStationTemplate.mat'
load '..\EnvOccupancyMapDb\objects\loadingStaTemplate.mat'
load '..\EnvOccupancyMapDb\objects\unloadingStaTemplate.mat'

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Now do whatever you want with this file name,
    % such as reading it in as an image array with imread()
    imageArray = imread(fullFileName);
    grayimage = rgb2gray(imageArray);
    chargingStations = findPatternInBinaryImage(grayimage, chargingStationTemplate);
    loadingStations = findPatternInBinaryImage(grayimage, loadingStaTemplate);
    unloadingStations = findPatternInBinaryImage(grayimage, unloadingStaTemplate);

    figure
    subplot(211)
    imshow(grayimage)

    %bwimage = grayimage < 0.5;
    imageNorm = double(grayimage)/255;
    imageOccupancy = 1 - imageNorm;

    map = occupancyMap(imageOccupancy,1);
    neighChSta = [chargingStations + [-1 -1]; chargingStations + [-1 0]; chargingStations + [-1 1];
                  chargingStations + [0 -1]; chargingStations + [0 0]; chargingStations + [0 1];
                  chargingStations + [1 -1]; chargingStations + [1 0]; chargingStations + [1 1]];

    setOccupancy(map, neighChSta, zeros(length(neighChSta(:,1)),1))

    %chargingStations = chargingStations*2;
    %inflate(map, 0.5)
    subplot(212)
    show(map)
    r(1:length(chargingStations)) = 1;
    viscircles(chargingStations, r)

    r(1:length(loadingStations)) = 1;
    viscircles(loadingStations, r)
    
    r(1:length(unloadingStations)) = 1;
    viscircles(unloadingStations, r)
    

    save(strcat(erase(strcat('..\EnvOccupancyMapDb\',baseFileName),'.png'),'.mat'), 'chargingStations','loadingStations','unloadingStations','map')
end
