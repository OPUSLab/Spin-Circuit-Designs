.subckt llg_solver theta phi Isx Isy Isz HBx HBy HBz hp='0' alpha='0.01' Hk='100' Vol='1e-17' Ms='1000' ers='1e9'
********************************************************************************
* Created by Kerem Yunus Camsari
* March 2015
* LAST UPDATED: July 2018 - precession sense is incorrect
* LAST UPDATE by Jan Kaiser / Orchi Hassan
* Accompanying codes:
* LLG_for_spice.mw---- Obsolete
* LLG_For_SPICE_MATHEMATICA.m 

* C-I Implementation of LLG
* cgs units employed
* Ms = emu/cc
* Hk = Oersted
* Based on: Panagopoulos et. al. 2012, Framework for MTJ modeling
* Isx Isy Isz = Spin-Current Inputs in various directions (in Amperes)
* HBx HBy HBz  =  Magnetic Field in various directions  ( in Oersteds)
********************************************************************************

****************************** SIMULATION PARAMETERS ***************************
.param pi='3.14159265359'
.param gamma='1.76*1e7'
.param hbar='6.62*1e-34/2/pi'
.param q='1.6*1e-19'
.param s1(x)='sin(x)'
.param c1(x)='cos(x)'
.param c2(x)='cos(x)*cos(x)'
* Conversion factor for spin-current
.param conv='hbar/2/q*1e7/Ms/Vol/Hk'
* Conversion when dimensionless currents applied -> .param conv='1' 
********************************************************************************

*************************** LLG Eq. IMPLEMENTATION *****************************
** Conversion factor for magnetic fields
EHSX hsx 0 vol='conv*v(Isx)'
EHSY hsy 0 vol='conv*v(Isy)'
EHSZ hsz 0 vol='conv*v(Isz)'
** Demag normalization of the field
EHX hx 0 vol='v(HBx)/Hk'
EHY hy 0 vol='v(HBy)/Hk'
EHZ hz 0 vol='v(HBz)/Hk'
** Theta components from LLG cylindrical coordinates
C__THETA theta 0 c='(1+alpha*alpha)/(gamma*Hk)'
GTHETA_uniax 0 theta cur='-alpha*s1(v(theta))*c1(v(theta))'
GTHETA_demag 0 theta cur='-hp*(-s1(v(phi))+alpha*c1(v(theta))*c1(v(phi)))*s1(v(theta))*c1(v(phi))'
GTHETA_ext   0 theta cur='alpha*c1(v(theta))*s1(v(phi))*v(hy)+c1(v(phi))*v(hy)-s1(v(phi))*v(hx)-alpha*s1(v(theta))*v(hz)+alpha * c1(v(theta)) * c1(v(phi))*v(hx)'
GTHETA_spin  0 theta cur='v(hsy)*c1(v(theta))*s1(v(phi))-alpha*v(hsy)*c1(v(phi))+v(hsx)*c1(v(theta))*c1(v(phi))+v(hsx)*s1(v(phi))*alpha-v(hsz)*sin(v(theta))'
** Phi components from LLG for cylindrical coordinates
C__PHI phi 0 c='(1+alpha*alpha)/(gamma*Hk)'
GPHI_uniax 0 phi cur='cos(v(theta))'
GPHI_demag 0 phi cur='hp*(c2(v(phi))*c1(v(theta))+alpha*c1(v(phi))*s1(v(phi)))'
GPHI_ext   0 phi cur='v(hz) +(-alpha*v(hx)*s1(v(phi)) - v(hx)*c1(v(theta))*c1(v(phi)))/s1(v(theta))+ ( alpha*v(hy)*c1(v(phi))- v(hy)*c1(v(theta))*s1(v(phi)))/s1(v(theta))'
GPHI_spin  0 phi cur='-v(hsz)*alpha + (alpha*v(hsy)*c1(v(theta))*s1(v(phi))+v(hsy)*c1(v(phi)))/sin(v(theta))+(alpha*v(hsx)*c1(v(theta))*cos(v(phi))-v(hsx)*sin(v(phi)))/sin(v(theta))'
.ends


