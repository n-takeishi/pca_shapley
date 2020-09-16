function phi = shapley_exact(valfunc, d, j)
%SHAPLEY_EXACT
% valfunc(S) should return <n x 1> matrix of value functions

D = [1:j-1, j+1:d];

phi = 0;
for k=0:d-1
    % subsets
    Ss = nchoosek(D, k);
    
    weight = 1 / nchoosek(d-1, k) / d;
    for i=1:size(Ss,1)
        S = Ss(i,:);
        
        % evaluate value function
        S1 = [S, j];
        S2 = S;
        newval = valfunc(S1) - valfunc(S2);

        phi = phi + newval*weight;
    end
end
end