cell_list = {};

fig_number = 1;

title_figure = 'checkerboard_plane_ICP';

clear fc cc kc KK
kc = zeros(5,1);
%clearwin;

% cell_list{1,1} = {'Image names','data_calib;'};
% cell_list{1,2} = {'Read images','ima_read_calib;'};
cell_list{1,1} = {'Extract grid corners','click_calib;'};
cell_list{1,2} = {'Calculate matching pair','calculate_match;'};

show_window(cell_list,fig_number,title_figure,130,18,0,'clean',12);