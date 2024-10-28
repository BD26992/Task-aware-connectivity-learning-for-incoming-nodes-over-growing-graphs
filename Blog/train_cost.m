function tot_cost = train_cost(p,w,ext,trn,mu_w)
x_trn=trn{1};
A=trn{2};
N=size(A,2);
x=ext{1};
T=size(A,1);
X=zeros(N,T);
for i=1:T
X(:,i)= (x-x_trn(i)*ones(N,1)).^2;
end
%evaluate cost
%term1
t1=trace(X'*diag(w.*w.*p.*(ones(N,1)-p))*X);
%term2
t2=trace(X'*(w.*p)*(w.*p)'*X);
%term3
c=diag(X'*A');
d=diag(X'*repmat(w.*p,1,T));
t3=-2*(c'*d);
%term4
t4=norm(c,2)^2;
ESSE_cost=(t1+t2+t3+t4);
reg_cost=mu_w*norm(repmat(w,1,T)-A',2)^2;
tot_cost=(ESSE_cost+reg_cost)/T;
end