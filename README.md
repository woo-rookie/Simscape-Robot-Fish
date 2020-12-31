

## Simscape Robot Fish
Robot fish/tailfin simulation using Simulink's Simscape multibody library.
Inspired by the MIT RoboTuna. See math.pdf for explanation of math involved. 

## Requirements
1. [MATLAB](https://mathworks.com/products/matlab.html) (r2019A)
2. [Simulink](https://mathworks.com/products/simulink.html)
3. [Simscape](https://mathworks.com/products/simscape.html) 
4. [Simscape Multibody](https://mathworks.com/products/simmechanics.html)

## Running Simulations
1) Open the source folder in MATLAB
2) Run params.m to populate Matlab workspace
3) (OPTIONAL) Edit waveform parameters (A,c1,c2,k,w) in lighthillCurve.m 
4) Open model.slx 
5) In "Simulation->Model Configuration Parameters" choose the "daessc (DAE solver for simscape)" solver with variable-step
6) Run model.slx 

## Simscape Renderings:

### Params: wave number = 0.5, frequency = 4 rad/s, c1 = 0.84, c2 = 5.49
![](Gifs/b2.gif?raw=true) 

### Params: wave number = 0.75, frequency = 10 rad/s, c1 = 0.84, c2 = 5.49
![](Gifs/b3.gif?raw=true) 

## Simulink Model Structure 

### Top-Level Structure
![](ModelPics/FullModel.png?raw=true)

### PD Controller
![](ModelPics/PDController.png?raw=true)

### Joint
![](ModelPics/Link&Joint.png?raw=true)


## Output Data


### Controller Torque 
![](Plots/u1.jpg?raw=true)
### Reference Angles
![](Plots/qd1.png?raw=true)


## rootFindingAnimation.py

Creates GIF of N-joint polyline fitted to lighthill curve using bisection method
The reference angles used in the simulation are the angles between adjacent line segments

![](rootFinding.gif?raw=true)

