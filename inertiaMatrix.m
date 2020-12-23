function M = inertiaMatrix()
% This script calculates the inertia matrix, a diagonal matrix
% whose elements are moments of inertia about each joint 

length = 50.0/8; 
N = 8; % number of masses (7 joint + tailfin)

massVector = [290, 590, 380, 210, 150, 95, 54, 64]'/1000; % (g) mass distribution

elements = zeros(N-1,1);

% Calculate inertia matrix elements:

for i = 1:N-1
    M_i = 0;
    for k = 1:N
        M_i = M_i + massVector(k) * (length * (i-k)).^2;
    end
    elements(i) =  M_i;
end

M = diag(elements);

end 
