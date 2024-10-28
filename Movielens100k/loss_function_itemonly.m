function [error,error_mse] = loss_function_itemonly(w,p,N,training_ratings,Bxih,BB,AA,mu_p,mu_w)
[U,I]=size(training_ratings);
loss=0;%only MSE and covariance for all users
error=0;%actual error
M=size(BB,1);
MSE=0;
for i=1:U
   t=training_ratings(i,:);
   if isempty(find(t))
       loss=loss;
       NT(i)=0;
   else
   items_rated=find(t);%items rated by this user
   ratings_vector=t(items_rated);%ratings of those items
   Bxih_s=Bxih(:,items_rated);% columns of bxih as per items rated by this user
   MSE=MSE+norm((w.*p)'*Bxih_s-ratings_vector,2)^2;%MSE
   COVARIANCE=trace(Bxih_s'*diag(w.*w.*p.*(ones(N,1)-p))*Bxih_s);%covariance
   loss=loss+MSE+COVARIANCE;%update loss
   end
end
NT=length(find(training_ratings));
error_mse=loss/NT;
error=(loss+mu_p*norm((repmat(p,1,NT)-AA'),2)^2+mu_w*norm((repmat(w,1,NT)-BB'),2)^2)/NT;
end