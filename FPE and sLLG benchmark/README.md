
# Fokker-Planck Equation vs stochastic LLG bechmarking
  
This _GitHub repository_ provides the Fokker-Planck Equation for benchmarking the mean z-positioning of the magnetism over time with respect to numerically solved stochastic LLG and theoretical analysis.

To benchmark our sLLG solver in HSPICE with FPE, we consider an ensemble of low-barrier nanomagnets all prepared in the -1 direction, which are then left to fluctuate on their own in the absence of any fields and currents. We perform 1000 independent (with identical parameters) sLLG simulations and numerically plot the average $m_z$ component as a function of time. Numerical data is provided in the code extracted from SPICE.



# Simulation Files
MATLAB files:
* ` FPE_func.m` : Defines the time-dependent Fokker-Planck Equation for t
* ` FPEvsLLG.m` : Main file for simulating FPE and comparing analytically and numerically with extracted SPICE data simulating stochastic Landau-Lifshitz-Gilbert (LLG) equations.



## Running the simulation
The script for simulating the FPE benchmarking is provided in MATLAB format.  
To execute the simulation, simply run the **FPEvsLLG.m** file located in the `MATLAB` directory. Simulation results will be stored in a **~.csv** extension file in column format, along with the respective plot.


