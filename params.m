% This script creates the model workspace &
% sets parameters that define the geometry of the robot

Nsegs = 8;
L_tot = 30.5;         % (cm)
L = L_tot/Nsegs;      % (m) Segment length 
R = 0.1 * 30.5/80.0;  % (cm) Radius of joints 
W = 1 * 30.5/80.0;    % (cm) Width scale factor, scales body width 

% Inertia matrix of robot
M = inertiaMatrix(zeros(9,1)); % (kg*cm^2) 

% Spring and Damper Matrices
damperCoeff = 5/1000;
springCoeff = 200/1000;

kernel = [1 -1 0 0 0 0 0 0 0;
         -1 1 -1 0 0 0 0 0 0;
         0 -1 1 -1 0 0 0 0 0;
         0 0 -1 1 -1 0 0 0 0;
         0 0 0 -1 1 -1 0 0 0;
         0 0 0 0 -1 1 -1 0 0;
         0 0 0 0 0 -1 1 -1 0;
         0 0 0 0 0 0 -1 1 -1;
         0 0 0 0 0 0 0 -1 1;];
     
springMatrix = springCoeff * kernel;
damperMatrix = damperCoeff * kernel;

% Setting gain parameters k1, k2 to calculate kp, kd controller 
% gain matrices

A = 10;
k1 = 1;  
k2 = 2;

kp = A.^2 *  k1*k2;
kd = A * (k1 + k2); 

% Multiply by M to get gain matrices: 
Kp_mat = kp * M;
Kd_mat = kd * M;

% Derivative Filters Transfer functions:
wn = 10;
zeta = 0.9;
u_max = 10;
lpf_derivative = tf([wn*wn 0], [1 2*zeta*wn wn*wn]);
controller_filter = tf(wn*wn, [1 2*zeta*wn wn*wn]);


