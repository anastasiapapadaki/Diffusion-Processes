function A = buildCoeffMatrix(Lx,Ly,Nx,Ny)

hx = Lx/(Nx-1); % distance of nodes in x direction
hy = Ly/(Ny-1); % distance of nodes in y direction

% numbers of bourdary nodes of dirichlet and neumann BCs
dirichlet = [1:Nx, (Ny-1)*Nx+1:Nx*Ny];
left=(1:(Ny-2))*Nx+1;
right=(2:(Ny-1))*Nx;

% Construct the coefficient matrix A of the final linear system Ax = b
% First we constract A without taking into account BCs
n=Ny*Nx; % initial shape without taking into account BCs is nxn
e = ones(n,1); 
ax=(1/hx^2); ay=(1/hy^2); axy=-2*(ax + ay); % non-zero values in A  
A = spdiags([ay*e,ax*e,axy*e,ax*e,ay*e],[-Nx, -1:1, Nx],n,n);

% Taking into account Neumann BCs:
A(left,left+1)=2*A(left,left+1);      A(left,left-1)=0;
A(right,right-1)=2*A(right,right-1);  A(right,right+1)=0;
% delete rows and columns corresponding to Dirichlet BCs:
A(dirichlet,:)=[];  A(:,dirichlet)=[];
