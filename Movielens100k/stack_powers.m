function [Bxih] = stack_powers(BI,h,I,r,K)
for i=1:I
    T=BI{i};
    C=r(:,i);A=[C];
    for j=1:K
        C=T*C;
        A=[C,A];
    end
    Bxih(:,i)=A*h;
end

