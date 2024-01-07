clc; close all; clear all
Lx=10;   Ly=10;  %width Lx and height Ly of the domain
Nx=21;  Ny=21; % number of nodes in x and y directions

A = buildCoeffMatrix(Lx,Ly,Nx,Ny); % Build Coefficient Matrix

% Boundary Conditions (BCs)
j_left=0;   % flux normalized by diffusion coefficient D
j_right=0;  % flux normalized by diffusion coefficient D
% Different pairs of Dirichlet BCs:
r_upper=[200, 150, 100, 50, 90];
r_lower=[100, 80, 60, 30, 20];

hy = Ly/(Ny-1);   y = [0:Ny-1]*hy; 

fig2=figure(2); fig2.Position = [10    45   985   640];
for i = 1:length(r_upper)
    % Build right hand side vector b
    b = buildRHSvector(Lx,Ly,Nx,Ny,r_upper(i),r_lower(i),j_left,j_right);
    % Solve the system Ax=b
    r = A\b;
    % Insert the known values for the Dirichlet BCs in the solution vector:
    r =[r_upper(i)*ones(Nx,1); r; r_lower(i)*ones(Nx,1)];
    % Reshape the column r into a matrix R
    R = reshape(r,[Ny,Nx])'; R=flip(R);
    plot(y,R(:,round((Nx+1)/2)),'Linewidth',2);
    hold all
end

set(gca,'FontSize',18,'FontName','Times');
xlabel('$$y$$','Interpreter','Latex','FontSize',33);
ylabl = ylabel('$$\rho$$','Interpreter','Latex','FontSize',33,'Rotation',0);
set(ylabl, 'Units', 'Normalized', 'Position', [-0.1, 0.45, 0]);
set(gca, 'LineWidth', 1,'XColor','k','YColor','k'); set(gcf,'Color','w');