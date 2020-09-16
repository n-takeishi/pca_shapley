function phi = shapley_mc(valfunc, d, j, num_iter)
%SHAPLEY_MC
% valfunc(S) should return <n x 1> matrix of value functions

if nargin<4, num_iter = 100; end

phi = 0;
count = 0;
for i=1:num_iter*2
    % draw random permutation of (1, ..., d)
    O = randperm(d);
    
    % Predecessors of j in O
    idx = find(O==j);
    if idx == 1, continue; end
    if idx == d, continue; end
    pre = O(1:idx-1);
    
    % evaluate value function
    S1 = [pre, j];
    S2 = pre;
    newval = valfunc(S1) - valfunc(S2);
    
    phi = phi + newval;
    count = count + 1;
    
    if count == num_iter, break; end
end
phi = phi / count;

end