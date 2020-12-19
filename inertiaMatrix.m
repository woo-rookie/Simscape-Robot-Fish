function M = inertiaMatrix(q)
% This script calculates the inertia matrix, a diagonal matrix
% whose elements are moments of inertia about each joint 
N = 9;
radius = 0.0381; % Radius of joints
length = 10; % Length of segments
%qf = tril(ones(N))*q; % Vector of total angles w.r.t. world frame
qf = diag(q);
massVector = [340,320,160,80,40,20,10,8,5]'/1000; % (kg) mass distribution
%IcmVector = 0.5*massVector*radius.^2; % (kg*m^2) COM Inertia distribution
elements = zeros(N,1);

% Algorithm to calculate inertia matrix elements:

for i = 1:N
    
    T1 = 0; T2 = 0;
    for k = 1:N
        mk = massVector(k);
        C1 = 0; S1 = 0; C2 = 0; S2 = 0;
        
        if k < i
            for j = k+1:i-1
                Q = 0;
                for n = j:i-1
                    Q = Q + qf(n);
                end
                C1 = C1 + cos(Q);
                S1 = S1 + sin(Q);
            end
            T1 = T1 + mk*length.^2 *((1+C1).^2 + S1.^2);
        end
        
         if k > i
            for j = i+1:k-1
                Q = 0;
                for n = i+1:j
                    Q = Q + qf(n);
                end
                C2 = C1 + cos(Q);
                S2 = S1 + sin(Q);
            end
            T2 = T2 + mk*length.^2 *((1+C2).^2 + S2.^2);
         end
    end
    
    elements(i) =  T1 + T2;
end

M = diag(elements);

end 
