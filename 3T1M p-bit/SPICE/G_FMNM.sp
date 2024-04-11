.subckt G_FM_NM cFM cNM zFM zNM xFM xNM yFM yNM  THETA PHI isx isy isz g='1' a='1' b='0' dum='0' P='0.99' ers='1e9'
********************************************************************************
* Created by Kerem Yunus Camsari
* February 2015
* LAST UPDATED: 2023 - interface problems resolved with LLG and dipolar blocks
* LAST UPDATE by Kemal Selcuk
*****************************************************
*  4x4 Conductance Matrix for FM||NM Interface
*  Port Definition: Charge Terminals - to Spin Terminals THETA, PHI= Angle of magnet direction in Sph. Coord.
*  isX isY isZ    : Spin-Current flowing through the Shunt Conductances (Numerical value and NOT absolute value,
*  treated as parameter passing)
* See accompanying PDF: RotationMatricesForFMandFMNM to see details
********************************************************************************

****************************** FUNCTIONAL PARAMETERS ***************************
.param s1(x)='sin(x)'
.param c1(x)='cos(x)'
.param s2(x)='sin(x)*sin(x)'
.param c2(x)='cos(x)*cos(x)'
.param sc(x)='sin(x)*cos(x)'
********************************************************************************

*********** LUMPED ELEMENTS IMPLEMENTATIONS OF FM-NM TRANSPORT BLOCK ***********
GC11 cFM cNM cur='g*(v(cFM)-v(cNM))'
GC12 cFM cNM cur='(g*P*c1(v(THETA)))*(v(zFM)-v(zNM))'
GC13 cFM cNM cur='(g*P*s1(v(THETA))*c1(v(PHI)))*(v(xFM)-v(xNM))'
GC14 cFM cNM cur='(g*P*s1(v(THETA))*s1(v(PHI)))*(v(yFM)-v(yNM))'

GZ21 zFM zNM cur='(g*P*c1(v(THETA)))*(v(cFM)-v(cNM))'
GZ22 zFM zNM cur='(g*c2(v(THETA)) + dum*g*c2(v(PHI))*s2(v(THETA)) + dum*g*s2(v(THETA))*s2(v(PHI)))*(v(zFM)-v(zNM))'
GZ23 zFM zNM cur='(g*sc(v(THETA))*c1(v(PHI)) + dum*g*(1-c1(v(THETA)))*sc(v(PHI))*s1(v(THETA))*s1(v(PHI)) - dum*g*c1(v(PHI))*s1(v(THETA))*(c1(v(THETA))+s2(v(PHI))*(1-c1(v(THETA)))))*(v(xFM)-v(xNM))'
GZ24 zFM zNM cur='(g*sc(v(THETA))*s1(v(PHI)) + dum*g*(1-c1(v(THETA)))*c2(v(PHI))*s1(v(THETA))*s1(v(PHI)) - dum*g*s1(v(THETA))*s1(v(PHI))*(c1(v(THETA))+(1-c1(v(THETA))*c2(v(PHI)))))*(v(yFM)-v(yNM))'

GX31 xFM xNM cur='(g*P*s1(v(THETA))*c1(v(PHI)))*(v(cFM)-v(cNM))'
GX32 xFM xNM cur='(g*sc(v(THETA))*c1(v(PHI)) + dum*g*(1-c1(v(THETA)))*c1(v(PHI))*s1(v(THETA))*s2(v(PHI)) - dum*g*c1(v(PHI))*s1(v(THETA))*(c1(v(THETA))+(1-c1(v(THETA)))*s2(v(PHI))))*(v(zFM)-v(zNM))'
GX33 xFM xNM cur='(g*s2(v(THETA))*c2(v(PHI)) + dum*g*(1-c1(v(THETA)))*(1-c1(v(THETA)))*c2(v(PHI))*s2(v(PHI)) + dum*g*(c1(v(THETA))+(1-c1(v(THETA)))*s2(v(PHI)))*(c1(v(THETA))+(1-c1(v(THETA)))*s2(v(PHI))))*(v(xFM)-v(xNM))'
GX34 xFM xNM cur='(g*s2(v(THETA))*sc(v(PHI)) - dum*g*(1-c1(v(THETA)))*c1(v(PHI))*(c1(v(THETA))+(1-c1(v(THETA)))*c2(v(PHI)))*s1(v(PHI)) - dum*g*(1-c1(v(THETA)))*sc(v(PHI))*(c1(v(THETA))+(1-c1(v(THETA)))*s2(v(PHI))))*(v(yFM)-v(yNM))'

