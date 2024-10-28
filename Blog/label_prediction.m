function cl_error = label_prediction(ex,tst,w,p,alpha,N_ex,N_rep)
A_ex=ex{2};
x_ex=ex{1};
x_tst=tst{1};
N=length(x_tst);

%1. select N test samples at random


for n=1:N_rep
%2. sample from w,p
for j=1:N
Ap(:,j)=link_gen(p,w,N_ex);
end

%3. realization matrix

A_rel=[A_ex,Ap;Ap',zeros(N,N)];

%%%NOTE!!
A_rel=A_rel;

L_rel=diag(sum(A_rel,2))-A_rel;

[U,V]=eig(L_rel);
s_hat=U(:,2);
s_pred=s_hat(N_ex+1:N_ex+N);


%C=diag([ones(N_ex,1);zeros(N,1)]);

%s_k = [x_ex;zeros(N,1)];


%s_hat=inv(L_rel+alpha*C'*C)*alpha*C'*C*s_k;

%s_pred=s_hat(N_ex+1:N_ex+N);

% classification accuracy

% correct=0;miscorrect=0;
% for i=1:N
% a=length(find(x_ex(find(A_rel(N_ex+i,1:N_ex)))==1));
% b=length(find(x_ex(find(A_rel(N_ex+i,1:N_ex)))==-1));
% if a>b
%     s_hat(i,1)=1;
% else
%     s_hat(i,1)=-1;
% end
% if s_hat(i)==x_tst(i)
%     correct=correct+1;    
% else
%     miscorrect=miscorrect+1;
% end
% end

correct=0;miscorrect=0;

for i=1:N
if s_hat(i)>=0
    s_hat(i)=1;
else
    s_hat(i)=-1;
end
if s_hat(i)==x_tst(i)
    correct=correct+1;    
else
    miscorrect=miscorrect+1;
end
end

cl_error(n)=correct/N;
end
cl_error=mean(cl_error);
end



