function [x,y,R]=FinDiff_Laplace_Eq(Lx,Ly,Nx,Ny,r_upper,r_lower,j_left,j_right,flag)

% Finite Difference Method for the numerical solution of
% 2D Laplace equation in a rectangular domain of width Lx and height Ly
% Nx and  Ny are the numbers of nodes in x and y directions, respectively
% Dirchlet BCs are used on the upper and lower side of the domain
% and Neumann BCs are used on the left and right side of the domain
% In particular:
% r_upper = prescribed concentration at the upper side
% r_lower = prescribed concentration at the lower side
% j_left = prescribed flux (normalized by D) at left side
% j_right = prescribed flux (normalized by D) at right side
% flag = 1 plots the result

% NOTE: r_upper,r_lower,j_left,j_right can be scalar or
% row vectors (for non-uniform BCs)

hx = Lx/(Nx-1); % distance of nodes in x direction
hy = Ly/(Ny-1); % distance of nodes in y direction
x = [0:Nx-1]*hx; % x-coordinates of nodes
y = [0:Ny-1]*hy; % y-coordinates of nodes

% Construct the coefficient matrix A of the final linear system Ax = b
A = buildCoeffMatrix(Lx,Ly,Nx,Ny);

% Construct the vector b of the final linear system Ax = b
b = buildRHSvector(Lx,Ly,Nx,Ny,r_upper,r_lower,j_left,j_right);

% Solve the system Ax=b
r = A\b;
% Insert the known values for the Dirichlet BCs in the solution vector:
r =[r_upper'.*ones(Nx,1); r; r_lower'.*ones(Nx,1)];

% Reshape the column r into a matrix R such that R(j,i) = ñ(x(i),y(j))
% to be used for surface plots 
R = reshape(r,[Ny,Nx])'; R=flip(R);


%% ---------------------------------------------------------------------
% Surface plot of the solution ñ(x,y)
if flag==1,
    fig1=figure(1); fig1.Position = [10    45   985   640];
    
    hh=surf(x,y,R);
    colormap('jet'); colorbar;
    % don't show mesh lines for fine grids but draw boundary of the surface
        if Nx*Ny>5000
             set(hh,'linestyle','none');   hold on; 
             plot3(zeros(Nx,1),y,R(:,1),'k'); % line on left boundary
             plot3(Lx*ones(Nx,1),y,R(:,end),'k'); % line on right boundary
             plot3(x,zeros(Ny,1),R(1,:),'k'); % line on lower boundary
             plot3(x,Ly*ones(Ny,1),R(end,:),'k'); % line on top boundary
        end
    
    set(gca,'FontSize',18,'FontName','Times');
    xlabel('$$x$$','Interpreter','Latex','FontSize',33);
    ylabel('$$y$$','Interpreter','Latex','FontSize',33,'Rotation',0);
    zlabel('$$\rho(x,y)$$','Interpreter','Latex','FontSize',33,'Rotation',0)
    set(gca, 'LineWidth', 1,'XColor','k','YColor','k'); set(gcf,'Color','w');
end

