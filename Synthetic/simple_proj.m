function [o]=simple_proj(i,lower,upper)%projects every elemtn of i as per lower and upper
N=size(i,1);
o=(lower*ones(N,1)>=i)*lower+((lower*ones(N,1)<i) & (i<upper*ones(N,1))).*i+(i>=upper*ones(N,1))*upper;
end