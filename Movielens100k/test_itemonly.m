function [MAET,RMSET,aM,aR] = test_itemonly(w,p,testdata,N_rep,N,Bxih)
ratings_in_test=0;MAE=0;RMSE=0;[U,I]=size(testdata);
for u=1:U
ratings_known=testdata(u);
for n=1:N_rep
       op(n)=(link_gen(p,w,N))'*Bxih;
end
x_hat=mean(op);
if ratings_known==0
MAE(u)=0;
RMSE(u)=0;
else
MAE(u)=abs(x_hat-ratings_known);
RMSE(u)=(x_hat-ratings_known)^2;
end
end
aM=MAE(find(MAE));
aR=RMSE(find(RMSE));
MAET=median(MAE(find(MAE)));
RMSET=sqrt(median(RMSE(find(RMSE))));