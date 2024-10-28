function [CC] = clustering_coeff(A)
%avg clustering coefficient of graph
%   A: Adjacency matrix 
N=size(A,1);
Ng=cell(N,1);
for i=1:N
Ng{i}=find(A(i,:));%neighborhood of i-th node
end
for i=1:N
s=0;
H=Ng{i};
d=length(find(A(i,:)));
for j = 1: length(H)
      s=s+length(intersect(Ng{H(j)},H));
end
    if d>1
    c(i)=s/(d*(d-1));
    else
    c(i)=0;
    end
end
CC=mean(c);
end

