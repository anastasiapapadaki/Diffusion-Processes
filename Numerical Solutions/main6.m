clc; close all; clear all
% Solution as 1-D problem in the case of j_left=0, j_right=0;
% and uniform r_upper and r_lower

Lx=10;   Ly=10;  %width Lx and height Ly of the domain
Nx=21;  Ny=21; % number of nodes in x and y directions

% Boundary Conditions (BCs)
r_upper=100;  
r_lower=50;
j_left=0;   % flux normalized by diffusion coefficient D
j_right=0;  % flux normalized by diffusion coefficient D

hx = Lx/(Nx-1); % distance of nodes in x direction
hy = Ly/(Ny-1); % distance of nodes in y direction
x = [0:Nx-1]*hx; % x-coordinates of nodes
y = [0:Ny-1]*hy; % y-coordinates of nodes

% Construct the coefficient matrix A and vector b of the linear system Ax = b
e = ones(Ny-1,1);
A = spdiags([-e,2*e,-e],-1:1,Ny-2,Ny-2);
b = sparse(Ny-2,1); b(1)=r_lower;  b(end)=r_upper;
% Solve the system Ax=b
r = A\b;
% Insert the known values for the Dirichlet BCs in the solution vector:
r =[r_lower; r; r_upper];

% replicate the solution Nx times
R=repmat(r,1,Nx);

%%
%Surface plot of the solution ñ(x,y)
fig1=figure(1); fig1.Position = [10    45   985   640];
hh=surf(x,y,R); % for 3D plot
% hh=surface(x,y,R); %set(hh,'linestyle','none') % for 2D plot
colormap('jet'); colorbar; %set(hh,'linestyle','none')

set(gca,'FontSize',18,'FontName','Times');
xlabel('$$x$$','Interpreter','Latex','FontSize',33);
ylabel('$$y$$','Interpreter','Latex','FontSize',33,'Rotation',0);
zlabel('$$\rho(x,y)$$','Interpreter','Latex','FontSize',33,'Rotation',0)
set(gca, 'LineWidth', 1,'XColor','k','YColor','k'); set(gcf,'Color','w');