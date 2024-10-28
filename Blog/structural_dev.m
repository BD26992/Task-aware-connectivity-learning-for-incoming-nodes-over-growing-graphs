function [dev,mdev] = structural_dev(w,p,ext,N_rep,N_attach)
%function calculating the deviation in the clustering coefficient as a
%group of nodes (N_attach) attach the existing graph, based on attachment rules.
N=length(p);A=ext{2};
true=clustering_coeff(A);
for i=1:N_rep %outer repetitions
for j=1:N_attach
Ap(:,j)=link_gen(p,w,N);
end
A_rel=[A,Ap;Ap',zeros(N_attach,N_attach)];
A_rel(find(A_rel))=1;
cf(i)=clustering_coeff(A_rel);    
end
%boxplot of deviations
dev=abs(cf-true*ones(1,N_rep));
mdev=mean(dev);
end