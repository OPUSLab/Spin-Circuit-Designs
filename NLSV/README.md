# Engineered Antiferromagnets with Non-Local Spin Valves

This *GitHub repository* provides the SPICE code used for emulating Non-Local Spin **Valves (NLSV) with Low-Barrier Nanomagnets (LBM)**. Simulation files are provided for an example of a 3-LBM system. For more details about this device, please refer to: [*Heisenberg machines with programmable spin-circuits*](https://arxiv.org/abs/2312.01477)


# Simulation Files
HSPICE Files:
 - <code>Main.sp</code>: Main file used to simulate the 3-LBM system by calling the sub circuits (LLG,NM,FM_NM).
 - <code>LLG.sp</code>: Landau-Lifshitz-Gilbert (LLG) Module.
 - <code>NM.sp</code>: Normal Metal (NM) Module.
 - <code>FM_NM.sp</code>: Interface Module describing the spin transport in a magnet, utilizing the dynamics at the interface between a ferromagnet and a normal metal.


## How to run the simulation
<div align="justify">
The codes are written using the standard circuit simulator HSPICE, to run the simulation you only need to run the <b>Main.sp</b> file in the <code>HSPICE</code> directory. The simulation results are saved in <b>Main.printtr0</b> in columns format, with the current parameters, the output file would be around 2 GB.
</div>

# Used Parameters

| Parameter                                         | Value               | Unit         |
|---------------------------------------------------|---------------------|--------------|
| Interface polarization (P)                        | 0.1                 | --           |
| Gilbert damping coefficient (α)                   | 0.01                | --           |
| Saturation magnetization (M<sub>s</sub>)          | 1100 × 10<sup>3</sup>  | A/m         |
| Magnet volume (Vol.)                              | (30 × 30 × 2)       | nm<sup>3</sup> |
| Interface conductance (G)                         | 1                   | S            |
| Spin-Mixing conductance real part (aG)            | 1                   | --           |
| Spin-Mixing Conductance Imaginary Part (bG)       | 0                   | --           |
| NM Spin-Diffusion Length (λ<sub>s</sub>)          | 400                 | nm           |
| NM Resistivity (ρ<sub>NM</sub>)                   | 2.35                | μΩ.cm        |
| NM Length (L = L<sub>s</sub> = L<sub>ch</sub>)    | 200                 | nm           |
| NM Area (A<sub>NM</sub>)                          | 1.11 × 10<sup>-14</sup> | m<sup>2</sup> |
| Temperature                                       | 300                 | K            |
| Transient Time Step (SPICE)                       | 10                  | ps           |
