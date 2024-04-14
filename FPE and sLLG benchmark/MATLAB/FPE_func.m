%% complete FPE formulation
function  [u]=FPE_func(delt,NNTAU,NTT,NXX)
    global is h Delta  m norm
    Delta=delt;
    is =0;
    h = 0;
    m = 0;
    NX=NXX;
    NT=NTT;
    NTAU=NNTAU;
    x = linspace(-1,1,NX);
    xx=linspace(0,1,round(NX/2));
    norm=trapz(xx,exp(-1e5*Delta*(1-xx.^2)));
    t = linspace(0,NTAU,NT);
    sol = pdepe(m,@fpe_pde,@fpe_ic,@fpe_bc,x,t);
    u = sol(:,:,1);


%% time-dependent FPE formulation to track mz
function [c,f,s] = fpe_pde(x,~,u,DuDx)
    global is h Delta 
    c = 1;
    f = ((is-h-x)*(1-x^2)*u+(1-x^2)/2/Delta*DuDx);
    s = 0;


%% boundary conditions ensure magnetization always remains in +-1
function [pl,ql,pr,qr] = fpe_bc(xl,ul,xr,ur,t)
    global is h Delta;
    ql=1;
    qr=1;
    pl=0;
    pr=0;


%% normalization with initial distribution, in this case all magnets start from -1. 
function u0 = fpe_ic(x)
    global Delta norm
    u0 =exp(-1e5*Delta*(1-x.^2)).*(1-heaviside(x))/norm;



