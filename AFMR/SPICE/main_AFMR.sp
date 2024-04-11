********************************************************************************
* SPICE Netlist 
* Created by Kerem Yunus Camsari
* Description: 
    * Antiferromagnet design using LLG and exchnage modules
    * for resonance meausurement
* Accompanying sub-blocks:
    * m_LLG.sp - Magnetism properties of the magnet (provides m into system)
    * H_exchange.sp - Exchange field interactions of the magnet (provides H into system)
********************************************************************************
********************************************************************************
.include 'm_LLG.sp'
.include 'H_exchange.sp'
.option post probe
.option accurate
.option ingold=2
.option measfile=1
.option measform=3
********************************************************************************

****************************** SIMULATION PARAMETERS ***************************
*Magnet Parameters in cgs
.param pi='3.141'
.param vol_a= '20*20*2*1e-21'
.param ms_a = '100'
.param vol_f= '20*20*2*1e-21'
.param ms_f = '100'
.param Hka  = '0.82*1e2'
.param Hkf  = '0.82*1e2'
.param hp = '0'
.param Jex='-(Hkf*ms_f/2)*64'
.param freq_rf=1e9
********************************************************************************

****************************** ANTIFERROMAGNET BLOCK **********************************
** Interacting LLG modules
XLLG1 theta_a phi_a  0 0 0  hax hay haz llg_solver hp='hp' alpha='0.01'
+ Hk='Hka' Vol='vol_a' Ms='ms_a'
XLLG2 theta_f phi_f  0 0 0  hfx hfy hfz llg_solver hp='hp' alpha='0.01'
+ Hk='Hkf' Vol='vol_f' Ms='ms_f'
** Interacting exchange field modules
XExchange mxA myA mzA mxF myF mzF hxF hyF hzF hxA hyA hzA Exchange_Coupling Ms1='ms_a'
+ Vol1='vol_a' Ms2='ms_f' Vol2='vol_f' Jex='Jex'
** Gathering all the fields
EXA hax 0 vol='v(hbx)+v(hrfx)+v(hxF)'
EYA hay 0 vol='v(hby)+v(hrfy)+v(hyF)'
EZA haz 0 vol='v(hbz)+v(hrfz)+v(hzF)'
EXF hfx 0 vol='v(hbx)+v(hrfx)+v(hxA)'
EYF hfy 0 vol='v(hby)+v(hrfy)+v(hyA)'
EZF hfz 0 vol='v(hbz)+v(hrfz)+v(hzA)'
** Spherical to cartesian coordinate transformation 
EC1 mxA 0 vol='sin(v(theta_a))*cos(v(phi_a))'
EC2 myA 0 vol='sin(v(theta_a))*sin(v(phi_a))'
EC3 mzA 0 vol='cos(v(theta_a))'
EC4 mxF 0 vol='sin(v(theta_f))*cos(v(phi_f))'
EC5 myF 0 vol='sin(v(theta_f))*sin(v(phi_f))'
EC6 mzF 0 vol='cos(v(theta_f))'
********************************************************************************

****************************** AC AND DC FIELDS **********************************
** DC field definitions
VHBX hbx 0 '1'
VHBY hby 0 '1'
* DC-field range for before the spin-flop region
VHBZ hbz 0 pulse(0 800 0 trise 200n 200n 400n) 
* DC-field range for during the spin-flop region
* VHBZ hbz 0 pulse(0 1500 0 trise 200n 200n 400n) 
* DC-field range for after the spin-flop region
* VHBZ hbz 0 pulse(1500 2000 0 trise 200n 200n 400n) 

** AC field definitions
VrfZ hrfz 0  sin(0 0  freq_rf  0 0 0)
VrfX hrfx 0  sin(0 0  freq_rf 0 0 0)
VrfY hrfy 0  sin(0 10 freq_rf  0 0 0)
********************************************************************************



******************** INITIAL CONDITIONS AND MEASUREMENTS ***********************
.ic v(theta_a)='pi-0.01'
.ic v(phi_a)='pi/2'
.ic v(theta_f)='0.01'
.ic v(phi_f)='pi/2'
.param trise=500n
* Transient measurement range for before and during the spin-flop region
.tran 1p trise UIC sweep freq_rf 1e9 4.5e9 0.5e9
* Transient measurement range for after the spin-flop region
* .tran 1p trise UIC sweep freq_rf 3.5e9 5e9 0.5e9
.print tran v(mzA) v(mzF) v(hbz)
.meas tran tm min v(mzF) FROM='trise/20' TO='trise'
.meas tran tr when v(mzF)='tm' FROM='trise/20' TO='trise'
.meas tran hr find v(hbz) at=tr
.end
