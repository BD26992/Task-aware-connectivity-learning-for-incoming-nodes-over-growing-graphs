function [BB,AA,data]=get_data_itemonly(B,x,A_ex,n_ex,NN,i)
N=size(B,1);
users_who_rated=find(x);

for u=1:length(users_who_rated)
blist=B(n_ex+users_who_rated(u),1:n_ex);
u1=find(A_ex(:,i));%existing users who have rated the item
t=zeros(n_ex,1);
t(u1)=blist(u1);
%sort
[z,y]=sort(t,'descend');
t(y(NN+1:n_ex))=0;
BB(u,:)=t';
data(u)=x(users_who_rated(u));
end
AA=zeros(size(BB));
AA(find(BB))=1;
end
