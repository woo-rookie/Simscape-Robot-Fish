% This script creates the model workspace &
% sets parameters that define the geometry of the robot


Nsegs = 8;  % Number of links before tailfin
L_tot = 50.0;         % (cm)
L = L_tot/Nsegs;      % (cm) Segment length 
R = 0.05;  % (cm) Radius of joints 
W = 0.8;    % (cm) Width scale factor, scales body width 

% Inertia matrix of robot
M = inertiaMatrix(); % (g*cm^2) 

% Setting gain parameters k1, k2 to calculate kp, kd controller 
% gain matrices

A = 2;
k1 = 1;  
k2 = 2;
kp = A.^2 *  k1*k2;
kd = A * (k1 + k2); 

% Multiply by M to get gain matrices: 
Kp_mat = kp * M;
Kd_mat = kd * M;

% Derivative Filters Transfer functions (derivative + 2nd order LPF):
wn = 50; % rad/s
zeta = 0.9; % damping ratio
lpf_derivative = tf([wn*wn 0], [1 2*zeta*wn wn*wn]);
#controller_filter = tf(wn*wn, [1 2*zeta*wn wn*wn]);


