function [batch_error,batch_normerror]= evaluate(p,w,cost,N_rep,data,A,N,x,h,K,A_xh)
[aplus,bplus,xplus]=unpack(data,N);
T=size(data,1);
sample_error=zeros(T,1);
switch cost
    case 'interpolation'
        for t=1:T%for each node
            rel_error=zeros(N_rep,1);
            for i=1:N_rep%averaging over random sampling
            b_r = zeros(N,1);
            while sum(b_r)==0
                b_r=(rand(N,1)<p);
            end
            a_rel=b_r.*w;
            A_plus=[A,zeros(N,1);a_rel',0];
            x_hat(i)=a_rel'*A_xh;
            %filter_op=filterop(A_plus,x,h,K);
            %x_hat(i)=filter_op(N+1);
            rel_error(i)=(x_hat(i)-xplus(t))^2;
            rel_normerror(i)=(x_hat(i)-xplus(t))^2/xplus(t)^2;
            end
        sample_error(t)=mean(rel_error);
        sample_normerror(t)=mean(rel_normerror);
        end
    case 'smoothness'
        for t=1:T%for each node
            rel_error=zeros(N_rep,1);
            for i=1:N_rep%averaging over random sampling
            b_r = zeros(N,1);
            while sum(b_r)==0
                b_r=(rand(N,1)<p);
            end
            a_rel=b_r.*w;
            A_relplus=[A,a_rel;a_rel',0];A_plus=[A,aplus(t,:)';aplus(t,:),0];
            L_relplus=diag(sum(A_relplus,2))-A_relplus; L_plus=diag(sum(A_plus,2))-A_plus;
            rel_error(i)=([x;xplus(t)]'*(L_relplus-L_plus)*[x;xplus(t)])^2;
            end
        sample_error(t)=mean(rel_error);
        end
end
batch_error=mean(sample_error);
%batch_normerror=mean(sample_normerror);
batch_normerror=0;
end