function [label] = knn_predict(Mdl, Ib)
  vec = reshape(Ib, 1, 625);
  label = predict (Mdl, vec);
end
