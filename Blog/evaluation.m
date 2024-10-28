function [cl_errorav,cl_max,cl_worst] = evaluation(option,ex,tst,w,p,alpha,N_ex,N_rep)
%existing data
A_ex=ex{2}; %Adjacency
x_ex=ex{1}; %existing data
x_tst=tst{1}; %test labels
N=length(x_tst); %test samples
for n=1:N_rep
switch option
    case 'LP'
         
       for j=1:N
       Ap(:,j)=link_gen(p,w,N_ex);
       end
       A_rel=[A_ex,Ap;Ap',zeros(N,N)];
       L_rel=diag(sum(A_rel,2))-A_rel;
       C=diag([ones(N_ex,1);zeros(N,1)]);
       s_k = [x_ex;zeros(N,1)];
       s_hat=inv(L_rel+alpha*C'*C)*alpha*C'*C*s_k;
       s_pred=s_hat(N_ex+1:N_ex+N);
       
    case 'NN'
        
       for j=1:N
       Ap(:,j)=link_gen(p,w,N_ex);
       end
       A_rel=[A_ex,Ap;Ap',zeros(N,N)];
       for i=1:N
       t=A_rel(N_ex+i,:);
       c1=length(find(x_ex(find(t))==1));
       c2=length(find(x_ex(find(t))==-1));
        if c1>=c2
           s_pred(i)=1;
        else
           s_pred(i)=-1;
        end
       end
     case 'SC'
        for j=1:N
        Ap(:,j)=link_gen(p,w,N_ex);
        end
       A_rel=[A_ex,Ap;Ap',zeros(N,N)];
       L_rel=diag(sum(A_rel,2))-A_rel;
       [U,V]=eig(L_rel);
       s_hat=U(:,2);
       s_pred=s_hat(N_ex+1:N_ex+N);
       end

correct=0;miscorrect=0;

for i=1:N
if s_pred(i)>=0
    s_pred(i)=1;
else
    s_pred(i)=-1;
end
if s_pred(i)==x_tst(i)
    correct=correct+1;    
else
    miscorrect=miscorrect+1;
end
end

cl_error(n)=correct/N;
end
cl_errorav=mean(cl_error);
cl_max=max(cl_error);
cl_worst=min(cl_error);

end

%
