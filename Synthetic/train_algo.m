
function [p_tr,w_tr,ret,A_xh]= train_algo(cost,A,x,trn_data,val_data,N,N_parallel,N_iter,N_rep,mu_p,mu_w,lambda_p,lambda_w,A_xh)
[trn_aplus,trn_bplus,trn_xplus]=unpack(trn_data,N);

p=rand(N,1);w=rand(N,1);%initialize
T_trn=size(trn_data,1);
switch cost
    case 'interpolation'
        
        for n=1:N_iter
         a=(w.*p)'*(A_xh);
         b=w.*A_xh;
        %gradient p
        first_term=sum(a*ones(T_trn,1)-trn_xplus)*b;
        second_term=T_trn*(A_xh.*A_xh.*w.*w.*(ones(N,1)-2*p));
        third_term=mu_p*sum(sign(repmat(p,1,T_trn)-trn_bplus'),2);
        %third_term=2*mu_p*sum((repmat(p,1,T_trn)-trn_bplus'),2);
        grad_p=first_term+second_term+third_term;
        %update
        p_hat=p-lambda_p*grad_p;
        %project
        p=simple_proj(p_hat,0,1);
        %gradient w
%          c=p.*A_xh;
%          first_term_w=sum(a*ones(T_trn,1)-trn_xplus)*c;
%          second_term_w=2*T_trn*(A_xh.*A_xh.*w.*p.*(ones(N,1)-p));
%          third_term_w=mu_w*sum(sign(repmat(w,1,T_trn)-trn_aplus'),2);
%          %third_term_w=2*mu_w*sum((repmat(w,1,T_trn)-trn_aplus'),2);
%          grad_w=first_term_w+second_term_w+third_term_w;
% %         %update
%          w_hat=w-lambda_w*grad_w;
% %         %project w
%          w=simple_proj(w_hat,0,1);
%         weight_norm(n)=norm(w,2);prob_norm(n)=norm(p,2);
          if mod(n,100)==0
              true_signal=trn_data(:,201);
          trn_error(floor(n/100+0.001))=norm((w.*p)'*repmat(A_xh,1,T_trn)-true_signal')^2+((A_xh.*A_xh)'*(w.*w.*p.*(ones(N,1)-p)))*T_trn+mu_p*norm(repmat(p,1,T_trn)-trn_bplus')^2+mu_w*norm(repmat(w,1,T_trn)-trn_aplus')^2;
          end
        end
        
    case 'smoothness'
    for n=1:N_iter 
      e=repmat(x.*x,1,T_trn)-2*repmat(x,1,T_trn)*diag(trn_xplus)+repmat(ones(N,1),1,T_trn)*diag(trn_xplus.*trn_xplus);%x_hats stacked column wise
      first_term_p=w.*w.*(ones(N,1)-2*p).*sum(e.*e,2);%first term of gradien for p
      g=repmat((w.*p)',T_trn,1)-trn_aplus;
      h=g*e;
      second_term_p=2*(repmat(w,1,T_trn).*e)*diag(h);%second term of gradient for p
      %third_term_p=2*mu_p*sum(repmat(w,1,T_trn)-trn_bplus',2);
      third_term_p=2*mu_p*sum(sign(repmat(w,1,T_trn)-trn_bplus'),2);
      
      %gradient p;
      grad_p=first_term_p+second_term_p+third_term_p;
      p_hat=p-lambda_p*grad_p;
      %project p
      p=simple_proj(p_hat,0,1);
      %gradient w
     first_term_w=2*w.*p.*(ones(N,1)-p).*sum(e.*e,2);
     second_term_w=2*(repmat(p,1,T_trn).*e)*diag(h);
     %third_term_w=2*mu_w*sum(repmat(w,1,T_trn)-trn_aplus',2);
     third_term_w=2*mu_w*sum(sign(repmat(w,1,T_trn)-trn_aplus'),2);
     grad_w=first_term_w+second_term_w+third_term_w;
     w_hat=w-lambda_w*grad_w;
%     %project w
     w=simple_proj(w_hat,0,1);
%     weight_norm(n)=norm(w,2);prob_norm(n)=norm(p,2);
    if mod(n,100)==0
    trn_error(floor(n/100+0.001))= trace(e'*diag(w.*w.*p.*(ones(N,1)-p))*e)+norm(e'*(w.*p))^2-2*(e'*(w.*p))'*(diag(e'*trn_aplus'))+norm(diag(e'*trn_aplus'))^2 + mu_w*norm(repmat(w,1,T_trn)-trn_aplus')^2;
    end
    end
end
p_tr=p;w_tr=w;
%call cost function
% if (size(val_data,1)>0)
% [batch_error]= evaluate(p_tr,w_tr,cost,N_rep,val_data,A,N,x);
% else
%  batch_error=NaN;
% end
ret=trn_error(end)/n;
end