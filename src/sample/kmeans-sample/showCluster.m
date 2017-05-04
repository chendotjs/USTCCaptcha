function Ibnew = showCluster(Ib, idx, coor, vec, cluster)
  Ibnew = ones(size(Ib));
  for i = 1:size(vec)
    x = coor(i, 1);
    y = coor(i, 2);

    if idx(i) == cluster
      Ibnew(x, y) = 0;
    end
  end
  figure(cluster);
  imshow(Ibnew)
end
