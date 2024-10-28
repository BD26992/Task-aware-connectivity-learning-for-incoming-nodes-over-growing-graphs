function [w,p] = train_coldstart_itemonly(N,N_iter,training_ratings,Bxih,BB,AA,mu_p,mu_w,lambda_p,lambda_w)
%initialize w,p
w=randn(N,1);p=randn(N,1);
grad_p=zeros(N,1);grad_w=zeros(N,1);
[T,~]=size(BB);
[U,I]=size(training_ratings);
NNN=length(find(training_ratings));
for n=1:N_iter
for i=1:length(training_ratings)
   t=training_ratings(i,:);
   if isempty(find(t))
       grad_p=grad_p;
       n_rated(i)=0;
   else
   items_rated=find(t);
   n_rated(i)=length(items_rated);%items rated by this user
   ratings_vector=t(items_rated);%ratings of those items
   Bxih_s=Bxih;% columns of bxih as per items rated by this user
   P1=repmat(w,1,n_rated(i)).*Bxih_s;
   P2=((w.*p)'*Bxih_s-ratings_vector)';
   P3=sum(Bxih_s.*Bxih_s,2).*w.*w.*(ones(N,1)-2*p);
   user_gradient_p=P1*P2+P3;
   grad_p=grad_p+user_gradient_p;
   end
end
grad_p=grad_p+2*mu_p*norm1(repmat(p,1,NNN)-AA');
grad_p=grad_p/sum(n_rated);
p_hat=p-lambda_p*grad_p;
p=simple_proj(p_hat,0.01,1);%project
for i=1:length(training_ratings)
   t=training_ratings(i,:);
   if isempty(find(t))
       grad_w=grad_w;
       n_rated(i)=0;
   else
   items_rated=find(t);
   n_rated(i)=length(items_rated);%items rated by this user
   ratings_vector=t(items_rated);%ratings of those items
   Bxih_s=Bxih(:,items_rated);% columns of bxih as per items rated by this user
   W1=repmat(p,1,n_rated(i)).*Bxih_s;
   W2=((w.*p)'*Bxih_s-ratings_vector)';
   W3=2*sum(Bxih_s.*Bxih_s,2).*w.*p.*(ones(N,1)-p);
   user_gradient_w=W1*W2+W3;
   grad_w=grad_w+user_gradient_w;
   end
end
grad_w=grad_w+2*mu_w*sum(repmat(w,1,NNN)-BB',2);
grad_w=grad_w/sum(n_rated);
w_hat=w-lambda_w*grad_w;
w=simple_proj(w_hat,0,1);%project
[trn_error(n),trn_mse(n)]=loss_function_itemonly(w,p,N,training_ratings,Bxih,BB,AA,mu_p,mu_w);
if mod(n,100)==0
    trn_error(n)
    trn_mse(n)
end
parts(n)=norm(p);
partsw(n)=norm(w);
end
g=1;