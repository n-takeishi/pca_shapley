function val = val_marginal(Cmat_tr, Bmat_tr, X_te, S)
%VAL_MARGINAL
% X_te : <n x d>
% S    : a set of feature indices

d = size(X_te, 2);
s = numel(S);

if ~isempty(S)
    assert(max(S) <= d);
    assert(min(S) >= 1);
end

% split X
X_S = X_te(:, S);

% split Cmat and Bmat
Sc = setdiff(1:d, S);
C_Sc  = Cmat_tr(Sc, Sc);
C_ScS = Cmat_tr(Sc, S);
C_S   = Cmat_tr(S,  S);
B_Sc  = Bmat_tr(Sc, Sc);
B_ScS = Bmat_tr(Sc, S);
B_S   = Bmat_tr(S,  S);

% statistics of conditional distribution
CC = C_ScS / C_S;
m_Sc = X_S * CC.'; % <n x d>
V_Sc = C_Sc - CC * C_ScS.';

% tr(A x1 x2') for X = [x; ...; x] --> sum(X2 .* (X1*A.'), 2)
val = trace( (eye(d-s)-B_Sc) * V_Sc ) ...
    + sum(m_Sc .* (m_Sc * (eye(d-s)-B_Sc.')), 2) ...
    - 2*sum(m_Sc .* (X_S * B_ScS.'), 2) ...
    + sum(X_S  .* (X_S * (eye(s)-B_S.')), 2);
val = val / d;

end