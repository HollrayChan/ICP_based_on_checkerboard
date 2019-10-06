load(fullfile('C:\Users\Administrator.USER-20190423VA\Desktop\endoscopy_board\2dpoints\doucameracali.mat'));
showExtrinsics(stereoParams);
% d=dir('./2dpoints');
% pointnum = length(d)-2;
% pointcell = cell(pointnum, 1);
% for i=1:pointnum
%     path=d(i+2).folder;
%     fileame=d(i+2).name;
%     pointcell{i,1} =load(strcat(path,'/',fileame));
% end

load('./2dpoints/L_black.mat'); 
L_black2d = grid_pts';
load('./2dpoints/L_white.mat'); 
L_white2d = grid_pts';
load('./2dpoints/R_black.mat'); 
R_black2d = grid_pts';
load('./2dpoints/R_white.mat'); 
R_white2d = grid_pts';

R = stereoParams.RotationOfCamera2;
t = stereoParams.TranslationOfCamera2;

camMatrix1 = cameraMatrix(stereoParams.CameraParameters2, eye(3), [0 0 0]);
% [R, t] = cameraPoseToExtrinsics(orient, loc);
camMatrix2 = cameraMatrix(stereoParams.CameraParameters2, R, t);

points3D_M = triangulate(L_black2d, R_black2d, camMatrix1, camMatrix2);
points3D_D = triangulate(L_white2d, R_white2d, camMatrix1, camMatrix2);

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

[Ricp Ticp ER T] = icp(points3D_M', points3D_D', 2);  %M、D输入三维矩阵，i迭代次数，默认10。返回值Ricp、Ticp代表旋转平移关系