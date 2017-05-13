% 从IbSet中取出第index个图片
function Ib = extractIb(IbSet, N, index)
  Ib = IbSet(:, (index-1)*N+1:index*N);
end
