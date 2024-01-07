clear all; close all; clc
Nx=5; Ny=5;

x=linspace(1,Nx,Nx);
y=linspace(1,Ny,Ny);

for i=1:Nx
    plot(x(i)*ones(1,Ny),y,'k','linewidth',1.5)
    hold on
end
k=1:Ny;
for j=Ny:-1:1
    plot(x,y(j)*ones(1,Nx),'k-o','linewidth',1.5,'MarkerFaceColor','w','MarkerSize',20)
    text(x,y(j)*ones(1,Nx)+0.03,strsplit(num2str(k)),...
        'HorizontalAlignment', 'center','VerticalAlignment','middle','FontSize',16)
    k=k+Ny;
    hold on
end
axis image
% axis off
set(gca,'XTick',1:1:Nx,'FontSize',20,'FontName','Times')
set(gca,'YTick',1:1:Nx,'FontSize',20,'FontName','Times');
xlabel('$$i$$','Interpreter','Latex','FontSize',25,'FontName','Times');
ylabl=ylabel('$$j$$','Interpreter','Latex','FontSize',25,'FontName','Times','rotation',0);
set(ylabl, 'Units', 'Normalized', 'Position', [-0.2, 0.45, 0]);
box off
set(gca, 'LineWidth', 1,'XColor','b','YColor','b','ZColor','k'); set(gcf,'Color','w');
a=gca; a.XRuler.TickLabelGapOffset = 8; a.YRuler.TickLabelGapOffset = 11;
