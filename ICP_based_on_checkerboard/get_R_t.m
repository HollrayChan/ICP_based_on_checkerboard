list=fullfile('C:\Users\Administrator.USER-20190423VA\Desktop\image\test_backup\1\RL');
images = imageDatastore(list);
I1 = readimage(images, 1);
[Ricp Ticp ER T] = icp(M, D, 10);      %M、D输入三维矩阵，i迭代次数，默认10。返回值Ricp、Ticp代表旋转平移关系