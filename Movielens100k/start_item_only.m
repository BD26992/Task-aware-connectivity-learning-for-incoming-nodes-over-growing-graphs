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
% load Ratings_Matrix
% % %ratings=sparsify(ratings,0.5);
% % ratings=ratings';
% cc=10;
% ratings=clean(ratings,cc);
% ratings=mean_normalized_ratings(ratings);
% % %%%%%%
% % %%%%%%
% NN=35;%nearest neighbors
% n_users=size(ratings,1);
% n_existing=50;%value of N
% n_test=100;
% N=n_existing;
% % 
% n_train=n_users-n_existing-n_test;
% K=5;%filter_order
% N_iter=250;
% N_rep=100;
% I=size(ratings,2);%number of items
% % RRep=1;
% % %select train and test users
% %[r_existing,r_trn,r_tst]=split_users(ratings,n_existing,n_train);
% [r_existing,r_trn,r_tst]=select_existing_users(ratings,n_existing,n_train);
% R=normalize_ratings([r_existing;r_trn]);
% r_existing=R(1:n_existing,:);
% r_trn=R(n_existing+1:n_existing+n_train,:);
% r_tst=normalize_ratings(r_tst);
%
load Itemonlysaveddata
% %existing graph and item-specific graphs
%[B,BI]=similarity_matrix_calculator(r_existing,NN);
%lambda_h=1;
%[h,Bxih]=find_h(r_existing,B,BI,K,lambda_h);
% %[Bxih] = stack_powers(BI,h,I,r_existing,K);
% %training data generation
%[BB_trn,AA_trn,d_trn] = similarity_matrix_calculator_3([r_existing;r_trn],n_existing,NN);
% %[BB_tst,AA_tst,d_tst] = similarity_matrix_calculator_2([r_existing;r_tst],n_existing,NN);
% %training tim

%load all_items_pre_data
%load('Itemonlysaveddata.mat')

it=877;N=100;
train = r_trn(:,it);
testd = r_tst(:,it);

mu_p=[1e-5,1e-4,1e-3,1e-2,1e-1,1,10];
mu_w=[1e-5,1e-4,1e-3,1e-2,1e-1,1,10];
lambda_p=[1e-4];
lambda_w=[1e-4];
N_iter=3000;
op_test=cell(7,7);
for i=1:7
for j=1:7
[w,p] = train_coldstart_itemonly(N,N_iter,train,Bxih(:,it),BB_trn{it},AA_trn{it},mu_p(i),mu_w(j),lambda_p,lambda_w);
%initialize w,p
[MAE_tr(i,j),RMSE_tr(i,j),~] = test_itemonly(w,p,train,N_rep,N,Bxih(:,it));
[MAE(i,j),RMSE(i,j),am{i,j},ar{i,j}] = test_itemonly(w,p,testd,N_rep,N,Bxih(:,it));
end
end
w_rand=ones(n_existing,1);p_rand=ones(n_existing,1)/n_existing;
for i=1:1000
[MAE_random_list(i),RMSE_random_list(i),~,~]=test_itemonly(w_rand,p_rand,testd,N_rep,N,Bxih(:,it));
end
% 
for i=1:1000
w_pref=ones(n_existing,1);p_pref=diag(ones(1,n_existing)*BI{it})/sum(diag(ones(1,n_existing)*BI{it}));
[MAE_pref_list(i),RMSE_pref_list(i),~,~]=test_itemonly(w_pref,p_pref,testd,N_rep,N,Bxih(:,it));
end
%
w_trn=sum(BB_trn{it},1)/size(BB_trn{it},1);
p_trn=sum(AA_trn{it},1)/size(AA_trn{it},1);
[MAE_g_only,RMSE_g_only,~,~]=test_itemonly(w_trn',p_trn',testd,N_rep,N,Bxih(:,it));

[MAE_mu,RMSE_mu] = testmeanpred_final(train,testd);


% figure
% boxplot([am{4,3}',ar{3,3}'],'Labels',{'MAE','RMSE'})
% title('Error boxplots for Item 48')
% ax=gca;
% ax.FontSize=16