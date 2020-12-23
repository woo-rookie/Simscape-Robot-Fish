function y = lighthillCurve(x,t)
% This script defines the gait waveform (lighthill equation)
% c1, c2, k, w 

% Total body length:
L_tot  = 50.0;

% Amplitude scale factor:
A = 0.8;

% lighthill c1, c2 coefficients:
c1 = 0.05*1.1; % 0.055
c2 = 0.012;  % 0.36

% wavenumber: 0.25 -> Thunniform, 0.5 -> Carangiform,
%             0.75 -> Subcarangiform, 1.0 ->  Anguilliform 

waveNumber = 0.66;
k = 2*pi*waveNumber; 

% tail-beat frequency (rad/s):
w = 4;

% lighthill equation:
xn = x/L_tot;     % x position normalized to length

amp = A*L_tot*(c1*xn + c2*L_tot*xn.^2);    % traveling wave amplitude A(x)
y = amp * sin(k*xn-w*t) + A*c1*xn*sin(w*t);   % lighthill equation
end

