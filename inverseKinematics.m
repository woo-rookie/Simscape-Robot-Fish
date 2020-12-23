function qd = inverseKinematics(t)
% This function converts the lighthill equation to body angles

nJoints = 7;                % Number of joints, joint angles qd 
L = 50.0/8;                 % Body segment length, constant
qd = zeros(nJoints, 1);     % Vector of reference angles (output)

% Calculate (x,y) coordinates of joints w.r.t gait 
% and use 'atan' trig to find subtended angles qd: 

tolerance = 0.01; % bisection method tolerance
qSum = 0; % cumulative angle
x0 = 0; % initial position of joint 2

% first 2 joints track a straight line
qd(1) = 0;
qd(2) = 0;
x_i =  rootFind(x0, t, L, tolerance); % first x_i is x2 (joint 2) which is 0
y_i = lighthillCurve(x_i, t);

% calculate angles via recurrence relation:
for i = 3:nJoints
    x_next  = rootFind(x_i, t, L, tolerance); 
    y_next  = lighthillCurve(x_next, t);  
   
    qd(i) = atan((y_next - y_i)/(x_next - x_i)) - qSum;
    qSum = qSum + qd(i);  
    x_i = x_next;
    y_i = y_next;
   
end
end



