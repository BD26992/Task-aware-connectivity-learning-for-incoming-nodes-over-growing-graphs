function [r_ex,r_trn,r_tst] = split_users(ratings,n_existing,n_train)
scramble=randperm(size(ratings,1));
i_ex=scramble(1:n_existing);
i_trn=scramble(n_existing+1:n_existing+n_train);
i_tst=scramble(n_existing+n_train+1:size(ratings,1));
r_ex=ratings(i_ex,:);
r_trn=ratings(i_trn,:);
r_tst=ratings(i_tst,:);
end