clear;clc;

N = 25;
k = 4;
segPath = '../test_seg/';

testFilesName = listFiles('../test/*.bmp'); % 图片的名字
testFilesPath = strcat('../test/', testFilesName); % 图片的完整路径

mkdir(segPath);

%for debug
% testFilesPath = testFilesPath(1:5, :);

for i = 1:size(testFilesPath)
  i
  [Centroids, cooridx, IbSet] = seg_picture(testFilesPath(i, :), k, N);
  for j = 1:k
    seg_img_name = [testFilesName(i, j), '-', num2str(j), '-', testFilesName(i, :)]
    % for debug
    % figure();
    % imshow(extractIb(IbSet, N, j));
    % for debug

    % write file
    imwrite(extractIb(IbSet, N, j), [segPath, seg_img_name], 'bmp');
  end
end

close all;
