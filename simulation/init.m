
disp("Initializing the environment");

addpath(genpath('data'))
addpath(genpath('src'))

loadWarehouseMap
%load warehouse_packages.mat

% Robot Parameters

rbtprms.nums = size(chargingStations, 2);
rbtprms.radius  = 0.7;
rbtprms.wheelRadius = 0.20;
rbtprms.trackWidth = 0.5;
rbtprms.wheelRPM = 60;
rbtprms.maxLinSpeed = 2*pi*rbtprms.wheelRadius*rbtprms.wheelRPM/60;

rbtprms.saffetyDistance = 0.4;
rbtprms.maxLidarRange = 10;

rbtprms.lidarScnAngles = -pi/2:pi/8:pi/2;


mObsParams.currendPoseIndexes = [1 2 3];
mObsParams.chargeIndex = 4;
mObsParams.hasPkgIndex = 5;
mObsParams.pkgDeliveryPose = [6 7 8];
mObsParams.numPkgsldSt1 = 9;
mObsParams.ldSta1PoseIndex = [10 11 12];
mObsParams.numPkgsldSt2 = 13;
mObsParams.ldSta2PoseIndex = [14 15 16];
mObsParams.lidarRangesIndex = mObsParams.ldSta2PoseIndex(end)+1:mObsParams.ldSta2PoseIndex(end)+length(rbtprms.lidarScnAngles);

mObsParams.observationsLength = mObsParams.lidarRangesIndex(end);
