function y = norm1(X)
[M,N]=size(X);
y=zeros(M,1);
for i=1:N
    y=y+sign(X(:,i));
end
end