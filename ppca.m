function [Bmat, Cmat, sigsq, rec, errs] = ppca(X, p)
%PPCAREC
% [input]
%  X      : centerized data matrix <n x d>
%  p      : dimensionality of latent variables
% [output]
%  Bmat   : optimal reconstruction matrix <d x d>
%  Cmat   : variance matrix of marginal <d x d>
%  sigsq  : observation noise variance
%  rec    : reconstructions <n x d>
%  errs   : reconstruction errors <n x d>

assert(all(abs(mean(X, 1)) < 1e-6), 'data is not centerized');
assert(p < size(X,2), 'latdim must be smaller than data dimension');

% MLE of PPCA
covmat = cov(X);
[eigvecs, eigvals] = eig(covmat, 'vector');
[eigvals, idx] = sort(eigvals, 'descend');
eigvecs = eigvecs(:, idx);
sigsq = mean(eigvals(p+1:end));
W = eigvecs(:,1:p) * diag(sqrt(eigvals(1:p) - sigsq));

% optimal reconstruction matrix
Bmat = W / (W.' * W) * W.';

% variance matrix of marginal distribution
Cmat = W * W.' + sigsq*eye(size(X,2));

% reconstructions and errors
if nargout > 3
    [rec, errs] = ppca_recerr(X, Bmat);
end

end