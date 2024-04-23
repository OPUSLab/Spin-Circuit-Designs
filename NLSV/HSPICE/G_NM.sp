* Library module for Normal Metal (NM) 
*************************


.subckt G_NM t1c t2c t1z t2z t1x t2x t1y t2y  Area='1.1e-14' L='200e-9' rho='2.35*1e-8' lsf='400e-9'


* Internal parameters
.param gcse='Area/(rho*L)'
.param gsse='gcse*(L/lsf)/sinh(L/lsf)'
.param gssh='gcse*(L/lsf)*tanh(L/(2*lsf))'

* Series t1-t2 
Rc12 t1c t2c r='1/gcse'
Rx12 t1x t2x r='1/gsse'
Ry12 t1y t2y r='1/gsse'
Rz12 t1z t2z r='1/gsse'

* Shunt for spin t1
Rx10 t1x 0 r='1/gssh'
Ry10 t1y 0 r='1/gssh'
Rz10 t1z 0 r='1/gssh'

* Shunt for spin t2
Rx20 t2x 0 r='1/gssh'
Ry20 t2y 0 r='1/gssh'
Rz20 t2z 0 r='1/gssh'

.ends

