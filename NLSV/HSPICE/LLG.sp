
.subckt llg_solver theta phi Isx Isy Isz HBx HBy HBz hp='0' alpha='0.01' Hk='1' Vol='(30*30*2)*1e-21' Ms='1100'

* C-I Implementation of LLG
* cgs units employed
* Ms = emu/cc
* Hk = Oersted
* Based on: Panagopoulos et. al. 2012, Framework for MTJ modeling
* Isx Isy Isz = Spin-Current Inputs in various directions (in Amperes)
* HBx HBy HBz  =  Magnetic Field in various directions  ( in Oersteds)



.param pi='3.14159265359'
.param gamma='1.76*1e7'
.param hbar='6.62*1e-34/2/pi'
.param q='1.6*1e-19'


.param s1(x)='sin(x)'
.param c1(x)='cos(x)'
.param c2(x)='cos(x)*cos(x)'

* Conversion factor for spin-current
.param conv='hbar/2/q*1e7/Ms/Vol/Hk'

C__THETA theta 0 c='(1+alpha*alpha)/(gamma*Hk)'


GTHETA_uniax 0 theta cur='-alpha*s1(v(theta))*c1(v(theta))'
GTHETA_demag 0 theta cur='-hp*(-s1(v(phi))+alpha*c1(v(theta))*c1(v(phi)))*s1(v(theta))*c1(v(phi))'
GTHETA_ext   0 theta cur='alpha*c1(v(theta))*s1(v(phi))*(v(HBy)/Hk)+c1(v(phi))*(v(HBy)/Hk)-s1(v(phi))*(v(HBx)/Hk)-alpha*s1(v(theta))*(v(HBz)/Hk)+alpha * c1(v(theta)) * c1(v(phi))*(v(HBx)/Hk)'
GTHETA_spin  0 theta cur='(conv*v(Isy))*c1(v(theta))*s1(v(phi))-alpha*(conv*v(Isy))*c1(v(phi))+(conv*v(Isx))*c1(v(theta))*c1(v(phi))+(conv*v(Isx))*s1(v(phi))*alpha-(conv*v(Isz))*sin(v(theta))'

C__PHI phi 0 c='(1+alpha*alpha)/(gamma*Hk)'

GPHI_uniax 0 phi cur='cos(v(theta))'
GPHI_demag 0 phi cur='hp*(c2(v(phi))*c1(v(theta))+alpha*c1(v(phi))*s1(v(phi)))'
GPHI_ext   0 phi cur='(v(HBz)/Hk) +(-alpha*(v(HBx)/Hk)*s1(v(phi)) - (v(HBx)/Hk)*c1(v(theta))*c1(v(phi)))/s1(v(theta))+ ( alpha*(v(HBy)/Hk)*c1(v(phi))- (v(HBy)/Hk)*c1(v(theta))*s1(v(phi)))/s1(v(theta))'

GPHI_spin  0 phi cur='-(conv*v(Isz))*alpha + (alpha*(conv*v(Isy))*c1(v(theta))*s1(v(phi))+(conv*v(Isy))*c1(v(phi)))/sin(v(theta))+(alpha*(conv*v(Isx))*c1(v(theta))*cos(v(phi))-(conv*v(Isx))*sin(v(phi)))/sin(v(theta))'
.ends


