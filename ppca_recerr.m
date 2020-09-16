function [rec, errs] = ppca_recerr(X, Bmat)

rec = X * Bmat.';
errs = (rec - X).^2;

end