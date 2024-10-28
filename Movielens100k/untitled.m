clear all
load Ratings_Matrix
ratings=ratings';
cc=10;
ratings=clean(ratings,cc);
ratings=mean_normalized_ratings(ratings);
%% Split Items
attachment=600;
x=randperm(length(ratings,2));
items_for_attachment=x(1:attachment);items_for_experiments=x(attachment+1:end);
I_est=ratings(:,items_for_attachment);I_exp=ratings(:,items_for_experiment);
%% Split users
n_existing=100;n_train=100;
y=randperm(length(ratings,1));
users_existing=y(1:n_existing);users_trn=y(n_existing+1:n_existing+n_train);users_tst=y(n_existing+n_train+1:end);

%% Estimate NN Attachment for each user
NN=5;
A_trn=attachment_pattern(ratings(users_existing,I_est),ratings(users_trn,I_est),NN);
A_tst=attachment_pattern(ratings(users_existing,I_est),ratings(users_trn,I_est),NN);
ratings(users_trn,I_est)
ratings(users_tst,I_est)

%% Shift operator for each item in I_exp



NN=5;
[B,BI]=similarity_matrix_calculator(r_existing,NN);
