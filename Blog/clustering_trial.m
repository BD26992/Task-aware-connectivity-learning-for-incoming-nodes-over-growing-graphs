clear all
A1=rand(50,50);%first cluster
A2=rand(50,50);%second cluster
for i=1:50
A1(i,i)=0;
A2(i,i)=0;
end

for r=1:100
A11=rand(50,50);%side connections
ss=[0:0.01:0.99];
A=[A1,zeros(50,50);zeros(50,50),A2];
for i=1:length(ss)
T1=A11;    
T1(T1<ss(i))=0;
A_nc=[A1,T1;T1',A2];
cc(r,i)=clustering_coeff(A_nc);
end
end
