function qd = inverseKinematics(t)
% This function converts the gait equation to body angles
% It uses a small angle approximation which assumes
% the displacement between joints is the same as when the body is straight
% i.e. instead of root-finding, assume x = i * L;

nJoints = 9;                % Number of joints, joint angles qd 
L = 30.5/8;                 % Body segment length, assuming all same
qd = zeros(nJoints, 1);     % Vector of reference angles (output)

% Calculate (x,y) coordinates of joints w.r.t gait 
% and use 'atan' trig to find subtended angles qd: 

qtot = 0;
for i = 1:nJoints
    xp = (i-1) * L;
    x  = i * L;
    yp = lighthillCurve(xp, t);
    y  = lighthillCurve(x, t);
    xd = x - xp;
    yd = y - yp;
    qd(i) = atan(yd/xd) - qtot;
    qtot = qtot + qd(i);  
end
end



