clear all
%load synthetic_er
tic
load Barabasi_Albert_Data
cost='smoothness';
%split into (train+valid),test
trn_pct=0.6;val_pct=0.2;
for dj=1:1
[trn,tst]=split_trn_tst(d_aplus,d_bplus,d_xplus,(trn_pct+val_pct),R);
%'interpolation' or 'smoothness' are valid choices.
%Training
%A=G.A;
A_xh=A*x;h=1;K=1;
N_parallel=1;N_iter=1500;N_rep=100;N_rep_pr=1000;%training params
K_fold=1;%cross validation
base=R*(trn_pct+val_pct)/K_fold;%size of each fold
perturbation_statistics=cell(6,6);perturbation_statistics_random=cell(6,6);perturbation_statistics_pref=cell(6,6);
lambda_p=[0.00001];
lambda_w=[0.00001];
mu_p=[1];
mu_w=[0.1];
for ov=1:100
for ii=1:length(mu_p)
for jj=1:length(mu_w)
for k=1:K_fold
% %val_index=[base*(k-1)+1:k*base];trn_index=setdiff([1:(trn_pct+val_pct)*R],val_index);%index of train and val for current fold
% %trn_data=trn(trn_index,:);val_data=trn(val_index,:);
trn_data=trn;val_data=[];
[p_tr(:,k),w_tr(:,k),val_error(:,k)]= train_algo(cost,A,x,trn_data,val_data,N,N_parallel,N_iter,N_rep,mu_p(ii),mu_w(jj),lambda_p,lambda_w,A_xh);%training, returns trained values and validation error
% % 
% % %%
% % %[true_detection(:,k),false_detection(:,k),true_miss(:,k),falsepos(:,k)]=edge_rates(p_tr(:,k),trn,N_rep,N);
% % [precision(k),recall(k),ppcr(k)]=edge_rates(p_tr(:,k),tst,N_rep_pr,N);
% 
% % 
% % %ttt=true_detection(:,k);fff=false_detection(:,k);mmm=true_miss(:,k);nnn=falsepos(:,k);
% % 
% % 
% % %ttt(isnan(ttt))=0;fff(isnan(fff))=0;mmm(isnan(mmm))=0;nnn(isnan(nnn))=0;
% % 
% % 
% % %true_detection(:,k)=ttt;false_detection(:,k)=fff;true_miss(:,k)=mmm;falsepos(:,k)=nnn;
% % 
% % 
% % %avg_detection(k)=mean(true_detection(:,k));
% % %avg_falsedet(k)=mean(false_detection(:,k));
% % %avg_miss(k)=mean(true_miss(:,k));
% % %avg_falsepos(k)=mean(falsepos(:,k));
% % %%
% 
% % 
end
perturbation_statistics{ii,jj}=evaluate_perturbation(p_tr,ones(N,1),A,N_rep,N);
% % mean_perturbation_variance(ii,jj)=mean(perturbation_variance);
% % %mean_true_detection(ii,jj)=mean(true_detection);
% % %mean_false_detection(ii,jj)=mean(false_detection);
% % %detection(ii,jj)=mean(avg_detection);
% % %falsedetection(ii,jj)=mean(avg_falsedet);
% % %miss(ii,jj)=mean(avg_miss);
% % %falsepositive(ii,jj)=mean(avg_falsepos);
% % %cross_valerror(ii,jj,dj  )=mean(val_error);
% % %sump(ii,jj,dj)=mean(sum(p_tr,1));
% % totalprecision(ii,jj)=mean(precision);
% % totalrecall(ii,jj)=mean(recall);
% % totalppcr(ii,jj)=mean(ppcr);
cool(ov)=mean(perturbation_statistics{ii,jj});
end
end
end
% p_rand=ones(N,1)/N;w_rand=ones(N,1);
% %[precision_rand,recall_rand,ppcr_rand]=edge_rates(p_rand,trn,N_rep_pr,N);
% perturbation_statistics_random=evaluate_perturbation(p_rand,w_rand,A,N_rep,N);
% 
% p_pref=sum(A,2)/sum(sum(A,2));w_perf=ones(N,1);
% %[precision_pref,recall_pref,ppcr_pref]=edge_rates(p_pref,trn,N_rep_pr,N);
% perturbation_statistics_pref=evaluate_perturbation(p_rand,w_rand,A,N_rep,N);
% lambda_p=0.00001;lambda_w=0.00001;mu_p=[32];mu_w=[1];
% T_rep=50;%T_rep=total number of repititions.
% for r=1:T_rep
% 
% %[p_tr(:,r),w_tr(:,r),trn_error(:,r)]= train_algo(cost,A,x,trn,[],N,N_parallel,N_iter,N_rep,mu_p,mu_w,lambda_p,lambda_w,A_xh);%training, returns trained values and validation error
% [p_tr(:,r),w_tr(:,r),trn_error(:,r)]= train_algo(cost,A,x,trn,[],N,N_parallel,N_iter,N_rep,mu_p,mu_w,lambda_p,lambda_w,A_xh);%training, returns trained values and validation error
% [p_tr(:,r),w_tr(:,r),trn_error_sub(:,r)]= train_algo(cost,A,x,trn,[],N,N_parallel,N_iter,N_rep,1,mu_w,lambda_p,lambda_w,A_xh);%training, returns trained values and validation error

