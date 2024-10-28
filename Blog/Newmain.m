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
N_iter=500;N_rep=100;
mu_w=[1e-1,1e-2,1e-3,1e-4,1e-5,1e-6];
lambda_w=[1e-1,1e-2,1e-3,1e-4,1e-5,1e-6];
lambda_p=[1e-1,1e-2,1e-3,1e-4,1e-5,1e-6];



alpha=[1]; %weight given to cost for labeled examples in the problem.

N_rep=100; %number of samples drawn from w, p

N_ex=size(ext{2},1);

lambda_p=1e-5;lambda_w=1e-6;N_iter=500;mu_w=1;

[p,w]=train_blog_new(ext,trn,mu_w,lambda_p,lambda_w,N_iter);

% p=cell(6,6,6);w=cell(6,6,6);
% for i=1:length(lambda_p)
%     for j=1:length(lambda_w)
%         for k=1:length(mu_w)
%         [p{i,j,k},w{i,j,k}]=train_blog(ext,trn,mu_w(k),lambda_p(i),lambda_w(j),N_iter);
%         % e_trn(i,j) = evaluate_blog(p,w,trn,ext,N_rep);
%         sump{i,j,k}=sum(p{i,j,k});
%         [cacc{i,j,k},cbest{i,j,k},cworst{i,j,k}] = evaluation('SC',ext,tst,w{i,j,k},p{i,j,k},alpha,N_ex,N_rep);
%         end
%     end
% end

%Step 4. Evaliate attachment on for label prediction based on Moura et.al.
%frequency analysis paper

N_attach=[10,50,100,150,200];
[model_cc,true_cc]=compare_cc(w,p,ext,tst,N_rep,1);

  
%random
w_rand=ones(N_ex,1);p_rand=ones(N_ex,1)/N_ex;
[model_rand,true_rand]=compare_cc(w_rand,p_rand,ext,tst,N_rep,1);
% clerror_rand = label_prediction(ext,tst,w_rand,p_rand,alpha,N_ex,N_rep);
% 
% %preferential
w_pref=ones(N_ex,1);p_pref=diag(ones(1,N_ex)*ext{2})/sum(diag(ones(1,N_ex)*ext{2}));
[model_pref,true_pref]=compare_cc(w_pref,p_pref,ext,tst,N_rep,1);
% clerror_pref = label_prediction(ext,tst,w_pref,p_pref,alpha,N_ex,N_rep);
% 
% %data
A_trn=trn{2};p_g=(sum(A_trn)/size(A_trn,1))';w_g=ones(N_ex,1);
[model_g,true_g]=compare_cc(w_g,p_g,ext,tst,N_rep,1);
% clerror_g=label_prediction(ext,tst,w_g',p_g',alpha,N_ex,N_rep);

compare_cc(w,p,ext,tst,N_rep,N_attach)
%Structural deviation

N_attach=[10,50,100,150,200];
mdev_proposed=zeros(1,5);mdev_rand=zeros(1,5);mdev_pref=zeros(1,5);mdev_g=zeros(1,5);
for n=1:length(N_attach)
[dev_proposed(n,:),mdev_proposed(n)] = structural_dev(w{2,6,6},p{2,6,6},ext,N_rep,N_attach(n));
[dev_rand(n,:),mdev_rand(n)] = structural_dev(w_rand,p_rand,ext,N_rep,N_attach(n));
[dev_pref(n,:),mdev_pref(n)] = structural_dev(w_pref,p_pref,ext,N_rep,N_attach(n));
[dev_g(n,:),mdev_g(n)] = structural_dev(w_g',p_g',ext,N_rep,N_attach(n));
end


e_tst = evaluate_blog(p,w,tst,ext,N_rep);
e_tst_rnd = evaluate_blog(p_rand,w_rand,tst,ext,N_rep);
e_tst_pref = evaluate_blog(p_pref,w_pref,tst,ext,N_rep);
e_tst_g = evaluate_blog(p_g',w_g',tst,ext,N_rep);

