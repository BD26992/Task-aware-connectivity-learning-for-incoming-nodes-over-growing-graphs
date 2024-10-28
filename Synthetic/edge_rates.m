function [avg_precision,avg_recall,avg_ppcr] = edge_rates(p,tst,N_rep,N)
%sample from p and generate N_rep attachments, stored column-wise
for i=1:N_rep
S(:,i)=sample_from(p,N);
end
%a[i]=how many times out of N_rep edge is being recommended by p
%b[i]=how many times out of N_rep edge is not being recommended by p
a=zeros(N,1);b=zeros(N,1);
for i=1:N
    a(i)=nnz(S(i,:));
    b(i)=N_rep-a(i);
end
%unpack true edge connections, stored row-wise in aplus,bplus
[aplus,bplus,xplus]=unpack(tst,N);
t1=sum(bplus,2);t2=find(t1==0);bplus(t2,:)=[];B=bplus';
T=size(B,2);
%true_det: detection rate if edge exists, true_nondet:rejection rate if
%redge doesnt exist
% true_det=zeros(N,T);true_nondet=zeros(N,T);true_miss=zeros(N,T);
for i=1:N_rep
for j=1:T
[precision(i,j),recall(i,j),ppcr(i,j)]=precision_recall(B(:,j),S(:,i),N);
end
end
avg_precision=mean(mean(precision));
avg_recall=mean(mean(recall));
avg_ppcr=mean(mean(ppcr));
%main
% for i=1:N
%     for j=1:T
%     if B(i,j)==1;%in the j-th test sample, edge i is present
%        true_det(i,j)=a(i)/N_rep;
%        true_nondet(i,j)=nan;
%        true_miss(i,j)=b(i)/N_rep;
%        true_falsepos(i,j)=nan;
%     else
%        true_det(i,j)=nan;
%        true_nondet(i,j)=b(i)/N_rep;
%        true_falsepos(i,j)=a(i)/N_rep;
%        true_miss(i,j)=nan;
%     end
%     end
% end
% %to find avg detection and nond etectionr ate for each edge, average over
% %numbers taht are not NaN
% true_detection=zeros(N,1);false_detection=zeros(N,1);
% for i=1:N
%     temptrue=true_det(i,:);
%     true_detection(i)=mean(temptrue(find(temptrue>=0)));%taking mean over all elements excluding nan
%     
%     tempfalse=true_nondet(i,:);
%     true_negative_detection(i)=mean(tempfalse(find(tempfalse>=0)));
%     
%     temp3=true_miss(i,:);
%     miss(i)=mean(temp3(find(temp3>=0)));
%     
%     temp4=true_falsepos(i,:);
%     falsepos(i)=mean(temp4(find(temp4>=0)));
% end
end