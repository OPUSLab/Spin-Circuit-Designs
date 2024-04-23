.subckt G_FM_NM cFM cNM zFM zzNM xFM xxNM yFM yyNM  THETA PHI isx isy isz g='1' a='1' b='0' dum='0'
+P='0.1' ers='1e9'
*  4x4 Conductance Matrix for FM||NM Interface
*  Port Definition: Charge Terminals - to Spin Terminals THETA, PHI= Angle of magnet direction in Sph. Coord.
*  isX isY isZ    : Spin-Current flowing through the Shunt Conductances (Numerical value and not absolute value,
*  treated as parameter passing)
*
*
*
*


.param s1(x)='sin(x)'
.param c1(x)='cos(x)'
.param s2(x)='sin(x)*sin(x)'
.param c2(x)='cos(x)*cos(x)'
.param sc(x)='sin(x)*cos(x)'


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

* 4x4 Conductance Matrix for the Shunt Component
* First column is zero: No charge current through spin-shunts
* First row is also zero: Through reciprocity

GZ55 zNM 0 cur='(g*a*s2(v(THETA)))*(v(zNM))'
GZ56 zNM 0 cur='(-g*s1(v(THETA))*(a*c1(v(PHI))*c1(v(THETA))+b*s1(v(PHI))))*(v(xNM))'
GZ57 zNM 0 cur='(-g*s1(v(THETA))*(a*s1(v(PHI))*c1(v(THETA))-b*c1(v(PHI))))*(v(yNM))'

GX65 xNM 0 cur='(g*s1(v(THETA))*(-a*c1(v(PHI))*c1(v(THETA))+b*s1(v(PHI))))*(v(zNM))'
GX66 xNM 0 cur='(g*a*( c2(v(PHI))*c2(v(THETA))+1-c2(v(PHI))))*(v(xNM))'
GX67 xNM 0 cur='(g*(-a*sc(v(PHI))+a*sc(v(PHI))*c2(v(THETA))-b*c1(v(THETA))))*(v(yNM))'

GY75 yNM 0 cur='(-g*s1(v(THETA))*(a*s1(v(PHI))*c1(v(THETA))+b*c1(v(PHI))))*(v(zNM))'
GY76 yNM 0 cur='(g*(-a*sc(v(PHI))+a*sc(v(PHI))*c2(v(THETA))+b*c1(v(THETA))))*(v(xNM))'
GY77 yNM 0 cur='(-g*a*(-c2(v(PHI))+c2(v(PHI))*c2(v(THETA))-c2(v(THETA))))*(v(yNM))'


VXX xxNM xNM 0
VYY yyNM yNM 0
VZZ zzNM zNM 0

GZZ 0 isz cur='i(VZZ)'
GXX 0 isx cur='i(VXX)'
GYY 0 isy cur='i(VYY)'

ReZZ isz 0 r='1'
ReXX isy 0 r='1'
ReYY isx 0 r='1'


.ends







