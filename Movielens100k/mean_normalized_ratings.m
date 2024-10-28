function r = mean_normalized_ratings(ratings)
[U,I]=size(ratings);r=zeros(U,I);
for i =1:I
mask=zeros(U,1);
t=ratings(:,i);
loc=find(t);
m=mean(t(loc));
if isnan(m)
    m=0;
end
mask(loc)=1;
r(:,i)=ratings(:,i)-m*mask;
end
end