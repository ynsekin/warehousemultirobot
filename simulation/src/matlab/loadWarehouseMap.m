
cd .\data\EnvOccupancyMapDb
[file,path] = uigetfile('*.mat', "Select Environment Occupancy Map");
cd ..\..\
if isequal(file,0)
    disp('User selected Cancel');
else
    disp(['Selected Map: ', fullfile(path,file)]);
    load(fullfile(path,file));
    %show(map)
    %title("Shows Selected Map For Visualization. Close It")
end