%main
clear all
% SUMMARY
% Step 1. load a graph dataset which contains the adjacency matrix and the
% graph signal (labels) at the very least
load blogdata


% Step 2. Extract the existing graph by removing nodes fom the loaded graph
% so that the existing graph has one connected component and a clustered
% structure*
%ext, trn and tst are the existing training and testing data
[ext,trn,tst]=good_dataset(A,labels);



%Step 3. Set the range of hyperparameters and train 
mu_w=[1];lambda_w=[1e-3];lambda_p=[1e-6];N_iter=1500;N_rep=100;

R=1;
for r =1:R

for i=1:length(lambda_p)
    for j=1:length(lambda_w)
        [p,w]=train_blog(ext,trn,mu_w,lambda_p(i),lambda_w(j),N_iter);
        e_trn(i,j) = evaluate_blog(p,w,trn,ext,N_rep);  
    end
end

%test for other three attachments, rand, pref and attachment only from trn
e_tst(r) = evaluate_blog(p,w,tst,ext,N_rep);

n_existing=length(ext{1});%same as N

%uniformly at random
w_rand=ones(n_existing,1);p_rand=ones(n_existing,1)/n_existing;
e_tst_rnd(r) = evaluate_blog(p_rand,w_rand,tst,ext,N_rep);

%preferential attachment
w_pref=ones(n_existing,1);p_pref=diag(ones(1,n_existing)*ext{2})/sum(diag(ones(1,n_existing)*ext{2}));
e_tst_pref(r) = evaluate_blog(p_pref,w_pref,tst,ext,N_rep);

%g attachment
A_trn=trn{2};
p_g=sum(A_trn)/size(A_trn,1);
w_g=p_g;
e_tst_g(r) = evaluate_blog(p_g',w_g',tst,ext,N_rep);

%deviation for other three attachments
N_attach=[10,50,100,150,200];
mdev_proposed=zeros(1,5);mdev_rand=zeros(1,5);mdev_pref=zeros(1,5);mdev_g=zeros(1,5);
for n=1:length(N_attach)
[dev_proposed(n,:),mdev_proposed(n)] = structural_dev(w,p,ext,N_rep,N_attach(n));
[dev_rand(n,:),mdev_rand(n)] = structural_dev(w_rand,p_rand,ext,N_rep,N_attach(n));
[dev_pref(n,:),mdev_pref(n)] = structural_dev(w_pref,p_pref,ext,N_rep,N_attach(n));
[dev_g(n,:),mdev_g(n)] = structural_dev(w_g',p_g',ext,N_rep,N_attach(n));
end

devf_proposed(r,:)=mdev_proposed;
devf_rand(r,:)=mdev_rand;
devf_pref(r,:)=mdev_pref;
devf_g(r,:)=mdev_g;
end
%boxplot([dev_proposed',dev_rand',dev_pref',dev_g'])