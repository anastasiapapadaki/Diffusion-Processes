clc; close all; clear all
Lx=10;   Ly=10;  %width Lx and height Ly of the domain

% Boundary Conditions (BCs)
r0=100; % Constant to be used in r_upper(x)
r_lower=50;
j_left=0;   % flux normalized by diffusion coefficient D
j_right=0;  % flux normalized by diffusion coefficient D

% Exact solution
R_exact=@(x,y) r_lower + ((r0 - r_lower)*y)/Ly + ...
    r0*( sinh((2*pi*y)/Lx)/sinh((2*pi*Ly)/Lx) ).*cos((2*pi*x)/Lx);

N = 30:10:200;   % different values for Nx=Ny
error_vals = zeros(size(N)); % vector to put max error for different N
h_vals = zeros(size(N)); % vector to put h=hx=hy  values for different N

for i=1:length(N)
    
    Nx=N(i);  Ny=Nx; % number of nodes in x and y directions
    
    hx = Lx/(Nx-1); % distance of nodes in x direction
    x = [0:Nx-1]*hx; % x-coordinates of nodes
    % Boundary Condition at top boundary
    r_upper= r0 + r0*cos((2*pi*x)/Lx);

    % numerical solution
    [x,y,R]=FinDiff_Laplace_Eq(Lx,Ly,Nx,Ny,r_upper,r_lower,j_left,j_right,0);
    
    % calculate exact solution at nodes
    [X,Y] = meshgrid(x,y);
    Rexact = R_exact(X,Y);
    
    % error calculation:
    error = abs(R - Rexact); % pointwise error
    error_vals(i)=max(max(error)); % max value of error
    fprintf('N=%d, maximum error is %g \n', Nx,error_vals(i))
    h_vals(i)=hx;
end

% numerical estimation of the order of the method:
for i=1:length(N)-1
    p = log(error_vals(i+1)/error_vals(i))/log(h_vals(i+1)/h_vals(i));
    fprintf('N1 = %d, N2=%d:  order p= %g \n', N(i),N(i+1),p)
end

% Logarithmic plot of error_max vs h=hx=hy
fig1=figure(1); fig1.Position = [10    45   985   640];
loglog(h_vals,error_vals,'b-o','LineWidth',1,'MarkerSize',8)
axis tight
set(gca,'FontSize',18,'FontName','Times');
xlabel('$$h$$','Interpreter','Latex','FontSize',33);
ylabel('$$\epsilon_{max}$$','Interpreter','Latex','FontSize',33,'Rotation',0);
set(gca, 'LineWidth', 1,'XColor','k','YColor','k'); set(gcf,'Color','w');
