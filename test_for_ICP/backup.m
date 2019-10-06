load(fullfile('C:\Users\Administrator.USER-20190423VA\Desktop\endos_image\1.mat'));
showExtrinsics(stereoParams);
% d=dir('./2dpoints');
% pointnum = length(d)-2;
% pointcell = cell(pointnum, 1);
% for i=1:pointnum
%     path=d(i+2).folder;
%     fileame=d(i+2).name;
%     pointcell{i,1} =load(strcat(path,'/',fileame));
% end

load('C:\Users\Administrator.USER-20190423VA\Desktop\endos_image\2d\l1.mat'); 
L_1 = grid_pts';
load('C:\Users\Administrator.USER-20190423VA\Desktop\endos_image\2d\l2.mat'); 
L_2 = grid_pts';
load('C:\Users\Administrator.USER-20190423VA\Desktop\endos_image\2d\r1.mat'); 
R_1 = grid_pts';
load('C:\Users\Administrator.USER-20190423VA\Desktop\endos_image\2d\r2.mat'); 
R_2 = grid_pts';

R = stereoParams.RotationOfCamera2;
t = stereoParams.TranslationOfCamera2;

camMatrix1 = cameraMatrix(stereoParams.CameraParameters2, eye(3), [0 0 0]);
% [R, t] = cameraPoseToExtrinsics(orient, loc);
camMatrix2 = cameraMatrix(stereoParams.CameraParameters2, R, t);

points3D_M = triangulate(L_1, R_1, camMatrix1, camMatrix2);
points3D_D = triangulate(L_2, R_2, camMatrix1, camMatrix2);
[Ricp Ticp ER T] = icp(points3D_M', points3D_D', 20);  %M、D输入三维矩阵，i迭代次数，默认10。返回值Ricp、Ticp代表旋转平移关系