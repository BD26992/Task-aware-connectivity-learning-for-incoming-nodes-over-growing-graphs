function B_out = item_specific_graph(B,x,NN)
xnz=find(x);N=size(B,1);
B_out=zeros(N,N);
B_out(:,xnz)=B(:,xnz);
%normalize column sum

%apply nearest neighbors
[Z,Y]=sort(B_out,2,'descend');
for i=1:N
    B_out(i,Y(i,NN+1:N))=0;
end

%B_out_norm=B_out*diag(1./sum(B_out,1));
%however change the nans to zeros

end