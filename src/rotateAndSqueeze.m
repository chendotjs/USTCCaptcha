function [rAngle, Ir] = rotateAndSqueeze(I, pointX, pointY, angle1, angle2)
  width = [];
  for angle = angle1:angle2
    Ir = imrotatep(I, pointX, pointY, angle);
    % figure();
    % imshow(Ir);
    width = [width, squeeze(Ir)];
  end
  % 找到极小值的点然后旋转图像
  minwidth = min(width);
  logicIdx = width == ones(size(width)) * minwidth; % 为1，预示着哪些角度是最瘦的旋转角度
  % 下面就是找到最长的一段为1的连续子序列，去中点作为旋转角度
  flag = zeros(length(logicIdx), length(logicIdx));
  maxLength = -1; % 最长连续子序列的长度
  i = 1; j = i;
  while i <= length(logicIdx)
    if logicIdx(i) == 1
      j = i;
      while j <= length(logicIdx) && logicIdx(j) == 1
        j = j + 1;
      end
      flag(i, j) = j - i;
      if j - i > maxLength
        maxLength = j - i;
        left = i;
        right = j;
      end
      i = j;
    else
      i = i + 1;
    end
  end
  rAngle = (left + right) / 2 + angle1;
  Ir = imrotatep(I, pointX, pointY, rAngle);
end  % function


function width = squeeze(I)
  [x, y] = size(I);

  for j = 1:y
    if prod(I(:,j)) == 0
      left = j;
      break;
    end
  end

  for j = sort(1:y,'descend')
    if prod(I(:,j)) == 0
      right = j;
      break;
    end
  end

  width = right - left;
end
