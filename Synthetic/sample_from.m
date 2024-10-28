function b_r = sample_from(p,N)
b_r = zeros(N,1);
while sum(b_r)==0
b_r=(rand(N,1)<p);
end
end