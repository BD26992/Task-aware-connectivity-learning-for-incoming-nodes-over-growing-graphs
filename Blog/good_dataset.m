function [ex,train,test] = good_dataset(A,x)
%the objective of this function is two-fold
%   1. extracts a graph with only one connected component after removing
%   nodes
%   2. use removed nodes to constitute train and test set
%   3. output in cell format: 3.1 the existing data - A, L, x
%                             3.2 the train data - x_trn, A_trn 
%                             3.3 the test data - x_tst, A_tst

%extracting the removed node indices
d=sum(A,2);
N=length(d);
[a,b]=sort(d,'ascend');%sort the nodes in assending order of degree
%array where removed nodes will be stored
start=b(1);
removed=[start];
N_r=600;
for k=2:N_r
At=A;
At([removed,b(k)],:)=[];
At(:,[removed,b(k)])=[];
G=graph(At);
c=conncomp(G);
if length(unique(c))==1
    removed=[removed,b(k)];%start is a candidate
else
    removed=removed;%start not a candidate
end
end

%existing data set
existing = cell(3,1);
all=[1:N];
existing=setdiff(all,removed);
A_ex=A(existing,existing);
L_ex=diag(sum(A_ex,2))-A_ex;
x_ex=x(existing,1);

%assign
ex{2}=A_ex;ex{3}=L_ex;ex{1}=x_ex;

%now split the removed into train and test
train=cell(1,2);test=cell(1,2);
Nr=length(removed);
idx=randperm(Nr);
trn_idx=removed(idx(1:400));
tst_idx=removed(idx(401:N_r));
x_trn=x(trn_idx,1);
x_tst=x(tst_idx,1);
A_trn=A(trn_idx,existing);
A_tst=A(tst_idx,existing);

%assign
train{1}=x_trn;train{2}=A_trn;
test{1}=x_tst;test{2}=A_tst;
end