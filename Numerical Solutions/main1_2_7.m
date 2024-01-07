clc; close all; clear all
Lx=10;   Ly=10;  %width Lx and height Ly of the domain
Nx=300;  Ny=300; % number of nodes in x and y directions

% Boundary Conditions (BCs)
r_upper=100;  
r_lower=60;
j_left=10;   % flux normalized by diffusion coefficient D
j_right=10;  % flux normalized by diffusion coefficient D

[x,y,R]=FinDiff_Laplace_Eq(Lx,Ly,Nx,Ny,r_upper,r_lower,j_left,j_right,1);