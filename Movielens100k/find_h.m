function [h,Bxih] = find_h(R,B,BI,K,lambda)
[U,I]=size(R);
[X,Y]=find(R);%
d=R(find(R));
[A] = power_signal(BI,I,R,K);%cell array
S_Tau=[];
for i=1:length(d)
[x]=X(i);[y]=Y(i);
user=A{y};
row=user(x,:);
S_Tau=[S_Tau;row];
end

%find h_opt
h=pinv(S_Tau'*S_Tau+lambda*eye(K,K))*S_Tau'*d;
%
Bxih=zeros(U,I);
for i=1:I
 Bxih(:,i)=A{i}*h;
end
end