function [exist,trn,tst] = select_existing_users(ratings,n_ex,n_train)
[U,I]=size(ratings);
for u=1:U
   score(u)=length(find(ratings(u,:)));
end
[a,b]=sort(score,'descend');
existinguser_indexes=b(1:n_ex);
remaining=b(n_ex+1:U);
ok=randperm(length(remaining));

train_indexes=remaining(ok(1:n_train));
test_indexes=remaining(ok(n_train+1:length(remaining)));
exist=ratings(existinguser_indexes,:);
trn=ratings(train_indexes,:);
tst=ratings(test_indexes,:);
end
