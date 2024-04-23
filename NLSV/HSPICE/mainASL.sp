*********************************************** Load Files *********************************************** 

.include LLG.sp
.include G_FM_NM.sp
.include G_NM.sp

*********************************************** Physical Parameters *********************************************** 


*********** Phycial Constant [mks unit] *********** 

.param pi='3.1416' q='1.6*1e-19' hplanck='6.626*1e-34' hbar='hplanck/2/pi'

*********** NM Parameters [mks unit] ***********

.param L_ch = '200*1e-9'
.param L_s = '200*1e-9'
.param Lambda_s = '400*1e-9'
.param tchan='65*1e-9' AreaChan='170*1e-9*tchan'
.param rhoCu='2.35*1e-8'

*********** FM_NM Parameters [cgs unit] ***********

.param Ms='1100'
.param Vol='(30*30*2)*1e-21' 
.param Hk='1'
.param hd='0'
.param Gamma='17.6*1e6'
.param alpha='0.01'
.param G = '1'
.param a_real = '1'
.param b_imaginary='0'
.param Polarization ='0.1'

*********** Noise parameters ***********

.param noiseSuppress='1e-10'
.param TT=300
.param kT='26*1e-3*1.6*1e-19*1e7*TT/300'



*********************************************** Transport Models ***************************************************


XNM1   4c 0  4z 0  4x 0 4y 0 G_NM Area='AreaChan' rho='rhoCu' L='L_s' lsf='Lambda_s'
XNM2   4c 5c 4z 5z 4x 5x 4y 5y G_NM Area='AreaChan' rho='rhoCu' L='L_ch' lsf='Lambda_s'
XNM3   5c 0 5z 0  5x 0 5y 0 G_NM Area='AreaChan' rho='rhoCu' L='L_s' lsf='Lambda_s'
XNM4   4c 6c 4z 6z  4x 6x 4y 6y G_NM Area='AreaChan' rho='rhoCu' L='L_s' lsf='Lambda_s'
XNM5   5c 6c 5z 6z  5x 6x 5y 6y G_NM Area='AreaChan' rho='rhoCu' L='L_s' lsf='Lambda_s'
XNM6   6c 0 6z 0  6x 0 6y 0 G_NM Area='AreaChan' rho='rhoCu' L='L_s' lsf='Lambda_s'


XFM_NM1 input1 4c 1z 4z 1x 4x 1y 4y THETA1 PHI1 isx1 isy1 isz1 G_FM_NM g='G' a='a_real' b='b_imaginary' P='Polarization'
XFM_NM2 input2 5c 8z 5z 8x 5x 8y 5y THETA2 PHI2 isx2 isy2 isz2 G_FM_NM g='G' a='a_real' b='b_imaginary' P='Polarization'
XFM_NM3 input3 6c 12z 6z 12x 6x 12y 6y THETA3 PHI3 isx3 isy3 isz3 G_FM_NM g='G' a='a_real' b='b_imaginary' P='Polarization'

*********************************************** Stochastic Landau–Lifshitz–Gilbert Modules ***************************************************

XLLG1   THETA1 PHI1 isx1 isy1 isz1 hx1 hy1 hz1 llg_solver hp='hd' alpha='alpha' Hk='Hk' Vol='Vol' Ms='Ms'
XLLG2   THETA2 PHI2 isx2 isy2 isz2 hx2 hy2 hz2 llg_solver hp='hd' alpha='alpha' Hk='Hk' Vol='Vol' Ms='Ms'
XLLG3   THETA3 PHI3 isx3 isy3 isz3 hx3 hy3 hz3 llg_solver  hp='hd' alpha='alpha' Hk='Hk' Vol='Vol' Ms='Ms'

*************************************************** Noise Sources ***************************************************

* Sweep Free - Hold Assist
* Measure Free
* 1 is assist

GH1z hz1 0 noise='4*kT*alpha/(Ms*Vol*gamma)*1/noiseSuppress^2'
R1z  hz1 0 r='1'

GH1y hy1 0 noise='4*kT*alpha/(Ms*Vol*gamma)*1/noiseSuppress^2'
R1y  hy1 0 r='1'

GH1x hx1 0 noise='4*kT*alpha/(Ms*Vol*gamma)*1/noiseSuppress^2'
R1x  hx1 0 r='1'

GH2z hz2 0 noise='4*kT*alpha/(Ms*Vol*gamma)*1/noiseSuppress^2'
R2z  hz2 0 r='1'

GH2y hy2 0 noise='4*kT*alpha/(Ms*Vol*gamma)*1/noiseSuppress^2'
R2y  hy2 0 r='1'

GH2x hx2 0 noise='4*kT*alpha/(Ms*Vol*gamma)*1/noiseSuppress^2'
R2x  hx2 0 r='1'

GH3z hz3 0 noise='4*kT*alpha/(Ms*Vol*gamma)*1/noiseSuppress^2'
R3z  hz3 0 r='1'

GH3y hy3 0 noise='4*kT*alpha/(Ms*Vol*gamma)*1/noiseSuppress^2'
R3y  hy3 0 r='1'

GH3x hx3 0 noise='4*kT*alpha/(Ms*Vol*gamma)*1/noiseSuppress^2'
R3x  hx3 0 r='1'


*************************************************** Magnets Intial Conditions ***************************************************

.ic V(THETA1)='3.14'
.ic V(PHI1)='0.0'

.ic V(THETA2)='1.57'
.ic V(PHI2)='1.57'

.ic V(THETA3)='1.57'
.ic V(PHI3)='0'


*************************************************** Input: Chrage Current ***************************************************
*Note the direction of current is from  GROUND  to node input1/input2/input3 

* You only need to change this paramater to change the input current
.param InputCurrent='150u'
 
I1c  input1 0 -InputCurrent
V1z  0 1z 0
V1x  0 1x 0 
V1y  0 1y 0 

I2c  input2 0 -InputCurrent
V2z  0 8z 0
V2x  0 8x 0 
V2y  0 8y 0 

I3c  input3 0 -InputCurrent
V3z  0 12z 0
V3x  0 12x 0 
V3y  0 12y 0 
*************************************************** Saved Nodes ***************************************************

.print v(theta1) v(theta2) v(theta3) v(phi1) v(phi2) v(phi3) v(input1) v(input2) v(input3) v(isx1) v(isy1) v(isz1) v(isx2) v(isy2) v(isz2) v(isx3) v(isy3) v(isz3) i(i1c) i(i2c) i(i3c) 


*************************************************** Simulation Settings *************************************************** 

.option  probe ingold=2
.option post=1 probe=0
.option lis_new=0
.param end='100u'
.tran 10p end UIC 
.trannoise v(hz1) seed=12345 scale='noiseSuppress'
.end
