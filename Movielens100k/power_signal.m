function [O] = power_signal(BI,I,r,K)
O=cell(I,1);
for i=1:I
    T=BI{i};
    C=T*r(:,i);A=[C];
    for j=1:K-1
        C=T*C;
        A=[C,A];
    end
O{i}=A;
end