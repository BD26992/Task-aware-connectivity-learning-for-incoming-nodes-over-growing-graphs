function [a,b,x]=unpack(data,N)
a=data(:,1:N);
b=data(:,N+1:2*N);
x=data(:,2*N+1);
end