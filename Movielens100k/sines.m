function weights = sines(weights)
x=[0:0.1:10];

y1=ones(101,1);
y2=sin(0.8*x);
y3=sin(1.6*x);
y4=sin(2.4*x);
y5=sin(3.2*x);
y6=sin(4.0*x);
y7=sin(4.8*x);


s=weights*[y2;y3;y4;y5;y6;y7];

plot(x,s,'linewidth',2);
xticks([0 5 10])
yticks([-3 0 3])
ax=gca;
ax.FontSize=14;

end