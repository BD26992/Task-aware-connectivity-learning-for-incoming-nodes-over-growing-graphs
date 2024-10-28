function [output] = evaluate_perturbation(p,w,A,N_rep,N)
A_expected=[A,w.*p;(w.*p)',0];
%find fixed eigenvalues to calculate the deviation realtive to
[~,Lambda]=eig(full(A_expected));
eig_fixed=diag(Lambda);
N_rep=10,000;
dev=zeros(N+1,N_rep);%dev_ij is the deviation from the ith eigenvalue at the jth realization
for i=1:N_rep
        b_r = sample_from(p,N);
        a_rel=b_r.*w;
        A_plus=[A,a_rel;a_rel',0];
        [~,lambda_plus]=eig(full(A_plus));
        dev(:,i)=abs(diag(lambda_plus)-eig_fixed);
end
output=sum(dev.^2,2)/N_rep;%std. deviation of the absolute deviation for each eigenvalue.
end