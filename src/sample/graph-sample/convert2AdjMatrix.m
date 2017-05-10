% 将二值图片转换成邻接矩阵

function matrix = convert2AdjMatrix(bimg)
  [x, y] = size(bimg);
  matrix = zeros(x * y, x * y);
  for i =  1:x
    for j = 1:y
      if bimg(i, j) == 1
        c = mPos(i, j, x, y);
        if inRange(i - 1, j, x, y) == 1 && bimg(i - 1, j) == 1 % up
          n = mPos(i - 1, j, x, y);
          matrix(c,n) = 1;
        end
        if inRange(i + 1, j, x, y) == 1 && bimg(i + 1, j) == 1 % down
          n = mPos(i + 1, j, x, y);
          matrix(c,n) = 1;
        end
        if inRange(i, j - 1 , x, y) == 1 && bimg(i, j - 1) == 1 % left
          n = mPos(i, j - 1, x, y);
          matrix(c,n) = 1;
        end
        if inRange(i, j + 1 , x, y) == 1 && bimg(i, j + 1) == 1 % right
          n = mPos(i, j + 1, x, y);
          matrix(c,n) = 1;
        end
        if inRange(i - 1, j - 1, x, y) == 1 && bimg(i - 1, j - 1) == 1 % left-up
          n = mPos(i - 1, j - 1, x, y);
          matrix(c,n) = 1;
        end
        if inRange(i - 1, j + 1, x, y) == 1 && bimg(i - 1, j + 1) == 1 % right-up
          n = mPos(i - 1, j + 1, x, y);
          matrix(c,n) = 1;
        end
        if inRange(i + 1, j - 1, x, y) == 1 && bimg(i + 1, j - 1) == 1 % left-down
          n = mPos(i + 1, j - 1, x, y);
          matrix(c,n) = 1;
        end
        if inRange(i + 1, j + 1, x, y) == 1 && bimg(i + 1, j + 1) == 1 % right-down
          n = mPos(i + 1, j + 1, x, y);
          matrix(c,n) = 1;
        end
      end
    end
  end
end


function valid = inRange(i, j, x, y)
  if i >= 1 && i <= x && j >= 1 && j <= y
    valid = 1;
  else
    valid = 0;
  end
end

function pos = mPos (i, j, x, y)
  pos =  (i - 1) * y + j;
end
