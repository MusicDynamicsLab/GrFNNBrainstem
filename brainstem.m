%% brainstem
%  Brainstem model
%  This is a 4-layer model of the auditory brainstem, built from the
%  2-layer cochlear model. There is no plotting or stimulus creation in
%  this script because those are done in the related FFR model scripts, but
%  they can simply be added here as well. 

a  = [-412  0      0    0];
b1 = [0     -40000   0    0];
b2 = [0     -160e3 -100 -100];
e  = [0     .04    .65  .65];

display=20;
osc=[50 750 200];

%% Make short cochlea network
nbm = networkMake(1, 'hopf', a(1), b1(1), b2(1), 0, 0, e(1),'log', osc(1), osc(2), osc(3), 'channel', 1, 'display', display, 'save', 1, 'zna', 0);
nbm.w=1;
nbm.a=real(nbm.a)./nbm.f+1i*imag(nbm.a);
noc = networkMake(2, 'hopf', a(2), b1(2), b2(2), 0, 0, e(2), 'log', osc(1), osc(2), osc(3), 'display', display, 'save', 1, 'zna', 0);

noc.a=real(noc.a)./noc.f+1i*imag(noc.a);
noc.b1=noc.b1./noc.f;noc.b2=noc.b2./noc.f;

%% Make CN and IC networks
ncn = networkMake(3, 'hopf', a(3), b1(3), b2(3), 0, 0, e(3),'log', osc(1), osc(2), osc(3),'display', display, 'save', 1, 'zna', 0);
nic = networkMake(4, 'hopf', a(4), b1(4), b2(4), 0, 0, e(4),'log', osc(1), osc(2), osc(3),'display', display, 'save', 1, 'zna', 0);

%% Add BM->OC connections
bm2oc = connectMake(nbm, noc, 'one', 1);
noc   = connectAdd(nbm, noc, bm2oc, 'weight',198000,'type','1freq');

%% Add brainstem connections
% oc2cn  = connectMake(noc, ncn, 'full',.005);
% cn2ic  = connectMake(ncn, nic, 'full',.1);
oc2cn  = connectMake(noc, ncn, 'full',.01);
cn2ic  = connectMake(ncn, nic, 'full',.2);

ncn   = connectAdd(noc, ncn, oc2cn, 'weight', 1);
nic   = connectAdd(ncn, nic, cn2ic, 'weight', 1);

% ncn   = connectAdd(noc, ncn, oc2cn, 'weight', 1, 'type', 'all2freq');
% nic   = connectAdd(ncn, nic, cn2ic, 'weight', 1, 'type', 'all2freq');

%% Run the network


M = modelMake(@zdot, @cdot, s, nbm, noc, ncn, nic);

tic;
M = odeRK4fs(M,s);
clc; toc;
