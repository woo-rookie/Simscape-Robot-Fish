Thank you all for a lovely few days in DC. All the Mapboxers I met and worked with were welcoming, candid, delightful, and generally inspiring. I was particularly impressed by the positive energy and powerful trust: I think this combination sustains a unique atmosphere of curiosity, enthusiasm, and collaborative support, which in turn powers Mapbox's impressive achievements. That was a long sentence, so I will try to illustrate it visually:


![](Gifs/a3.gif?raw=true)
# Simscape
Physics simulation using Simulink's [Simscape Multibody](https://www.mathworks.com/products/simmechanics.html).

## Acknowledgements
- Physical modelling performed within this codebase is based on the [Simscape simulation](https://github.com/mrl-hsl/Simulator) by MRL-HSL.

## Requirements
1. [MATLAB](https://mathworks.com/products/matlab.html) (tested with r2018A and r2019A)
2. [Simulink](https://mathworks.com/products/simulink.html)
3. [Simscape](https://mathworks.com/products/simscape.html) 
4. [Simscape Multibody](https://mathworks.com/products/simmechanics.html)

## Running Simulations
Ensure that the `src` folder and all subfolders are in MATLAB's search path and all relevant dependencies are installed.

### Static Simulation
This simulation will display physically-constrained, static poses of the robot, based on predefined joint positions. To run the static simulation, open the static Simulink Solution and run a script to assign joint positions.

    NUgus_static    % Opens the Simulink static simulation
    zombie          % Runs the "zombie" script and calls the static simulation

### Contact Simulation
This simulation models contact forces and friction to a free-body robot. This simulation is run in a similar way to the static simulation, opening the Simulink Solution and defining joint positions via a script. However, parameters to define the contact physics must be initialised.
    
    init            % Loads contact configuration parameters into the workspace
    NUgus_contact   % Opens Simulink contact simulation
    stand           % Runs the "stand" script to set robot pose and calls the static simulation
                    % To use this loaded pose, run the simulation with CTRL+T
   
### Servo Simulation
This simulation replaces the default Simscape Multibody revolute joints with Dynamixel MX64 and MX106 servo motors. This allows for the ~~real~~ simulation-time modification of the robot pose for each servo. 

    init            % Loads configuration for the contact forces, as well as initialising motor params
    NUgus_servo     % Opens Simulink servo simulation, run the simulation with CTRL+T or run button

The pose for the robot can be modified using the `Write to Servos` inputs seen in the Simulink solution window.
