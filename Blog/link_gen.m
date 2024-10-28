function a_rel = link_gen(p,w,N)
b = zeros(N,1);
%pp=max(p);
 while sum(b)==0
   b=(rand(N,1)<p);
 end
a_rel=b.*w;
end