function OP = normalize_ratings(ratings)
OP=zeros(size(ratings));
available=ratings(find(ratings));
N=length(available);
mx=mean(available);
indexes=find(ratings);
norm_ratings=available-mx*ones(N,1);
OP(indexes)=norm_ratings;
end