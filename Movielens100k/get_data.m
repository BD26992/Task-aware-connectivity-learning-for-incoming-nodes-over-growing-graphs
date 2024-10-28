function [BB,AA,data] = get_data(B,x,A,n_ex,NN,u)
%B has existing plus new users dimensionality, same for x
N=size(B,1);
items_rated=find(x);
blist=B(n_ex+u,1:n_ex);
if isempty(items_rated)
BB=[];
AA=[];
data=[];
else

for i=1:length(items_rated)
u1=find(A(:,items_rated(i)));%existing users who have rated the item also rated by training user
t=zeros(n_ex,1);
t(u1)=blist(u1);
%now sort t
[z,y]=sort(t,'descend');
t(y(NN+1:n_ex))=0;
BB(i,:)=t';
data(i)=x(i);
end
AA=zeros(size(BB));
AA(find(BB))=1;
end
end





% x_ex=x(1:n_ex);x_new=x(n_ex+1:length(x));
% nnz_ex=find(x_ex);nnz_new=find(x_new);
% %now remove all columns 
% 
% B_out=B(n_ex+1:N,1:n_ex);
% 
% [Z,Y]=sort(B_out,2,'descend');
% for i=1:N-n_ex
%     B_out(i,Y(i,NN+1:n_ex))=0;
% end
% 
% BB=B_out(nnz_new,:);
% data=x_new(nnz_new);
% end