%train_error(r)=evaluate(p_tr(:,r),w_tr(:,r),cost,N_rep,trn,A,N,x);
% 
% %test
%p_random=ones(N,1)/N;
%p_pref=sum(G.A,2)/sum(sum(G.A,2));
%
%[true_detection,false_detection]=edge_rates(p_tr,tst,N_rep,N);
%mean_true_detection(r)=true_detection'*p_tr;
%mean_false_detection(r)=false_detection'*(ones(N,1)-p_tr);

%[perturbation_variance]=evaluate_perturbation(p_tr,w_tr,A,N_rep,N);
%mean_perturbation_variance(r)=mean(perturbation_variance);
% test_error_proposed(r)=evaluate(p_tr,w_tr,cost,N_rep,tst,A,N,x);
% %test_error_preferential(rep,tst,G,N,x);
% %test_error_rand(r)=evaluate(p_true,w_true,cost,N_rep,tst,G,N,x);
% %test_error_hybrid(r)=evaluate(p_tr,w_true,cost,N_rep,tst,G,N,x);
% N_avg(r) = n_links_generated(p_tr,w_tr,N_rep,N);

end

%error_proposed(dj)=mean(test_error_proposed);
%error_preferentia(dj)=mean(test_error_preferential);
%error_random(dj)=mean(test_error_rand);
%N_avg_o(dj)=mean(N_avg);
% totaltime=toc;
% %end
% 
% for i=1:6
%     for j=1:6
%     this(i,j)=mean(perturbation_statistics{i,j});
%     end
% end





% xxx = 10.^[-5,-4,-3,-2,-1,0];
% yyy = 10.^[-5,-4,-3,-2,-1,0]; 
% 
% imagesc(xxx,yyy,ans);
% set(gca,'XScale','log');set(gca,'YScale','log');xlabel('mu_w');ylabel('mu_p');title('Color map for validation error');
% ax=gca;ax.XAxis.FontSize = 15;ax.YAxis.FontSize = 15;ax.Title.FontSize=15;colorbar;
% 
% figure
% 
% imagesc(xxx,yyy,sump);
% set(gca,'XScale','log');set(gca,'YScale','log');xlabel('mu_w');ylabel('mu_p');title('Sum of probabilities across all nodes');
% ax=gca;ax.XAxis.FontSize = 15;ax.YAxis.FontSize = 15;ax.Title.FontSize=15;colorbar;
%plots
% stem(p_tr);hold on;stem(w_tr);
% xlabel('Node index');ylabel('Probability and Weight for each node');title('Probability and Weight for ER graph for interpolation');
% ax=gca;ax.XAxis.FontSize = 15;ax.YAxis.FontSize = 15;ax.Title.FontSize=15;legend('probability','weight');ax.Legend.FontSize=12;