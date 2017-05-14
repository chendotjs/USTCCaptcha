% 围着某个点进行旋转
function [Im] = imrotatep(I, pointX, pointY, angle)
  Im = imcomplement(I); % 反色，以免旋转后产生黑色的框角
  Im = rotateAround(Im, pointY, pointX, angle);
  Im = imcomplement(Im); % 反色变回原来的颜色
end
