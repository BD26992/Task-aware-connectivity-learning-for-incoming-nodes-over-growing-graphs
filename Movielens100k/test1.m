function [mae_item_specific,rmse_item_specific,maefull,rmsefull] = test1(w,p,testdata,N_rep,N,Bxih)
ratings_in_test=0;MAE=0;RMSE=0;[U,I]=size(testdata);
x_hat=zeros(1,I);
maeitems=zeros(1,I);
rmseitems=zeros(1,I);
for i=1:I
  for n=1:N_rep
     op(n)=(link_gen(p,w,N))'*Bxih(:,i);
  end
x_hat(i)=mean(op);
end
for i=1:I
nr(i)=length(find(testdata(:,i)));
end
for u=1:U
   tst=testdata(u,:);
   itemsrated=find(tst);
   for k=1:length(itemsrated)
   maeitems(itemsrated(k))= maeitems(itemsrated(k))+abs(x_hat(itemsrated(k))-tst(itemsrated(k)));
   rmseitems(itemsrated(k))= maeitems(itemsrated(k))+(x_hat(itemsrated(k))-tst(itemsrated(k)))^2;
   end
end
mae_item_specific=(maeitems./nr);
rmse_item_specific=sqrt(rmseitems./nr);
maefull=sum(maeitems)/sum(nr);
rmsefull=sqrt(sum(rmseitems)/sum(nr));
end