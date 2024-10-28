function [cfm,ctrue] = compare_cc(w,p,ext,tst,N_rep,N_attach)
%function calculating the deviation in the clustering coefficient as a
%group of nodes (N_attach) attach the existing graph, based on attachment rules.
N=length(p);A=ext{2};tst_attach=tst{2};
true=clustering_coeff(A);
true=double(true);
Ntst=size(tst_attach,1);

for m=1:Ntst

for i=1:5 %outer repetitions
for j=1:N_attach
Ap(:,j)=link_gen(p,w,N);
end
A_rel=[A,Ap;Ap',zeros(N_attach,N_attach)];
A_rel(find(A_rel))=1;
cf(i)=clustering_coeff(A_rel);    
end 
cfm(m)=mean(cf);
Z=tst_attach(m,:)';
A_true=[A,Z;Z',zeros(N_attach,N_attach)];
ctrue(m)=clustering_coeff(A_true);
end
end