% demo
clearvars;
rng(1234567890);

%% data

load imports-85;
X = X(~any(isnan(X), 2), :);

X = X(:,[3,4,5,6,7,8,9,10,11,12,13,16]);

% partition
trsize = round(size(X,1)*0.5);
X_tr = X(1:trsize, :);
X_te = X(trsize+1:end, :);

% normalize
mean_tr = mean(X_tr, 1);
std_tr = std(X_tr, [], 1);
X_tr = bsxfun(@minus, X_tr, mean_tr);
X_tr = bsxfun(@times, X_tr, 1./std_tr);
X_te = bsxfun(@minus, X_te, mean_tr);
X_te = bsxfun(@times, X_te, 1./std_tr);

% add anomaly to test data
ano_idx = randi(size(X_te,2), size(X_te,1), 1);
for i=1:size(X_te,1)
    X_te(i,ano_idx(i)) = X_te(i,ano_idx(i))+1;
end

%% test ppcarec

% train
p = 3;
[Bmat, Cmat, sigsq] = ppca(X_tr, p);

% test
[rec_te, errs_te] = ppca_recerr(X_te, Bmat);

%% test val_marginal

val_te = val_marginal(Cmat, Bmat, X_te, 1:size(X,2));

%% test shapley_mc

num_iter = 100; % number of Monte Carlo iterations

target_features = 1:size(X,2);
valfunc = @(S) val_marginal(Cmat, Bmat, X_te, S);

shapley1_te = zeros(size(X_te));
tic;
for i=1:numel(target_features)
    shapley1_te(:,i) = shapley_exact(valfunc, size(X,2), target_features(i));
end
comptime1 = toc;

shapley2_te = zeros(size(X_te));
tic;
for i=1:numel(target_features)
    shapley2_te(:,i) = shapley_mc(valfunc, size(X,2), target_features(i), num_iter);
end
comptime2 = toc;

%% plot

k = 1; % datapoint index to be examined

figure;

subplot(311); bar(errs_te(k,:));
xlabel('reconstruction error');
title(sprintf('anomalous feature # (i.e., ground truth) = %d', ano_idx(k)));

subplot(312); bar(abs(shapley1_te(k,:)));
xlabel(sprintf('Shapley value (exact), avg. comp. time = %0.4f sec', ...
    comptime1/size(X_te,1)));

subplot(313); bar(abs(shapley2_te(k,:)));
xlabel(sprintf('Shapley value (MC), avg. comp. time = %0.4f sec', ...
    comptime2/size(X_te,1)));
