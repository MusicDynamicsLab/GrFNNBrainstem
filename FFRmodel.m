%% FFR model using alternating polarity

%% Choose a stimulus from Lee et al., 2009
F = dB2Pa(70); %  ~70 dB SPL as reported by Lee et al.

stim{1} = stimulusMake(1, 'wav', 'EGmono44100.wav');
stim{1}.fc = {99 166};
stim{1}.x = stim{1}.x * F / rms(stim{1}.x);

% stim{1} = stimulusMake(1, 'wav', 'EF#mono44100.wav');
% stim{1}.fc = {93 166};
% stim{1}.x = stim{1}.x * F / rms(stim{1}.x);

%% Alternate the polarity for the second simulation
stim{2} = stim{1};
stim{2}.x = -stim{2}.x;

%% Set a few things that comparePolarity needs
times = 1; % Number of times to run stimulus, which will be averaged
fs = stim{1}.fs;
NFFT = fs*2;        % FFT length
plotFigures = 1;

%% Run the model for both polarities
% brainstemScript = 'brainstem';
brainstemScript = 'brainstemPaper';
comparePolarity;
figure;plot(f(1:ind),weightedEnv(1:ind),'linewidth',2);zoom xon;drawnow
