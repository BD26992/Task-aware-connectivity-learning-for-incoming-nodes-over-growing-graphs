function [B,BI] = similarity_matrix_calculator(A,NN)
[U,I]=size(A);BI=cell(I,1);
for i=1:U
    for j=i+1:U
       B(i,j)=pearson(A(i,:)',A(j,:)');
       B(j,i)=B(i,j);
    end
end

for i=1:I
  BI{i}=item_specific_graph(B,A(:,i),NN);  
end
end
