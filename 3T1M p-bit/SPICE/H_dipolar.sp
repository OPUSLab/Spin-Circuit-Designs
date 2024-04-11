.subckt Magnetic_Coupling thet1 ph1 thet2 ph2 H12x H12y H12z H21x H21y H21z  Ms='1000' Vol='16*1e-17'  dyy='-0.0168' dxx='0.0337' dzz='-0.0168' dxy='0' dxz='0' dyz='0'
********************************************************************************
* Created by Kerem Yunus Camsari
* LAST UPDATED: 2023
* LAST UPDATE by Kemal Selcuk
*****************************************************
* Full Dipolar Tensor is 3x3 -  dij / Vol_j = dji / Vol_i
* A symmetric and traceless matrix
*
*       [dxx  dxy  dxz ]    [mx]_j
* dij = [dxy  dyy  dyz ]    [my]_j
*       [dxz  dyz  dzz ]_ij [mz]_j
*
* trace(dij)=0
* 5 independent variables
*****************************************************************
* Note that this definition is different in Vinh Diep's prescription
* We are using z-y as the easy plane following Sun
* z : Easy axis
* x : Very Hard axis
* y : Hard axis
*********************************************************
* Default Values are defined for :
* Magnet1  =  Top  (Free layer) (smaller)
* Magnet2  =  Bottom ( Fixed layer) (larger)
* The d's that are provided are for the following magnet configuration
*  Magnet 1  = 50 nm  in easy axis  (z)
*            = 50 nm  in hard axis  (x)
*            =  2  nm  in very hard axis (y)
*  Magnet 2  = 50 nm in easy axis (z)
*            = 50 nm in hard axis (x)
*            = 2  nm in very hard axis (y)
*  Edge-to-edge separation of magnets =  5 nm
********************************************************************************

****************************** SIMULATION PARAMETERS ***************************
* Oersted Conversion:
* Ms is provided in emu/cc
* 1 Oe * (4*pi) = emu/cc
.param pi='3.141592653589793'
.param MMs='Ms*4*pi'
.param ratio='Ms*Vol/(Ms*Vol)'
.param dFxx= 'dxx*(ratio)'
.param dFyy= 'dyy*(ratio)'
.param dFzz= 'dzz*(ratio)'
.param dFxy= 'dxy*(ratio)'
.param dFxz= 'dxz*(ratio)'
.param dFyz= 'dyz*(ratio)'
********************************************************************************

********************************************************************************
Emgx1 mx1 0 vol= '(sin(v(thet1))*cos(v(ph1)))'
Emgy1 my1 0 vol= '(sin(v(thet1))*sin(v(ph1)))'
Emgz1 mz1 0 vol= '(cos(v(thet1)))'
Emgx2 mx2 0 vol= '(sin(v(thet2))*cos(v(ph2)))'
Emgy2 my2 0 vol= '(sin(v(thet2))*sin(v(ph2)))'
Emgz2 mz2 0 vol= '(cos(v(thet2)))'
** Respective fields between magnet1 and magnet2
G12X  0 H12x cur='MMs*(dxx*v(mx2) + dxy*v(my2) + dxz*v(mz2))'
G12Y  0 H12y cur='MMs*(dxy*v(mx2) + dyy*v(my2) + dyz*v(mz2))'
G12Z  0 H12z cur='MMs*(dxz*v(mx2) + dyz*v(my2) + dzz*v(mz2))'
G21X  0 H21x cur='MMs*(dFxx*v(mx1) + dFxy*v(my1) + dFxz*v(mz1))'
G21Y  0 H21y cur='MMs*(dFxy*v(mx1) + dFyy*v(my1) + dFyz*v(mz1))'
G21Z  0 H21z cur='MMs*(dFxz*v(mx1) + dFyz*v(my1) + dFzz*v(mz1))'
.ends

