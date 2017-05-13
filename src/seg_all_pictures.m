clear;clc;

N = 18;
k = 6;
segPath = '../train_seg/';

trainFilesName = listFiles('../train/3000_6_character/*.bmp'); % 图片的名字
trainFilesPath = strcat('../train/3000_6_character/', trainFilesName); % 图片的完整路径

mkdir(segPath);

%for debug
% trainFilesPath = trainFilesPath(1:5, :);

for i = 1:size(trainFilesPath)
  [Centroids, cooridx, IbSet] = seg_picture(trainFilesPath(i, :), k, N);
  for j = 1:k
    seg_img_name = [trainFilesName(i, j), '-', num2str(j), '-', trainFilesName(i, :)]
    % for debug
    % figure();
    % imshow(extractIb(IbSet, N, j));
    % for debug

    % write file
    imwrite(extractIb(IbSet, N, j), [segPath, seg_img_name, '.bmp'], 'bmp');
  end
end

close all;
