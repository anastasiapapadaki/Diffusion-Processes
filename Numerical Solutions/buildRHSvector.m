function b = buildRHSvector(Lx,Ly,Nx,Ny,r_upper,r_lower,j_left,j_right)
hx = Lx/(Nx-1); % distance of nodes in x direction
hy = Ly/(Ny-1); % distance of nodes in y direction

% numbers of bourdary nodes of dirichlet and neumann BCs
dirichlet = [1:Nx, (Ny-1)*Nx+1:Nx*Ny];
left=(1:(Ny-2))*Nx+1;
right=(2:(Ny-1))*Nx;

n=Ny*Nx;
b1 = sparse(n,1); % an empty sparse vector
b1(left)=2*j_left/hx;    b1(right)=2*j_right/hx; % Neumann BCs
b1(dirichlet)=[];  % delete rows corresponding to Dirichlet BCs
b2 = sparse((Ny-2)*Nx,1); % an empty sparse vector
b2(1:Nx)=r_upper/hy^2;   b2(end-Nx+1:end)=r_lower/hy^2;
b = b1-b2;

