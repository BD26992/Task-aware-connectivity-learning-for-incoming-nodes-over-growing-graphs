function [BB,AA,d] = similarity_matrix_calculator_3(A,n_ex,NN)
[U,I]=size(A);
for i=1:U
    for j=i+1:U
       B(i,j)=pearson(A(i,:)',A(j,:)');
       B(j,i)=B(i,j);
    end
end

BB=cell(I,1);AA=cell(I,1);d=[];
A_ex=A(1:n_ex,:);A_trn=A(n_ex+1:U,:);
for i=1:I
[BB{i},AA{i},d_i]=get_data_itemonly(B,A_trn(:,i),A_ex,n_ex,NN,i);
end
end



