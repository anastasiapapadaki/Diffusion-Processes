clc; close all; clear all
Lx=10;   Ly=10;  %width Lx and height Ly of the domain
Nx=100;  Ny=100; % number of nodes in x and y directions

hx = Lx/(Nx-1); % distance of nodes in x direction
x = [0:Nx-1]*hx; % x-coordinates of nodes

% Boundary Conditions (BCs)
r0=100; % Constant to be used in r_upper(x)
r_upper= r0 + r0*cos((2*pi*x)/Lx);
% r_upper=100;
r_lower=50;
j_left=0;   % flux normalized by diffusion coefficient D
j_right=0;  % flux normalized by diffusion coefficient D

% numerical solution
[x,y,R]=FinDiff_Laplace_Eq(Lx,Ly,Nx,Ny,r_upper,r_lower,j_left,j_right,0);

% Exact solution
% R_exact=@(x,y)  r_lower + (r_upper-r_lower)*y/Ly; 
R_exact=@(x,y) r_lower + ((r0 - r_lower)*y)/Ly + ...
    r0*( sinh((2*pi*y)/Lx)/sinh((2*pi*Ly)/Lx) ).*cos((2*pi*x)/Lx);
[X,Y] = meshgrid(x,y);
Rexact = R_exact(X,Y);

% error calculation
error = abs(R - Rexact);
fprintf('maximum error is %g \n',max(max(error)))

%% -------------------------------------------------------------
fig1=figure(1); fig1.Position = [10    45   985   640];
surf(x,y,error); colormap('jet'); colorbar
set(gca,'FontSize',18,'FontName','Times');
xlabel('$$x$$','Interpreter','Latex','FontSize',33);
ylabel('$$y$$','Interpreter','Latex','FontSize',33,'Rotation',0);
zlabel('$$\epsilon(x,y)$$','Interpreter','Latex','FontSize',33,'Rotation',0)
set(gca, 'LineWidth', 1,'XColor','k','YColor','k'); set(gcf,'Color','w');

%---------------------------------------------------------
% Plot the exact solution using a fine (x,y) mesh
x=linspace(0,Lx,101); y=linspace(0,Ly,101);
[X,Y] = meshgrid(x,y);
fig2=figure(2); fig2.Position = [10    45   985   640];
hh=surf(X,Y,R_exact(X,Y)); 
colormap('jet'); shading interp; colorbar
set(gca,'FontSize',18,'FontName','Times');
xlabel('$$x$$','Interpreter','Latex','FontSize',33);
ylabel('$$y$$','Interpreter','Latex','FontSize',33,'Rotation',0);
zlabel('$$\rho(x,y)$$','Interpreter','Latex','FontSize',33,'Rotation',0)
set(gca, 'LineWidth', 1,'XColor','k','YColor','k'); set(gcf,'Color','w');