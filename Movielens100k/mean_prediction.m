function [maerror,rmse] = mean_prediction(trn,tst)
[U,I]=size(trn);nrt=0;maerror=0;rmse=0;
[Utst,~]=size(tst);
for i=1:I
    t=(trn(:,i));
    predicted(i)=mean(t(find(t)));
end

for u=1:Utst
    ts=tst(u,:);
    loc=find(ts);
    nrt=nrt+length(loc);
    maerror=maerror+norm(predicted(loc)-ts(loc),1);
    rmse=rmse+norm(predicted(loc)-ts(loc))^2;
end
maerror=maerror/nrt;
rmse=sqrt(rmse/nrt);
end