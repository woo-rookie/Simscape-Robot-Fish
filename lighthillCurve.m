function y = lighthillCurve(x,t)
% This script defines the gait waveform (lighthill equation)
% c1, c2, k, w 

% Total body length:
L_tot  = 30.5;

% Amplitude scale factor:
A = 0.5;

% lighthill c1, c2 coefficients:
c1 = 0.05*1.1;
c2 = 0.6*0.6; 

% wavenumber: 0.25 -> Thunniform, 0.5 -> Carangiform,
%             0.75 -> Subcarangiform, 1.0 ->  Anguilliform 

waveNumber = 0.25;
k = 2*pi*waveNumber; % 0.5 -> Carangiform

% tail-beat frequency (rad/s):
w = 2;

% lighthill equation:
xn = x/L_tot;     % x position normalized to length
amp = A*L_tot*(c1*xn + c2*xn.^2);    % traveling wave amplitude A(x)
y = amp * sin(k*xn-w*t) + A*c1*xn*sin(w*t);   % lighthill equation
end

