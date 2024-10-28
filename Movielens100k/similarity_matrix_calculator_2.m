function [BB,AA,d] = similarity_matrix_calculator_2(A,n_ex,NN)
[U,I]=size(A);
for i=1:U
    for j=i+1:U
       B(i,j)=pearson(A(i,:)',A(j,:)');
       B(j,i)=B(i,j);
    end
end
BB=cell(size(A,1)-n_ex,1);AA=cell(size(A,1)-n_ex,1);d=[];

for u=1:size(A,1)-n_ex
    [BB{u},AA{u},d_u]=get_data(B,A(n_ex+u,:),A(1:n_ex,:),n_ex,NN,u);
end

d=[d;d_u];



% for i=1:I
%   [BB_t,d_t]=get_data(B,A(:,i),n_ex,NN);
%   BB=[BB;BB_t];d=[d;d_t];
% end
% AA=zeros(size(BB));
% AA(find(BB))=1;
% end
end