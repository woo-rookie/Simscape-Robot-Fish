

## Simscape Robot Fish
Robot fish/tailfin simulation using Simulink's Simscape multibody library.
Inspired by the MIT RoboTuna. See math.pdf for explanation of math involved. 

## Summary 

## Requirements
1. [MATLAB](https://mathworks.com/products/matlab.html) (r2019A)
2. [Simulink](https://mathworks.com/products/simulink.html)
3. [Simscape](https://mathworks.com/products/simscape.html) 
4. [Simscape Multibody](https://mathworks.com/products/simmechanics.html)

## Simscape Renderings:

//gif1 a1
//gif2 b2
//gif3 b3
![](Gifs/a1.gif?raw=true)
![](Gifs/b2.gif?raw=true)
![](Gifs/b3.gif?raw=true)

## Output Plots
q, qd, e (rad)
q', qd', e'(rad/s)
u (gcm^2/s^2)

// Plot1 Plots/velocityVsTime7.png
// Plot2 velocityVsTime4_filter2.png
// Plot3 torque4.png
// Plot4 velocityVsTime2.png
![](Plots/velocityVsTime7.png?raw=true)
![](Plots/velocityVsTime4_filter2.png?raw=true)
![](Plots/torque4.png?raw=true)
![](Plots/velocityVsTime2.png?raw=true)

## Running Simulations
1) Open the source folder in MATLAB
2) Run params.m to populate Matlab workspace
3) (OPTIONAL) Edit waveform parameters (A,c1,c2,k,w) in lighthillCurve.m 
4) Open model.slx 
5) In "Simulation->Model Configuration Parameters" choose the "daessc (DAE solver for simscape)" solver with variable-step
6) Run model.slx 


## Simulink Model Structure 

Top-Level Structure
// ModelPics/FullModel.png
// ModelPics/PDController.png
// ModelPics/Link&Joint.png
![](ModelPics/FullModel.png?raw=true)
![](ModelPics/PDController.png?raw=true)
![](ModelPics/Link&Joint.png?raw=true)

PD Controller


Simscape N-Joint Manipulator


## rootFindingAnimation.py

Creates GIF of N-joint polyline fitted to lighthill curve using bisection method
The reference angles used in the simulation are the angles between adjacent line segments

![](rootFinding.gif?raw=true)

