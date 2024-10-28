function  error = evaluate_blog(p,w,data,ext,N_rep) 
A=ext{2};x=ext{1};
xplus=data{1};aplus=data{2};N=size(aplus,2);
T=size(xplus,1);
sample_error=zeros(T,1);
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
error=mean(sample_error);
end