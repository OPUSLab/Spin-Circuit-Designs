.subckt Exchange_Coupling thet1 ph1 thet2 ph2 H12x H12y H12z H21x H21y H21z  Ms='1000' Vol='16*1e-17'  dyy='-0.0168' dxx='0.0337' dzz='-0.0168' dxy='0' dxz='0' dyz='0'
********************************************************************************
* Created by Kerem Yunus Camsari
*****************************************************
* Full Exchange Tensor is 3x3 -  dij / Vol_j = dji / Vol_i
* A symmetric and traceless matrix
*
*            [dxx  dxy  dxz ]    [mx]_j
* Hex_{ij} = [dxy  dyy  dyz ]    [my]_j
*            [dxz  dyz  dzz ]_ij [mz]_j
*
* trace(dij)=0
*****************************************************************
* Note that this definition is different in Vinh Diep's prescription
* We are using z-y as the easy plane following Sun
* z : Easy axis
* x : Very Hard axis
* y : Hard axis
****************************************************************

****************************** SIMULATION PARAMETERS ***************************
.param K12='(Vol1+Vol2)*Jex/(Ms1*Vol1)'
.param K21='(Vol2+Vol1)*Jex/(Ms2*Vol2)'
********************************************************************************

********************************************************************************
E12X   H1x 0 vol='(K12*v(mx2))'
E12Y   H1y 0 vol='(K12*v(my2))'
E12Z   H1z 0 vol='(K12*v(mz2))'
E21X   H2x 0 vol='(K21*v(mx1))'
E21Y   H2y 0 vol='(K21*v(my1))'
E21Z   H2z 0 vol='(K21*v(mz1))'
.ends 

