function [mae_global,rmse_global,medae,rmedse] = test1_final(w,p,testdata,N_rep,N,Bxih)
ratings_in_test=0;MAE=0;RMSE=0;[U,I]=size(testdata);
x_hat=zeros(1,I);
maeitems=zeros(1,I);
rmseitems=zeros(1,I);
for i=1:I
[medae(i),rmedse(i)]=test_itemonly(w,p,testdata(:,i),N_rep,N,Bxih(:,i));
end
medae(find(isnan(medae)))=[];
rmedse(find(isnan(rmedse)))=[];
mae_global=mean(medae);
rmse_global=mean(rmedse);
end