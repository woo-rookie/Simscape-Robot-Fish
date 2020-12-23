function x_avg = rootFind(xp , t, range, tolerance)
    x_avg = 0;
    
    % initial height
    yp = lighthillCurve(xp, t);
    
    % total curve length:
    L = 50.0/8;
    
    % (a, b) or left and right bounds in bisection method:
    x_left = xp;
    x_right = xp + range;
    
    % Bisection method for (x-c)^2 + (f(x)-f(c))^2 = L^2
    error = 9999;
    while error > tolerance
        x_avg = (x_left + x_right)/2;
        y_avg = (lighthillCurve(x_avg,t)-yp).^2 + (x_avg-xp).^2 - L.^2;
        y_left = (lighthillCurve(x_left,t)-yp).^2 + (x_left-xp).^2 - L.^2;
        y_right = (lighthillCurve(x_right,t)-yp).^2 + (x_right-xp).^2 - L.^2;
        
        if y_left * y_avg < 0
            x_right = x_avg;
        elseif y_right * y_avg < 0
            x_left = x_avg;
        end
        error = abs(y_avg);
    end
    
end
     
        