import numpy as np
import matplotlib.pyplot as plt
import imageio
from scipy.optimize import fsolve 
import math 

"""
This script outputs an animated GIF of a parameterized Lighthill waveform "lighthill(x,t)" with
a fitted polyline that represents the result of inverse kinematics. 

- The original lighthill waveform takes the form y(x,t) = (c1 * x + c2 * x**2) * sin(k*x - w*t).

- Another version takes the form y(x,t) = (c1*x + c2*x**2) * sin(k*x - w*t) - c1*x*sin(w*t).
  This version damps the motion of the "head" segment with respect to the body. 

- A nice "fish-like" example is y(x,t) = (0.2*1.1*x + 0.2*0.6*x**2)*sin(1.5*x - 1*t) on the interval (-0.2, 1.25)

- Best practice is to normalize "x" w.r.t. body length 
- The parameters are:

k         Body wavenumber 
w         Angular frequency
c1, c2    Linear, quadratic amplitude constants 


"""
# Example of a lighthill waveform on interval (-0.2, 1.25): y(x,t) = (0.2*1.1*x + 0.2*0.6*x**2)*sin(1.5*x - 1*t)

# We can use the small angle root-finding approximation which assumes the points are equally spaced along the x 
# this should give a reasonably accurate approximation of the angles 
# in this case the algorithm is: 
# Assume the x's are equally space by the joint length, calculate the Y's from the lighthill equation
# then calculate the angles from the x's and y's 

# Time: 
tclock = 2.0
# Robot Params: 
Nlinks = 8
SCALE = 1
L = 10.0 * SCALE
L_tot = L * Nlinks
linkLengths = [L for i in range(0, Nlinks)]


def lighthill(x, t):
    # y = amp * sin(k*xn-w*t) + A*c1*xn*sin(w*t);
    # Gait Params: 
    A = 2
    c1 = 0.05*1.1
    c2 = 0.6*0.6
    waveNumber = 30 / L_tot
    k =  waveNumber * 2*np.pi
    w = 1
    xn = x / L_tot
    amp = A*L_tot*(c1*xn + c2*xn**2)
    return amp * np.sin(k*xn-w*t) + A*c1*xn*np.sin(w*t)

    
def lhRoots(x, t, xp, yp):
    return (lighthill(x,t)-yp)**2 + (x-xp)**2 - L**2



def lhRootFind(xp, tclock, Range, tolerance):
    error = 9999

    yp = lighthill(xp, tclock)

    x_left = xp
    x_right = xp + Range
    
    while error > tolerance:
        x_avg = (x_left + x_right)/2
        y_avg = lhRoots(x_avg, tclock, xp, yp) 
        y_left = lhRoots(x_left, tclock, xp, yp)
        y_right = lhRoots(x_right, tclock, xp, yp)

        if y_left * y_avg < 0:
            x_right = x_avg
        elif y_right * y_avg < 0:
            x_left = x_avg
        elif y_avg == 0:
            print "Exact solution"
        
        error = abs(y_avg)
     
    return x_avg

def rootFind(a, b, tol, xp, yp): # compare to bisect 
    c = fsolve(lambda x : lighthillRoots(x, tclock, xp, yp), xp+L, xtol=tol)
    return c 

def createImage(N):
    tstep = 0.2
    tclock = N * 0.2
    fig, ax = plt.subplots(figsize=(10,5))
    xmin = 0
    xmax = L_tot
    xstep = 0.5
    x = np.arange(0, 80, xstep)
    yscale = 100
    ax.set_ylim(-40, 40)
    ax.plot(x, lighthill(x, tclock), 'k') 
    ax.grid()

    # Calculating Points algorithm: 
    x0 = 0
    xList = [x0]
    yList = [lighthill(x0, tclock)]
    ax.plot(xList[0], yList[0], 'ro-')
    tolerance = 0.001
    segs = Nlinks
    ax.set_aspect('equal', adjustable='box')
    for i in range(1, segs):
    
        xList.append(lhRootFind(xList[i-1], tclock, L, tolerance))
        yList.append(lighthill(xList[i], tclock))
        ax.plot(xList[i], yList[i], 'ro-')
        ax.plot([xList[i-1], xList[i]], [yList[i-1], yList[i]], color='blue', linestyle = "--")

    fig.canvas.draw()
    image = np.frombuffer(fig.canvas.tostring_rgb(), dtype='uint8')
    image  = image.reshape(fig.canvas.get_width_height()[::-1] + (3,))
    return image

def createGIF():
    kwargs_write = {'fps':1.0, 'quantizer':'nq'}
    # createImage(i) for i in range(0, 40)
    imageList = []
    for i in range(0, 40):
        im = createImage(i)
        if (i == 0):
            imageio.imwrite('./rootFinding.jpg', im)
        imageList.append(im)
    imageio.mimsave('./rootFinding.gif', imageList, fps=10)

createGIF()