GY41 yFM yNM cur='(g*P*s1(v(THETA))*s1(v(PHI)))*(v(cFM)-v(cNM))'
GY42 yFM yNM cur='(g*sc(v(THETA))*s1(v(PHI)) + dum*g*(1-c1(v(THETA)))*c2(v(PHI))*s1(v(THETA))*s1(v(PHI)) - dum*g*(c1(v(THETA))+(1-c1(v(THETA)))*c2(v(PHI)))*s1(v(THETA))*s1(v(PHI)))*(v(zFM)-v(zNM))'
GY43 yFM yNM cur='(g*s2(v(THETA))*sc(v(PHI)) - dum*g*(1-c1(v(THETA)))*c1(v(PHI))*(c1(v(THETA))+(1-c1(v(THETA)))*c2(v(PHI)))*s1(v(PHI)) - dum*g*(1-c1(v(THETA)))*sc(v(PHI))*(c1(v(THETA))+(1-c1(v(THETA)))*s2(v(PHI))))*(v(xFM)-v(xNM))'
GY44 yFM yNM cur='(g*s2(v(THETA))*s2(v(PHI)) + dum*g*(c1(v(THETA))+(1-c1(v(THETA)))*c2(v(PHI)))*(c1(v(THETA))+(1-c1(v(THETA)))*c2(v(PHI))) + dum*g*(1-c1(v(THETA)))*(1-c1(v(THETA)))*c2(v(PHI))*s2(v(PHI)))*(v(yFM)-v(yNM))'

GZ55 zNM zNMz cur='(g*a*s2(v(THETA)))*(v(zNM)-v(zNMz))'
GZ56 zNM zNMz cur='(-g*s1(v(THETA))*(a*c1(v(PHI))*c1(v(THETA))+b*s1(v(PHI))))*(v(xNM)-v(xNMx))'
GZ57 zNM zNMz cur='(-g*s1(v(THETA))*(a*s1(v(PHI))*c1(v(THETA))-b*c1(v(PHI))))*(v(yNM)-v(yNMy))'

GX65 xNM xNMx cur='(g*s1(v(THETA))*(-a*c1(v(PHI))*c1(v(THETA))+b*s1(v(PHI))))*(v(zNM)-v(zNMz))'
GX66 xNM xNMx cur='(g*a*( c2(v(PHI))*c2(v(THETA))+1-c2(v(PHI))))*(v(xNM)-v(xNMx))'
GX67 xNM xNMx cur='(g*(-a*sc(v(PHI))+a*sc(v(PHI))*c2(v(THETA))-b*c1(v(THETA))))*(v(yNM)-v(yNMy))'

GY75 yNM yNMy cur='(-g*s1(v(THETA))*(a*s1(v(PHI))*c1(v(THETA))+b*c1(v(PHI))))*(v(zNM)-v(zNMz))'
GY76 yNM yNMy cur='(g*(-a*sc(v(PHI))+a*sc(v(PHI))*c2(v(THETA))+b*c1(v(THETA))))*(v(xNM)-v(xNMx))'
GY77 yNM yNMy cur='(-g*a*(-c2(v(PHI))+c2(v(PHI))*c2(v(THETA))-c2(v(THETA))))*(v(yNM)-v(yNMy))'
********************************************************************************

** Reading the total spin-current X,Y,Z flowing through the interface shunt conductance.
VXX xNMx 0 0
VYY yNMy 0 0
VZZ zNMz 0 0
GZZ 0 isz CUR='i(VZZ)'
GXX 0 isx CUR='i(VXX)'
GYY 0 isy CUR='i(VYY)'
ReZZ isz 0 r='1'
ReXX isy 0 r='1'
ReYY isx 0 r='1'
.ends







