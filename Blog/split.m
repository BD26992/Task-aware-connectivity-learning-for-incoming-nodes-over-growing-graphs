function [trn,val,tst,ext] = split(d,A,ext_pct,trn_pct,val_pct)
%splitting the data into train, validation and test
%   input= dataset;
%   d = labels (graph signal); A= adjacency matrix
%   output = training set, validation set, testing set, A_ex and L_ex
%   everything stored in cells
N=size(A,1);trn=cell(1,2);val=cell(1,2);tst=cell(1,2);ext=cell(1,3);
n_ext=ceil(ext_pct*N);
n_trn=ceil(trn_pct*N);
n_val=ceil(val_pct*N);

jj=randperm(N);
ext_index=jj(1:n_ext);
A_e=A(ext_index,ext_index);
L_e=diag(sum(A_e,2))-A_e;
x_e=d(ext_index);

trn_index=jj(n_ext+1:n_ext+n_trn);
val_index=jj(n_ext+n_trn+1:n_ext+n_trn+n_val);
tst_index=jj(n_ext+n_trn+n_val+1:N);


trn{1}=d(trn_index);trn{2}=A(trn_index,ext_index);
val{1}=d(val_index);val{2}=A(val_index,ext_index);
tst{1}=d(tst_index);tst{2}=A(tst_index,ext_index);
ext{1}=x_e;ext{2}=A_e;ext{3}=L_e;
end


