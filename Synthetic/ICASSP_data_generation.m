clear all
N=100;p_e=0.2;%N=|V|,p_e=edge prob.
G = gsp_erdos_renyi(N,p_e);%define graph
%clear all
%load BA
A=G.A;
%L=A-diag(sum(A,2));N=100;
K_bl=30;%band limited parameter
[U,V]=eig(full(L));xun=U(:,1:K_bl)*randn(K_bl,1);
x=xun-mean(xun)*ones(N,1);%zero mean normalization
p_true=sum(A,2)/sum(sum(A,2));
% %p_true=(1/N)*ones(N,1);%true p
w_true=ones(N,1);%true w
% 
% %function to generate dataset
R=1000;%size of dataset
alpha=0.3;K=5;profile='decaying';%type of filter (predetermined)
d_aplus=zeros(R,N);d_bplus=zeros(R,N);d_xplus=zeros(R,1);%placeholder
A=A/abs(max(eig(double(A))));
for i=1:R
     b_plus = zeros(N,1);
     while sum(b_plus)==0
         b_plus=(rand(N,1)<p_true);%sampling from p_true
     end
     a_plus=b_plus.*w_true;%a_+
     A_plus=[A,zeros(N,1);a_plus',0];%A_+
     h=flipud(get_filter_ICASSP(profile,alpha,K));
     filter_op=filterop(A_plus,x,h,K);%using very basic filter
     x_plus=filter_op(N+1);
     d_aplus(i,:)=a_plus';d_bplus(i,:)=b_plus';d_xplus(i)=x_plus;%store objects row-wise
     A_xh=[A*x,A^2*x,A^3*x]*h(2:4);
end