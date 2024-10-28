function clean_ratings = clean(ratings,cc)
[U,I]=size(ratings);
%user trimming
for u=1:U
   a(u)=length(find(ratings(u,:)));
end
for i=1:I
   b(i)=length(find(ratings(:,i)));
end
users_accepted=find(a>=cc);
items_accepted=find(b>=cc);
clean_ratings=ratings(users_accepted,items_accepted);
end