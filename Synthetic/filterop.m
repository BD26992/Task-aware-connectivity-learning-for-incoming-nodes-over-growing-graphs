function o = filterop(A,x,h,K)
T=[x;0];
S=[];
for i=1:K
T=A*T;
S=[S,T];
end
o = S*h(2:K+1);
end