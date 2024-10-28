%SBM
N=400;k=4;
params.p=0.8;params.q=0.05;
G = gsp_stochastic_block_graph(N ,k,params);
%generate dataset
cluster_labels=[1;2;3;4];M=20;
labels=kron(cluster_labels,ones(100,1));
for i=1:N

end






generate dataset
run clustering