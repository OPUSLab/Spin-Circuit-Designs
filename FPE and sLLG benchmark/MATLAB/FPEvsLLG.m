%% FPE vs sLLG 2024 
% Created by Kerem Yunus Camsari / Kemal Selcuk
clear all; clc; close all;

%%%%%%%%%%%%%%%%%%%%%%%%% SIMULATION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%
gamma =1.76*1e7;
q=1.6*1e-19;
hbar=6.62*1e-34/2/pi;
alpha=0.01;
Phi  = 30*1e-7;
thickness=2*1e-7;
Vol = (Phi)^2*thickness;
Ms =1100; %% emu /cc
Hk =1;
Ku = Hk*Ms/2;
KuV=Ku*Vol;   % ergs
muB=9.27*1e-21; % erg/Oe
NS=Ms*Vol/muB;
T=300;
kT=26*1e-3*1.6*1e-19*1e7/300*T; % ergs
Delta=KuV/kT;
step=1; % time step det. for FPE
time=(1:250)*step*1e-9;
timeS=[1:4 6:20]*step*1e-9;
timeS=[0 timeS];
time=[0 time];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%% Call to the FPE function  %%%%%%%%%%%%%%%%%%%%%%%
tau_o =1*(1+alpha^2)/gamma/Hk/alpha;
nx=500;
x=linspace(-1,1,nx);
ntau=max(time)/tau_o;
nt=200;
tfpe=linspace(0,ntau,nt)*tau_o;
[u]=FPE_func(Delta,ntau,nt,nx); % FPE function output in 
for ii=1:nt
  norm(ii)=trapz(x,u(ii,:)); % Calculate the L^2 norm for each time step
end
for ii=1:nt
  mzFPE(ii)=trapz(x,u(ii,:).*x)/norm(ii); % Calculate the mean z-position for each time step
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%% sLLG data extracted from SPICE %%%%%%%%%%%%%%%%%%%%%%%  
data=[0.2604166666666714, -0.9986949429037523
8.593750000000004, -0.934094616639478
18.22916666666667, -0.8812398042414358
28.90625, -0.8127243066884177
39.0625, -0.7579119086460033
49.47916666666667, -0.7030995106035889
68.22916666666666, -0.6110929853181077
62.23958333333333, -0.636541598694943
76.04166666666666, -0.571941272430669
82.55208333333333, -0.5425774877650897
91.66666666666666, -0.5112561174551385
97.65625, -0.49363784665579125
108.07291666666666, -0.45448613376835234
113.80208333333331, -0.43491027732463294
118.74999999999997, -0.41337683523654156
124.73958333333331, -0.3957585644371941
133.59374999999997, -0.36247960848287103
143.74999999999997, -0.3389885807504078
150.52083333333331, -0.3292006525285481
159.37499999999997, -0.3096247960848286
169.01041666666666, -0.2900489396411092
177.0833333333333, -0.2685154975530179
183.3333333333333, -0.2567699836867862
198.17708333333331, -0.2195758564437193
213.28124999999997, -0.19216965742251213
221.61458333333331, -0.18238172920065243];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%% Analytical formula for the benchmarking %%%%%%%%%%%%%%%%%
% ref. Hassan.et.al, 2019, "Low-barrier magnet design.."
tau=1/2/alpha/(gamma*kT/(Ms*Vol));
analytical=-exp(-tfpe/tau);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%% Plot FPE vs sLLG benchmarking %%%%%%%%%%%%%%%%%%%%% 
fig=figure(1);
set(fig,'defaulttextinterpreter','latex');
plot(tfpe/1e-9,mzFPE,':k','linewidth',2,'Markersize',15)  
hold on
plot(data(:,1),data(:,2),'s')
hold on
plot(tfpe/1e-9,analytical,'k','LineWidth',1)
xlim([0 max(tfpe)/10^-9])
xlabel('$\rm time \  (ns)$')
ylabel('$\langle m_z \rangle $') 
legend('FPE','sLLG','Analytical')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%% Export FPE vs sLLG benchmarking data %%%%%%%%%%%%%%%%%% 
tfpe_ns = tfpe / 1e-9; % Convert tfpe to nanoseconds
dataToExport = [tfpe_ns', mzFPE',analytical']; 
filename = 'FPEvsLLg.csv';
writematrix(dataToExport, filename);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            