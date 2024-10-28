function plot_these(a,b)

figure
%axis
x_axis=[1:length(a)]*100;


%plots
plot(x_axis,a,'r','Linewidth',1,'Markersize',1);
hold on;
plot(x_axis,b,'b','Linewidth',1,'Markersize',1);
%axis([0 length(a) 0 5])
%labels and title
xlabel('Iterations');ylabel('MSE');%title('Training and Validation error vs iterations for MSE on ER graphs ');
ax=gca;ax.XAxis.FontSize = 20;ax.YAxis.FontSize = 20;ax.Title.FontSize=15;ax.Title.FontSize=16;

%legend
legend('convex', 'non convex');
ax.Legend.FontSize=18;

end