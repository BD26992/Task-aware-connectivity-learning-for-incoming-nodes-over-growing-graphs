% clear all
%N=100;p_e=0.2;%N=|V|,p_e=edge prob.
%G = gsp_erdos_renyi(N,p_e);%define graph

% load BA
% L=A-diag(sum(A,2));N=100;
% K_bl=30;%band limited parameter
% [U,V]=eig(L);x=U(:,1:K_bl)*randn(K_bl,1);
% x=x-mean(x)*ones(N,1);%zero mean normalization
% p_true=sum(A,2)/sum(sum(A,2));
% %p_true=(1/N)*ones(N,1);%true p
% w_true=ones(N,1);%true w
% 
% %function to generate dataset
% R=1000;%size of dataset
% d_aplus=zeros(R,N);d_bplus=zeros(R,N);d_xplus=zeros(R,1);%placeholder
% for i=1:R
%     b_plus = zeros(N,1);
%     while sum(b_plus)==0
%         b_plus=(rand(N,1)<p_true);%sampling from p_true
%     end
%     a_plus=b_plus.*w_true;%a_+
%     A_plus=[A,a_plus;a_plus',0];%A_+
%     filter_op=A_plus*[x;0];%using very basic filter
%     x_plus=filter_op(N+1);
%     d_aplus(i,:)=a_plus';d_bplus(i,:)=b_plus';d_xplus(i)=x_plus;%store objects row-wise
% end
clear all
load Barabasi_Albert_Data;
cost='smoothness';
% %split into (train+valid),test
for ov =1:10
trn_pct=0.8;
[trn,tst]=split_trn_tst(d_aplus,d_bplus,d_xplus,trn_pct,R);
% 
% %'interpolation' or 'smoothness' are valid choices.
% 
% %Training
%A=G.A;
A_xh=A*x;h=1;K=1;
N_parallel=1;N_iter=1000;N_rep=100;%training params
K_fold=1;%cross validation
base=R*trn_pct/K_fold;%size of each fold
mu_p=[1e-4,1e-3,1e-2,1e-1];
mu_w=[1e-4,1e-3,1e-2,1e-1,1,10];
lambda_p=1e-5;
lambda_w=1e-5;
% % for ii=1:length(mu_p)
% % for jj=1:length(mu_w)
% % for k=1:K_fold
p_rand=ones(N,1)/N;w_rand=ones(N,1);
p_pref=sum(A,2)/sum(sum(A,2));w_pref=ones(N,1);
p_tr=cell(1,1);w_tr=cell(1,1);
for ii=1:length(mu_p)
  for jj=1:length(mu_w)
    for k=1:1
    val_index=[base*(k-1)+1:k*base];trn_index=setdiff([1:trn_pct*R],val_index);%index of train and val for current fold
    %trn_data=trn(trn_index,:);val_data=trn(val_index,:);
    trn_data=trn;
    [p_tr{ii,jj},w_tr{ii,jj},val_error(ii,jj),A_xh]= train_algo(cost,A,x,trn_data,[],N,N_parallel,N_iter,N_rep,mu_p(ii),mu_w(jj),lambda_p,lambda_w,A_xh);%training, returns trained values and validation error
    [test_prop(ii,jj),test_norm(ii,jj)]= evaluate(p_tr{ii,jj},w_tr{ii,jj},cost,N_rep,trn,A,N,x,h,K,A_xh);
    %[test_pref(ii,jj)]= evaluate(p_pref,w_pref,cost,N_rep,tst,A,N,x,h,K);
    %[test_rand(ii,jj)]= evaluate(p_rand,w_rand,cost,N_rep,tst,A,N,x,h,K);
    end
  end  
end
[trn_error(ov),I]=min2d(test_norm);
%proposed(ov)=min(min(test_prop));
[proposed(ov),proposed_norm(ov)]= evaluate(p_tr{I(1),I(2)},w_tr{I(1),I(2)},cost,N_rep,tst,A,N,x,h,K,A_xh);
%pref(ov)=mean(test_pref(:));
%rand(ov)=mean(test_rand(:));
end
% % %call training algorithm with unpaacking
% % end
% % cross_valerror(ii,jj)=mean(val_error);
% % end
% % end
% T_rep=1;%T_rep=total number of repititions.
% for r=1:T_rep
% [p_tr,w_tr,val_error]= train_algo(cost,G,x,trn,[],N,N_parallel,N_iter,N_rep,mu_p,mu_w,lambda_p,lambda_w,A_xh);%training, returns trained values and validation error
% train_error(r)=evaluate(p_tr,w_tr,cost,N_rep,trn,G,N,x);
% 
% %test
% %[batch_error]= evaluate(p_train,w_train,cost,N_rep,tst,G,N,x);
% 
% batch_error(r)= evaluate(p_tr,w_tr,cost,N_rep,tst,G,N,x);
% batch_error_rand(r)= evaluate(p_true,w_true,cost,N_rep,tst,G,N,x);
% end
%%%%for plot
% figure
% xlim([100 2500])
% semilogy(100*[ones(2401,1)],'b');hold on
% semilogy(200*[ones(2401,1)],'r');hold on
% semilogy([100:100:5000],normal(1:49,:)/800,'b');hold on
% semilogy([100:100:5000],abnormal(1:49,:)/800,'r')
% ylim([0 10])
% xlim([100 2500])
% legend('not marginally convex','marginally convex')
% ax=gca;set(ax,'FontSize',22);xlabel('Iterations');ylabel('Training Cost')
% xticks([100 1500 2500])
% grid on