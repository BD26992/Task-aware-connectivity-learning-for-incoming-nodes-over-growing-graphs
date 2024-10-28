function plot_this_image(A)

figure
%axis
x = 10.^[-5,-4,-3,-2,-1,0];
y = 10.^[-5,-4,-3,-2,-1,0]; 

%display image
imagesc(x,y,A); colormap(flipud(bone));colorbar
set(gca,'XScale','log');set(gca,'YScale','log');xlabel('mu_w');ylabel('mu_p');
c=colorbar;
caxis([0, 0.03]);c.FontSize=30;

ax=gca;
ylabel('$$\mu_{p}$$','Interpreter','latex');
xlabel('$$\mu_{w}$$','Interpreter','latex');
%xlabel('\mu_w');

ax=gca;ax.XAxis.FontSize = 20;ax.YAxis.FontSize = 20;



end