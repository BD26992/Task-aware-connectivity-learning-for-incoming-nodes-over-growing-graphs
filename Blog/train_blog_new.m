function [p,w] = train_blog_new(ext,trn,mu_w,lambda_p,lambda_w,N_iter)
%training over smoothness cost
%   ext: cell with existing A, L and signal(labels)
%   trn: cell with trn labels, conenctivity
%   N_iter,mu_w,lambda_P,lambda_w: hyperparameters
trn_xplus=trn{1};
T_trn=length(trn_xplus);
x=ext{1};N=length(x);trn_aplus=trn{2};
p=rand(N,1);
w=ones(N,1);
N_iter=500;mu_p=5;
for n=1:N_iter 
      e=repmat(x.*x,1,T_trn)-2*repmat(x,1,T_trn)*diag(trn_xplus)+repmat(ones(N,1),1,T_trn)*diag(trn_xplus.*trn_xplus);%x_hats stacked column wise
      first_term_p=w.*w.*(ones(N,1)-2*p).*sum(e.*e,2);%first term of gradien for p
      
      second_term_p=2*(w.*p)'*sum(e,2)*(w.*x);
      
      third_term_p=-2*(repmat(w,1,T_trn).*e)*diag(trn_aplus*e);
      
      
      grad_p=(first_term_p+second_term_p+third_term_p)/T_trn+2*mu_p*sum(repmat(p,1,T_trn)-trn_aplus',2);
      
      p_hat=p-(lambda_p)*grad_p;
     %project p
      p=simple_proj(p_hat,0,1);
      %gradient w
%     first_term_w=2*w.*p.*(ones(N,1)-p).*sum(e.*e,2);
%     second_term_w=2*(repmat(p,1,T_trn).*e)*diag(h);
%     third_term_w=2*mu_w*sum(repmat(w,1,T_trn)-trn_aplus',2);
%     grad_w=(first_term_w+second_term_w)/T_trn+third_term_w;
%     w_hat=w-lambda_w*grad_w;
%     %project w
%     w=simple_proj(w_hat,0,1);
% %     
%     weight_norm(n)=norm(w,2);prob_norm(n)=norm(p,2);
    trn_error(n)=train_cost(p,w,ext,trn,mu_w);
end
end