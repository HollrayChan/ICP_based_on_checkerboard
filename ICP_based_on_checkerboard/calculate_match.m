%load(fullfile('C:\Users\Administrator.USER-20190423VA\Desktop\image\test_backup\HIK_single\matlab.mat'));
filepath_1='C:\Users\XiChen\Documents\ICP\CP_ICP\savemat\left\';%文件夹的路径  %遍历文件夹.mat 文件   两两使用下面的匹配
filepath_2='C:\Users\XiChen\Documents\ICP\CP_ICP\savemat\right\';
%load([filepath '09-Sep-2019-00-00-00' '.mat'])
for i=1:3  %n是要读入的文件的个数
    load([filepath_1 '09-Sep-2019-00-00-00' '.mat']);
    matchedPoints1 = grid_pts';
    load([filepath_2 '08-Sep-2019-00-00-00' '.mat']);
    matchedPoints2 = grid_pts';

    %load(fullfile('C:\Users\Administrator.USER-20190423VA\Desktop\image\test_backup\HIK_single\matlab.mat')); 

    R = stereoParams.RotationOfCamera2
    t = stereoParams.TranslationOfCamera2

    camMatrix1 = cameraMatrix(stereoParams.CameraParameters2, eye(3), [0 0 0]);
    % [R, t] = cameraPoseToExtrinsics(orient, loc);
    camMatrix2 = cameraMatrix(stereoParams.CameraParameters2, R, t);

    points3D_M = triangulate(matchedPoints1, matchedPoints2, camMatrix1, camMatrix2);
    points3D_D = triangulate(matchedPoints1, matchedPoints2, camMatrix1, camMatrix2);
    [Ricp Ticp ER T] = icp(points3D_M, points3D_D, 10);  %M、D输入三维矩阵，i迭代次数，默认10。返回值Ricp、Ticp代表旋转平移关系
end