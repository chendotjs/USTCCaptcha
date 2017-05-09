clc;clear;

filesAndDirs  = dir('../../../test/')

imgFiles = dir('../../../test/*.bmp')

AimgFiles = dir('../../../test/A*.bmp')

for i = 1:size(AimgFiles)
  fprintf('%d image prefixed with A:%s\n', i, AimgFiles(i).name);
end
