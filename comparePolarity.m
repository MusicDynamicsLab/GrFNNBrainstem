%% Makes a model of the FFR using alternating polarity.
%% The model output comes from filteringFFR.m which is run at the bottom of this code.
%% The even-order and odd-order portions of the model FFR are the variables
%%         modelEnv and modelFine, respectively.


for i=1:length(stim)
    stim{i}.x=midearfilt(stim{i}.x,stim{i}.fs);
    stim{i}.x=hilbert(stim{i}.x);
end



%%

count=0;
master=0;
num=1;
freqLim=700;
downSamp=1;     % factor by which to downsample FFR model

temp1=[];
temp2=[];
temp3=[];

%%

for i=1:2:times*num*2-1
    
    count=count+1;
    
    s=stim{i};        % Do one polarity condition
    
    brainstem;
    Z1=M.n{2}.Z;clear M.n{1}.Z;            % Not grabbing the BM here, just OC and brainstem layers
    Z2=M.n{3}.Z;clear M.n{2}.Z;
    Z3=M.n{4}.Z;clear M.n{3}.Z;clear M.n{4}.Z;
    ZZ1=mean(Z1).';ZZ2=mean(Z2).';ZZ3=mean(Z3).';
    
    len=size(ZZ1,1);
    
    ZZ1inv=interp1(linspace(0,1,len),ZZ1,linspace(0,1,floor(len/downSamp))');
    ZZ2inv=interp1(linspace(0,1,len),ZZ2,linspace(0,1,floor(len/downSamp))');
    ZZ3inv=interp1(linspace(0,1,len),ZZ3,linspace(0,1,floor(len/downSamp))');
    
    s=stim{i+1};         % Do the opposite polarity condition
    
    brainstem;
    Z1inv=M.n{2}.Z;clear M.n{1}.Z;
    Z2inv=M.n{3}.Z;clear M.n{2}.Z;
    Z3inv=M.n{4}.Z;clear M.n{3}.Z;clear M.n{4}.Z;
    ZZ1=mean(Z1inv).';ZZ2=mean(Z2inv).';ZZ3=mean(Z3inv).';
    
    ZZ1=interp1(linspace(0,1,len),ZZ1,linspace(0,1,floor(len/downSamp))');
    ZZ2=interp1(linspace(0,1,len),ZZ2,linspace(0,1,floor(len/downSamp))');
    ZZ3=interp1(linspace(0,1,len),ZZ3,linspace(0,1,floor(len/downSamp))');
    
    
    %%
    
    temp1(:,:,count)=[ZZ1 ZZ1inv];
    temp2(:,:,count)=[ZZ2 ZZ2inv];
    temp3(:,:,count)=[ZZ3 ZZ3inv];
    
    %%
    if count==times
        
        master=master+1;
        
        fs=floor(s.fs/downSamp);
        len1=floor(len/downSamp);
        
        Z1fine=sum(temp1(:,1,:),3)/times - sum(temp1(:,2,:),3)/times;
        Z2fine=sum(temp2(:,1,:),3)/times - sum(temp2(:,2,:),3)/times;
        Z3fine=sum(temp3(:,1,:),3)/times - sum(temp3(:,2,:),3)/times;
        
        Z1env =sum(temp1(:,1,:),3)/times + sum(temp1(:,2,:),3)/times;
        Z2env =sum(temp2(:,1,:),3)/times + sum(temp2(:,2,:),3)/times;
        Z3env =sum(temp3(:,1,:),3)/times + sum(temp3(:,2,:),3)/times;
        
        f=fs/2*linspace(0,1,NFFT/2+1);
        ind=floor(length(f)*freqLim/(fs/2));        
        
        specEnv1=absSpec(Z1env,NFFT);
        
        specFine1=absSpec(Z1fine,NFFT);
        
        specEnv2=absSpec(Z2env,NFFT);
        
        specFine2=absSpec(Z2fine,NFFT);
        
        specEnv3=absSpec(Z3env,NFFT);
        
        specFine3=absSpec(Z3fine,NFFT);
        
        %% Plotting and saving
        
        if plotFigures
            
            figure;set(gcf,'position',[75 75 1300 800]);
            
            hand1=subplot(3,1,3);
            plot(f(1:ind),specEnv1(1:ind),'linewidth',2);
            hold on
            plot(f(1:ind),specFine1(1:ind),'linewidth',2,'color',[0 .5 0]);hold off
            title('Cochlea frequency response');xlabel('Frequency (Hz)');ylabel('Power (dB)');
            legend('Addition waveform (envelope)','Subtraction waveform (fine structure)','location','northeast')
            zoom xon
            
            
            subplot(3,1,2)
            plot(f(1:ind),specEnv2(1:ind),'linewidth',2);
            hold on
            plot(f(1:ind),specFine2(1:ind),'linewidth',2,'color',[0 .5 0]);hold off
            title('Cochlear nucleus frequency response');xlabel('Frequency (Hz)');ylabel('Power (dB)');
            legend('Addition waveform (envelope)','Subtraction waveform (fine structure)','location','northeast')
            zoom xon
            
            
            subplot(3,1,1)
            plot(f(1:ind),specEnv3(1:ind),'linewidth',2);
            hold on
            plot(f(1:ind),specFine3(1:ind),'linewidth',2,'color',[0 .5 0]);hold off
            title('Lateral lemniscus frequency response');xlabel('Frequency (Hz)');ylabel('Power (dB)');
            legend('Addition waveform (envelope)','Subtraction waveform (fine structure)','location','northeast')
            zoom xon
            
            
            titleTop=['Stimulus ='];
            for j=1:length(s.fc)
                titleTop=[titleTop ' ' num2str(s.fc{j})];
            end
            titleTop=[titleTop ' Hz'];
            suptitle(titleTop);
            drawnow;
            
        end
        %%
        
%         if saveFigures
%             
%             string=['stim' num2str(master)];
%             hand=get(hand1,'Parent');
%             saveas(hand,string,'fig');
%             
%             if saveWorkspace
%                 save(string);
%             end
%             
%         end
        
        %% End plotting and saving
        
        filteringFFR;
        
        count=0;
        
    end
    disp(i);
end



