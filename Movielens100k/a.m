function [Bxih] = stack_powers(BI,h,N,I,x_i,K)
for i=1:I
    T=BI{i};
    C=x;A=[C];
    for i=1:K
        C=T*C;
        A=[C,A];
    end
    Bxih(:,i)=A*h;
end

