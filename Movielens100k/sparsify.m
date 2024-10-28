function r = sparsify (ratings,f)
p=find(ratings);
r=ratings;
r(p(1:f*length(p)))=0;
end