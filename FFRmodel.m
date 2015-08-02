%% FFR model using alternating polarity

%% Choose a stimulus from Lee et al., 2009
stim{1}=stimulusMake('wav','EGmono44100');
stim{1}.fc={99 166};
% stim{1}=stimulusMake('wav','EF#mono44100');
% stim{1}.fc={93 166};

%% Alternate the polarity for the second simulation
stim{2}=stim{1};
stim{2}.x=-stim{2}.x;

%% Set a few things that comparePolarity needs
times=1; % Number of times to run stimulus, which will be averaged
fs=stim{1}.fs;
NFFT=fs*2;        % FFT length
plotFigures=1;

%% Run the model for both polarities
comparePolarity;
