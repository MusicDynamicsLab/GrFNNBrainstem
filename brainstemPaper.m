%% brainstem
%  Brainstem model
%  This is a 4-layer model of the auditory brainstem, built from the
%  2-layer cochlear model. There is no plotting or stimulus creation in
%  this script because those are done in the related FFR model scripts, but
%  they can simply be added here as well. 

a  = [-0.1  0      0     0    ];
b1 = [0     -10000 0     0    ];
b2 = [0     -1     -1000 -1000];
d1 = [0     0      0     0    ];
d2 = [0     0      0     0    ];
e  = [0     0.0025 0.48  0.48 ];

display = 20;

oscCochlea    = [64 1024 397];
oscBrainstem = [64 1024 397];

%% Make a cochlea network =====================================================
n1 = networkMake(1, 'hopf', a(1), b1(1), b2(1), d1(1), d2(1), e(1), ...
                    'log', oscCochlea(1), oscCochlea(2), oscCochlea(3),...
                    'display', display, 'save', 1, 'znaught', 0);
                
n2 = networkMake(2, 'hopf', a(2), b1(2), b2(2), d1(2), d2(2), e(2), ...
                    'log', oscCochlea(1), oscCochlea(2), oscCochlea(3),...
                    'display', display, 'save', 1, 'znaught', 0);

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
% Make a stimulus here, or just add it if already in workspace

n1 = connectAdd(s, n1, 1);

%% Add connections from bm to oc
n2    = connectAdd(n1, n2, eye(n1.N), 'type', '1freq');

%% Add brainstem connections
oc2cn  = connectMake(n2, n3, 'full', .5);
cn2ic  = connectMake(n3, n4, 'full', .125);

n3   = connectAdd(n2, n3, oc2cn);
n4   = connectAdd(n3, n4, cn2ic);

%% Run the network
M = modelMake(@zdot, @cdot, s, n1, n2, n3, n4);

tic;
M = odeRK4fs(M);
toc;
