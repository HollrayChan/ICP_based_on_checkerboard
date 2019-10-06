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
load('C:\Users\Administrator.USER-20190423VA\Desktop\endos_image\2d\R1.mat'); 
R_1 = grid_pts';
load('C:\Users\Administrator.USER-20190423VA\Desktop\endos_image\2d\R2.mat'); 
R_2 = grid_pts';

R = stereoParams.RotationOfCamera2;
t = stereoParams.TranslationOfCamera2;

camMatrix1 = cameraMatrix(stereoParams.CameraParameters2, eye(3), [0 0 0]);
% [R, t] = cameraPoseToExtrinsics(orient, loc);
camMatrix2 = cameraMatrix(stereoParams.CameraParameters2, R, t);

points3D_M = triangulate(L_1, R_1, camMatrix1, camMatrix2);
points3D_D = triangulate(L_2, R_2, camMatrix1, camMatrix2);

cameraSize = 10;
figure
plotCamera('Size', cameraSize, 'Color', 'r', 'Label', '1', 'Opacity', 0);
hold on
grid on
loc = [0 0 0]
orient = eye(3)
plotCamera('Location', loc, 'Orientation', orient, 'Size', cameraSize, ...
    'Color', 'b', 'Label', '2', 'Opacity', 0);

pcshow(points3D_M, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down',  'MarkerSize', 100);
pcshow(points3D_D, 'VerticalAxis', 'y', 'VerticalAxisDir', 'down',  'MarkerSize', 100);

camorbit(0, -30);
camzoom(1.5);

[Ricp Ticp ER T] = icp(points3D_M', points3D_D', 10);  %M、D输入三维矩阵，i迭代次数，默认10。返回值Ricp、Ticp代表旋转平移关系