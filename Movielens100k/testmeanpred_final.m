function [mae_item,rmse_item] = testmeanpred_final(trndata,testdata)
ratings_in_test=0;MAE=0;RMSE=0;[U,I]=size(testdata);
x_hat=zeros(1,I);
maeitems=zeros(1,I);
rmseitems=zeros(1,I);
for i=1:I
trni=trndata(:,i);
x_hat(i)=mean(trni(find(trni)));
end
for i=1:I
nr(i)=length(find(testdata(:,i)));
itemsrated=find(testdata(:,i));
n_itemsrated=length(itemsrated);
predicted=x_hat(i)*ones(n_itemsrated,1);
mae_seed=abs(testdata(itemsrated)-predicted);
rmse_seed=(testdata(itemsrated)-predicted).^2;
rmse_item(i)=sqrt(median(rmse_seed));
mae_item(i)=(median(mae_seed));
end
rmse_item(find(isnan(rmse_item)))=[];
mae_item(find(isnan(mae_item)))=[];
end