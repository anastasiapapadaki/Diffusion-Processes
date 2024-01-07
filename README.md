**Diffusion Phenomena and Numerical Modeling**

This README introduces a practical exploration into diffusion phenomena and its numerical representation through Fick's laws. Transport phenomena in nature exhibit two primary modes: convection or advection for directed particle movement and diffusion for random particle motion. At an atomic scale, diffusion emerges from undirected particle motion propelled by thermal fluctuations, leading to a homogenization of materials when concentration differences exist. This practical focuses on a phenomenological approach, delving into Fick's laws and their implications on diffusion flux, which gravitates from high to low concentration regions.

The practical is divided into three key segments: first, deriving and numerically discretizing the governing partial differential equations; second, implementing numerical methods for stationary diffusion; and finally, interpreting and validating the results obtained.

**Content Overview:**

1. **Governing Partial Differential Equations and Discretization**
    - *Constitutive equations:* Utilizing Fick's law as a foundation for numerical setup within a 2-dimensional domain for diffusing species, involving concentration, diffusion flux, and diffusion constants.
    - *Boundary conditions:* Imposing Dirichlet boundary conditions for the top and lower boundaries, while von Neumann boundary conditions are applied to the left and right boundaries, thereby establishing relationships between unknown and known nodal values.

2. **Assembling the System**
    - *System representation:* The resulting system, comprising linear equations derived from the previous steps, is structured as a matrix equation (Ax = b), with x as the unknown vector, b containing known values, and A representing the coefficient matrix.
    - *Solving the system:* The steps involve assembling the coefficient matrix, forming the vector on the right-hand side, and solving the resulting linear system through direct or iterative solvers to derive the diffusion phenomena's numerical representation.

This README serves as a comprehensive guide to understanding and implementing diffusion phenomena through Fick's laws and numerical methods, offering a practical insight into the modeling of such complex transport processes.
