********************************************************************************
* SPICE Netlist 
* Created by Kemal Selcuk
* June 2023
* Description: 
    * Probabilistic bit design using 3Transistor-1MTJ topology 
    * using Double-free-layer stochastic MTJ (DFM) with in-plane easy-axis low barrier magnets
    * usign 14 nm FinFETransitor model 
* Accompanying sub-blocks:
    * m_sLLG.sp - Magnetism properties of the magnet (provides m into system)
    * G_FMNM.sp - Spin transport model of the magnet (represents G of the magnet)
    * H_dipolar.sp - Dipolar field interactions of the magnet (provides H into system)
********************************************************************************
********************************************************************************
.lib './FETmodels' ptm14hp
.include G_FMNM.sp
.include m_sLLG.sp
.include H_dipolar.sp
.option lis_new=1
.option ingold=2
********************************************************************************

************************** DIPOLAR FIELD COEFFICIENTS **************************
* * Dipolars for 10nm diameter
.param diameter='10*1e-7'
.param d012='-0.0516051'
.param d034='-0.0516051'
.param d013='-0.025575a'
.param d014='-0.0180853'
.param d023='-0.0368238'
.param d024='-0.025575'

** for 20nm diameter
* .param diameter='20*1e-7'
* .param d012='-0.032517'
* .param d034='-0.032517'
* .param d013='-0.0213285'
* .param d014='-0.0176279'
* .param d023='-0.0262909'
* .param d024='-0.0213285'

** 50nm diameter
* .param diameter='50*1e-7'
* .param d012='-0.0157548'
* .param d034='-0.0157548'
* .param d013='-0.0123702'
* .param d014='-0.0111764'
* .param d023='-0.013964'
* .param d024='-0.0123702'

** 100nm diameter
* .param diameter='100*1e-7'
* .param d012='-0.00849951'
* .param d034='-0.00849951'
* .param d013='-0.00737833'
* .param d014='-0.00687844'
* .param d023='-0.00798347'
* .param d024='-0.00737833'

** 150nm diameter
* .param diameter='150*1e-7'
* .param d012='-0.00579424'
* .param d034='-0.00579424'
* .param d013='-0.00529458'
* .param d014='-0.0050191'
* .param d023='-0.00558556'
* .param d024='-0.00529458'

** 200nm diameter
* .param diameter='200*1e-7'
* .param d012='-0.00438703'
* .param d034='-0.00438703'
* .param d013='-0.00412583'
* .param d014='-0.00396057'
* .param d023='-0.00428318'
* .param d024='-0.00412583'
********************************************************************************

****************************** SIMULATION PARAMETERS ***************************
.param dump='0'
.param eres='1e9'
.param Msp='800'
.param Hkp='1'
.param alphap='0.01'
.param th='1e-7'
.param D='diameter'
.param rad='D/2'
.param Volum='pi*rad^2*th'
.param gamma='1.76*1e7'
.param noiseSuppress='1e-5'
.param hd ='4*pi*Msp/Hkp'
** OR hd=0 -> PMA
.param TT='300'
.param kT='26*1e-3*1.6*1e-19*1e7*TT/300'
.param pi='3.141592653589793'
.param dipoff ='1' 
** OR dipoff = 0 when all dipolars fields are OFF
.param P_mgo='0.90'
.param ap='1'
.param RA_MgO='1'
** RAs are in units of ohm*um^2
.param areaum2= 'pi*(rad*(1e-2)*(1e6))^2' 
.param G0mgo= '2/(RA_MgO/areaum2)'
********************************************************************************
 
****************************** DF MAGNET BLOCK **********************************
** Interacting transport modules
X1_G_FM_NM vsup+ 2c 0 2z 0 2x 0 2y theta1  phi1 IsX1 IsY1 IsZ1  G_FM_NM g='G0mgo' P='P_mgo' a='ap'
+b='0' dum='dump' ers='eres'
X2_G_FM_NM output 2c 0 2z 0 2x 0 2y  theta2  phi2 IsX2 IsY2 IsZ2  G_FM_NM g='G0mgo' P='P_mgo' a='ap'
+b='0' dum='dump' ers='eres'
** Interacting dipolar field modules
XDipolarM  theta1 phi1 theta2 phi2 hx1 hy1 hz1 hx2 hy2 hz2 Magnetic_Coupling 
+ Ms='Msp' Vol='Volum' 
+ dyy='d023' dxx='-2*d023' dzz='d023' dxy='0' dxz='0' dyz='0' 
** Noise field definitions
GH2z hz1 0 noise='4*kT*alphap/(Msp*Volum*gamma)*1/noiseSuppress^2'
R2z  hz1 0 r='1'
GH2y hy1 0 noise='4*kT*alphap/(Msp*Volum*gamma)*1/noiseSuppress^2'
R2y  hy1 0 r='1'
GH2x hx1 0 noise='4*kT*alphap/(Msp*Volum*gamma)*1/noiseSuppress^2'
R2x  hx1 0 r='1'
GH3z hz2 0 noise='4*kT*alphap/(Msp*Volum*gamma)*1/noiseSuppress^2'
R3z  hz2 0 r='1'
GH3y hy2 0 noise='4*kT*alphap/(Msp*Volum*gamma)*1/noiseSuppress^2'
R3y  hy2 0 r='1'
GH3x hx2 0 noise='4*kT*alphap/(Msp*Volum*gamma)*1/noiseSuppress^2'
R3x  hx2 0 r='1'
** Interacting LLG modules
XLLGM1   theta1 phi1 IsX1 IsY1 IsZ1  hx1 hy1 hz1 llg_solver  hp='hd'
+ alpha='alphap' Hk='Hkp' Vol='Volum' Ms='Msp' ers='eres'
XLLGM2   theta2 phi2 IsX2 IsY2 IsZ2  hx2 hy2 hz2 llg_solver  hp='hd'
+ alpha='alphap' Hk='Hkp' Vol='Volum' Ms='Msp' ers='eres'
********************************************************************************

****************************** FinFET 3T BLOCK *********************************
X1 output input   vres vsup- nfet nfin=1
Ressorce vres vsup- r='1e-3'
X2 output2 output vsup- vsup- nfet nfin=1
X3 output2 output vsup+ vsup+ pfet nfin=1
VSUP+ vsup+ 0 'vdd/2'
VSUP- vsup- 0 '-vdd/2'
VINPUT input 0 pulse('-write/2' 'write/2' 0p trise 25p 'trise' '10*trise')
.param write=0.6
.param trise=500n
********************************************************************************

******************** INITIAL CONDITIONS AND MEASUREMENTS ***********************
.ic V(theta1)='pi/2-0.0436'
.ic V(phi1)='pi/2-0.0436'
.ic V(theta2)='pi/2-0.0436'
.ic V(phi2)='3*pi/2-0.0436'
.print v(input)  v(output) v(output2) v(theta1) v(theta2) v(phi1) v(phi2)
.tran 1p trise UIC 
.trannoise v(output) scale='noiseSuppress' seed=123
.end
