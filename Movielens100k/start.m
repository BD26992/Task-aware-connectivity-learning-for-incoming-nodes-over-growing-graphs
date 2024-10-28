% separate N_exist users
% make graph B with pearson correlation coefficient
% make B_i for i=1:1682
% select training set users
% make graph with pearson correlation of N_exist and training users
% from that information, find out connection pattern of each user
% select cold start users
% do the same as with training users
% complete dat set formation
% train and test
% filter order is a variable
clear all
load Ratings_Matrix
% ratings=sparsify(ratings,0.5);
% ratings=ratings';
cc=10;
ratings=clean(ratings,cc);
ratings=mean_normalized_ratings(ratings);
% %%%%%%
% %%%%%%
NN=35;%nearest neighbors
n_users=size(ratings,1);
n_existing=100;%value of N
n_test=50;
% N=n_existing;
% 
n_train=n_users-n_existing-n_test;
K=5;%filter_order
N_iter=1000;
N_rep=100;
I=size(ratings,2);%number of items
%RRep=10;
% %select train and test users
% for r =1: RRep
[r_existing,r_trn,r_tst]=split_users(ratings,n_existing,n_train);
% %[r_existing,r_trn,r_tst]=select_existing_users(ratings);
% r_existing=normalize_ratings(r_existing);
% r_trn=normalize_ratings(r_trn);
% r_tst=normalize_ratings(r_tst);
% %existing graph and item-specific graphs
[B,BI]=similarity_matrix_calculator(r_existing,NN);
lambda_h=10;
[h,Bxih]=find_h(r_existing,B,BI,K,lambda_h);

%load all_items_pre_data
N_iter=100;
%training data generation
[BB_trn,AA_trn,d_trn] = similarity_matrix_calculator_2([r_existing;r_trn],n_existing,NN);
%[BB_tst,AA_tst,d_tst] = similarity_matrix_calculator_2([r_existing;r_tst],n_existing,NN);
%training time
mu_p=[1];
mu_w=[1e-3];
lambda_p=[1e-2];
lambda_w=[1];
MAE_tr_I=cell(7,7);MAE_I=cell(7,7);
RMSE_tr_I=cell(7,7);RMSE_I=cell(7,7);
for i=1:length(mu_p)
for j=1:length(mu_w)
[w,p] = train_coldstart(n_existing,N_iter,r_trn,Bxih,BB_trn,AA_trn,mu_p(i),mu_w(j),lambda_p,lambda_w);
%[MAE_tr_I{i,j},RMSE_tr_I{i,j},MAEFULL_tr(i,j),RMSEFULL_tr(i,j)] = test1_final(w,p,r_trn,N_rep,n_existing,Bxih);
%[MAEFULL_tr(i,j),RMSEFULL_tr(i,j),~,~] = test1_final(w,p,r_trn,N_rep,n_existing,Bxih);
%[MAE_I{i,j},RMSE_I{i,j},MAEFULL(i,j),RMSEFULL(i,j)] = test1_final(w,p,r_tst,N_rep,n_existing,Bxih);
[MAEFULL(i,j),RMSEFULL(i,j),medae,rmedse] = test1_final(w,p,r_tst,N_rep,n_existing,Bxih);
end
end


w_rand=ones(n_existing,1);p_rand=ones(n_existing,1)/n_existing;
%[MAE_rand_i,RMSE_rand_i,MAE_rand,RMSE_rand]=test1_final(w_rand,p,r_tst,N_rep,n_existing,Bxih);
[MAE_rand,RMSE_rand,~,~]=test1_final(w_rand,p,r_tst,N_rep,n_existing,Bxih);
% 
w_pref=ones(n_existing,1);p_pref=diag(B*ones(n_existing,1))/sum(diag(B*ones(n_existing,1)));
%[MAE_pref_i,RMSE_pref_i,MAE_pref,RMSE_pref]=test1_final(w_pref,p,r_tst,N_rep,n_existing,Bxih);
[MAE_pref,RMSE_pref,~,~]=test1_final(w_pref,p,r_tst,N_rep,n_existing,Bxih);

[w_trn,p_trn]=alternative_g(BB_trn,AA_trn,n_existing);
%[MAE_g_i,RMSE_g_i,MAE_g,RMSE_g]=test1(w_trn',p_trn',r_tst,N_rep,n_existing,Bxih);
[MAE_g,RMSE_g,~,~]=test1_final(w_trn',p_trn',r_tst,N_rep,n_existing,Bxih);

%[MAE_mean_i,RMSE_mean_i,MAE_mean,RMSE_mean]=testmeanpred(r_trn,r_tst);
[MAE_mean,RMSE_mean]=testmeanpred_final(r_trn,r_tst);


