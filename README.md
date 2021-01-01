

## Simscape Robot Fish
Robot fish/tailfin simulation using Simulink's Simscape multibody library.
Inspired by the MIT RoboTuna. See SimscapeRobotFishMath.pdf for math explanation.

## Requirements
1. [MATLAB](https://mathworks.com/products/matlab.html) (r2019A)
2. [Simulink](https://mathworks.com/products/simulink.html)
3. [Simscape](https://mathworks.com/products/simscape.html) 
4. [Simscape Multibody](https://mathworks.com/products/simmechanics.html)

## Running Simulations
1) Open the source folder in MATLAB
2) Run params.m to populate Matlab workspace
3) (OPTIONAL) Edit waveform parameters (A,c1,c2,k,w) in lighthillCurve.m 
4) Open Model.slx 
5) In "Simulation->Model Configuration Parameters" choose the "daessc (DAE solver for simscape)" solver with variable-step
6) Run Model.slx 

## Simscape Renderings:

This "robot fish" is modeled as a 8-joint manipulator tasked with tracking a time-dependent plane curve known as the Lighthill curve:

<img src="https://render.githubusercontent.com/render/math?math=\Large Y(x,t) = (c_1 x %2B c_2 x^2)sin(kx - \omega t) %2B c_1xsin(\omega t)">.

The Lighthill curve is supposed to model a fish's swimming waveform (or gait) in the XY-plane. Each fish's gait has its own unique amplitude profile, wavenumber, and angular frequency. These parameters are also a function of swimming speed, acceleration, etc. 

### Params: wave number = 1/2, frequency = 4 rad/s, c1 = 0.84, c2 = 5.49 (Normalized to body length)
![](Gifs/b2.gif?raw=true) 

### Params: wave number = 3/4, frequency = 10 rad/s, c1 = 0.84, c2 = 5.49 (Normalized to body length)
![](Gifs/b3.gif?raw=true) 

## Simulink Model Structure 

At the top level inverseKinematics.m prepares a vector of reference angles from Y(x,t) which are passed to 
the PD controller block. The PD controller outputs a feedback torque as a function of the input angles
and (low-pass filtered) angular velocities. The torque control input is passed to the system dynamics,
rendered in Simscape, outputting the measured angles which feed back to PD controller block. 
### Top-Level Structure
![](ModelPics/TopLevel.png?raw=true)

### PD Torque Feedback Controller
![](ModelPics/PDcontroller.png?raw=true)

The simscape model is composed of 8 body link + 1 tail fin link. The 8 body links of constant length L = 6.25 cm are connected by the inner N = 7 revolute joints 1-7. There are also revolute joints '0' which connects the frontmost link to the world frame and 't' connects the 8th link to the tailfin. Joints 1-t each have torsional spring and dampers with constant coefficients k = 200 [g cm^2 / s^2] and b = 5 [g cm s^2].

### 8 Body Links and Tailfin
![](ModelPics/8links.png?raw=true)

### Each Body Link + Joint
![](ModelPics/Link&Joint.png?raw=true)

## Output Data

Model.slx exports the reference angles, measured angles, and torques to .mat files in the Data folder which are then plotted by plotAll.m.
Example plots are below for the current version with first 2/7 reference angles set to zero:

### Params: wave number = 3/4, frequency = 3 rad/s, c1 = 1.65, c2 = 18 (Normalized to body length)

### Controller Torque 
![](Plots/u3.jpg?raw=true)
### Reference Angles
![](Plots/qd3.jpg?raw=true)
### Reference Angular Velocity
![](Plots/qd_dot3.jpg?raw=true)

## rootFindingAnimation.py

Creates GIF of N-joint polyline fitted to lighthill curve using the bisection method. This 
illustrates what inverseKinematics.m does. The reference angles used in the Matlab simulation are the angles between adjacent line segments.

![](Gifs/rootFinding3.gif?raw=true)![](Gifs/rootFinding4.gif?raw=true)


