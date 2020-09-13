function [y,f]=absSpec(x,varargin)
if isempty(varargin), NFFT=length(x);
elseif length(varargin)==1
    NFFT=varargin{1};
elseif length(varargin)==2
    NFFT=varargin{1};
    fs=varargin{2};
end
if ~isreal(x)
    warning('Input signal is complex; only real portion taken')
    x=real(x);
end
flag=0;
if size(x,1)==1, x=x';flag=1;end
y=abs(fft(x,NFFT));
% y=abs(DFT(x,'rad2'))+1;
len=size(y,1);
ind=floor(len/2);
if flag
    y=(y(1:ind))';
else
    y=(y(1:ind,:));
end
if length(varargin)==2
    f=linspace(0,fs/2,length(y));
end