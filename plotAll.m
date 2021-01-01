%{
File Plots qd, qd_dot, q, q_dot, u

%}

addpath('Data/');
load('Data/q.mat'); % q_rad
load('Data/qd.mat'); % qd_rad
load('Data/q_dot.mat'); % q_dot_rad
load('Data/qd_dot.mat'); % qd_dot_rad
load('Data/u.mat'); % u_torque

t = q_rad(1,:);
q = q_rad(2,:);
q_dot = q_dot_rad(2,:);
qd = qd_rad(2,:);
qd_dot = qd_dot_rad(2,:);
u = u_torque(2,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot q 

figure(1);
plot(t, q_rad(4:8,:));
title('measured angle q (rad) vs. time (s)');
xlabel('time (s)');
ylabel('angle (rad)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot q_dot
figure(2);
plot(t, q_dot_rad(4:8,:));
title('measured angular velocity dq/dt (rad/s) vs. time (s)');
xlabel('time (s)');
ylabel('angular velocity (rad/s)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot qd 
figure(3);
plot(t, qd_rad(4:8,:));
title('reference angle q_d (rad) vs. time (s)');
xlabel('time (s)');
ylabel('angle (rad)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot qd_dot

figure(4); 
plot(t, qd_dot_rad(4:8,:));
ylim([-3, 3]);
title('reference angular velocity dq_d/dt (rad/s) vs. time (s)');
xlabel('time (s)');
ylabel('Plots');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot u

figure(5);
plot(t, u_torque(4:8,:));
ylim([-0.2, 0.2]);
title('joint control torque u (gcm^2/s^2) vs. time (s)');
xlabel('time (s)');
ylabel('u (gcm^2/s^2)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



