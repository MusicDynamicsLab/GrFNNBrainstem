weighted=(temp1/max(max(max(temp1)))+2*temp2/max(max(max(temp2)))+temp3/max(max(max(temp3))))/4;

weightedEnvTemp =absSpec((sum(weighted(:,1,:),3)/times + sum(weighted(:,2,:),3)/times),NFFT);
weightedFineTemp=absSpec((sum(weighted(:,1,:),3)/times - sum(weighted(:,2,:),3)/times),NFFT);

%% Load filter coefficients so as not to have a dependency on Sig Proc Toolbox
% [bbb,aaa]=butter(6,[150 3000]/floor(fs/2));
% [bbbb,aaaa]=butter(3,[10 450]/floor(fs/2));
load filterCoeffsFFR

filteredWeighted=filter(bbb,aaa,weighted);
filteredWeighted=filter(bbbb,aaaa,filteredWeighted);

modelEnv =sum(filteredWeighted(:,1,:),3)/times + sum(filteredWeighted(:,2,:),3)/times;
modelFine=sum(filteredWeighted(:,1,:),3)/times - sum(filteredWeighted(:,2,:),3)/times;

weightedEnv =absSpec(modelEnv,NFFT);
weightedFine=absSpec(modelFine,NFFT);



screen = get(0,'screensize');
screen(1:2) = screen(1:2) + 49;
screen(3) = screen(3) - 100;
screen(4) = screen(4) - 150;

%% Plotting and saving

if plotFigures
    
    
    figure(2);
    set(gcf,'position',screen)
    setappdata(gcf, 'SubplotDefaultAxesLocation', [.045 .07 .9 .85]);
    
    hand2=subplot(2,1,1);
    plot(f(1:ind),weightedEnvTemp(1:ind),'linewidth',2);hold on
    plot(f(1:ind),weightedFineTemp(1:ind),'linewidth',2,'color',[0 .5 0]);hold off
    legend('Addition waveform (envelope)','Subtraction waveform (fine structure)','location','northeast')
    title('Weighted sum: 25% cochlea, 50% cochlear nuclei, 25% IC/LL')
    xlabel('Frequency (Hz)');ylabel('Amplitude (dB)');
    zoom xon
    
    subplot(2,1,2)
    plot(f(1:ind),weightedEnv(1:ind),'linewidth',2);hold on
    plot(f(1:ind),weightedFine(1:ind),'linewidth',2,'color',[0 .5 0]);hold off
    title('Filtered weighted sum: 3rd order Butterworth lowpass at 450 Hz')
    xlabel('Frequency (Hz)');ylabel('Amplitude (dB)');
    zoom xon
    
    suptitle(titleTop)
    
    drawnow
    
end

% if saveFigures
%     
%     string=['weightFilt' num2str(master)];
%     hand=get(hand2,'Parent');
%     saveas(hand,string,'fig');
%     
% end

%% End plotting and saving
