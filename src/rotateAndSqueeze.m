function [rAngle, Ir] = rotateAndSqueeze(I, pointX, pointY, angle1, angle2)
  width = [];
  for angle = angle1:angle2
    Ir = imrotatep(I, pointX, pointY, angle);
    % figure();
    % imshow(Ir);
    width = [width, squeeze(Ir)]
  end
  plot(angle1:angle2, width, 'ko');
  % TODO: 找到极小值的点然后旋转图像
end  % function


function width = squeeze(I)
  [x, y] = size(I);

  for j = 1:y
    if sum(I(:,j)) < 255 * x
      left = j;
      break;
    end
  end

  for j = sort(1:y,'descend')
    if sum(I(:,j)) < 255 * x
      right = j;
      break;
    end
  end

  width = right - left;
end
