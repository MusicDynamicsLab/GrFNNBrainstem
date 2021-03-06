%% brainstem
%  Brainstem model
%  This is a 4-layer model of the auditory brainstem, built from the
%  2-layer cochlear model. There is no plotting or stimulus creation in
%  this script because those are done in the related FFR model scripts, but
%  they can simply be added here as well. 

a  = [-412  0      0     0    ];
b1 = [0     -40816 0     0    ];
b2 = [0     0      -1000 -1000];
d1 = [0     0      0     0    ];
d2 = [0     0      0     0    ];
e  = [0     0      0.50  0.50 ];

c21 = 197960;

display = 20;

oscCochlea   = [30 10000 397];
oscBrainstem = [50 750 397];

%% Make a cochlea network =====================================================
n1 = networkMake(1, 'hopf', a(1), b1(1), b2(1), d1(1), d2(1), e(1), ...
                    'log', oscCochlea(1), oscCochlea(2), oscCochlea(3),...
                    'display', display, 'save', 1, 'znaught', 0,...
                    'noScale');
                
n2 = networkMake(2, 'hopf', a(2), b1(2), b2(2), d1(2), d2(2), e(2), ...
                    'log', oscCochlea(1), oscCochlea(2), oscCochlea(3),...
                    'display', display, 'save', 1, 'znaught', 0,...
                    'noScale');

%% Make a brainstem network ===================================================
n3 = networkMake(3, 'hopf', a(3), b1(3), b2(3), d1(3), d2(3), e(3),...
                    'log', oscBrainstem(1), oscBrainstem(2),...
                     oscBrainstem(3), 'display', display, 'save', 1,...
                     'znaught', 0);
n4 = networkMake(4, 'hopf', a(4), b1(4), b2(4), d1(4), d2(4), e(4),...
                    'log', oscBrainstem(1), oscBrainstem(2),...
                     oscBrainstem(3), 'display', display, 'save', 1,...
                     'znaught', 0);

%% Make a stimulus ============================================================
% Make a stimulus here and add it, or just add it if already in workspace

n1 = connectAdd(s, n1, 1, 'noScale');

%% Add connections from bm to oc
bm2oc = diag(c21 * n2.f);

n2    = connectAdd(n1, n2, bm2oc, 'type', '1freq', 'noScale');

%% Add brainstem connections
oc2cn  = connectMake(n2, n3, 'full', .1);
cn2ic  = connectMake(n3, n4, 'full', .03);

n3   = connectAdd(n2, n3, oc2cn);
n4   = connectAdd(n3, n4, cn2ic);

%% Run the network
M = modelMake(@zdot, @cdot, s, n1, n2, n3, n4);

tic;
M = odeRK4fs(M);
toc;
