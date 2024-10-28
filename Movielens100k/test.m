
function [MAE,RMSE] = test(w,p,testdata,N_rep,N,Bxih)
ratings_in_test=0;MAE=0;RMSE=0;[U,I]=size(testdata);
for u=1:U
   pool=testdata(u,:);
   indexes=find(pool);
   ratings_known=pool(indexes);
   ratings_in_test=ratings_in_test+length(indexes);
   for i=1:I
       for n=1:N_rep
           op(n)=(link_gen(p,w,N))'*Bxih(:,i);
       end
   x_hat(i)=mean(op);
   %if x_hat(i)>5
   %    x_hat(i)=5;
   %elseif x_hat(i)<0
   %    x_hat(i)=0;
   %end
   end
   MAE=MAE+norm(x_hat(indexes)-ratings_known,1);
   RMSE=RMSE+norm(x_hat(indexes)-ratings_known)^2;
end
MAE=MAE/ratings_in_test;
RMSE=sqrt(RMSE/ratings_in_test);
end