
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%%                               Spectrogram
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   Authors:   Francisco Jesus Canadas Quesada Juan de la Torre Cruz
%              Juan de la Torre Cruz
%              Alejandro Antonio Salvador Navarro
%
%   Reference: Respiratory rate estimation applying non-negative
%              matrix partial co-factorization from breath sounds
% ---------------------------------------------------------------------------
% Inputs:
%   y: Input signal
%   nfft: Number of FFT points
%   fs: Sampling rate
%   window: Type of window used
%   noverlap: Number of samples that overlap between adjacent segments
%
% Outputs:
%   Y: Spectrogram of the input signal

function Y = spectrogram(y,nfft,fs,window,noverlap)

nx = length(y); 
nwind = length(window); 
if nx < nwind % Zero-pad x if it has length less than the window length
    y(nwind)=0;  nx=nwind;
end
y = y(:); 
window = window(:);

ncol = fix((nx-noverlap)/(nwind-noverlap)); 
colindex = 1 + (0:(ncol-1))*(nwind-noverlap); 
rowindex = (1:nwind)';
if length(y)<(nwind+colindex(ncol)-1)
    y(nwind+colindex(ncol)-1) = 0;   
end
w = zeros(nwind,ncol); 
w(:) = y(rowindex(:,ones(1,ncol))+colindex(ones(nwind,1),:)-1); % Populate output matrix using sliding window approach
w = window(:,ones(1,ncol)).*w; 

w = fft(w,nfft); 
if ~any(any(imag(y)))    
    if rem(nfft,2), % Check if nfft is odd
        select = [1:(nfft+1)/2]; 
    else
        select = [1:nfft/2+1]; 
    end
    w = w(select,:); 
else
    select = 1:nfft; % Select all frequencies if x has imaginary part
end
f = (select - 1)'*fs/nfft; 
t = (colindex-1)'/fs; 
if nargout == 1,
    Y = w; 
elseif nargout == 2,
    Y = w; 
    fo = f; 
elseif nargout == 3,
    Y = w; 
    fo = f; 
    to = t; 
else
    Y = w; 
    fo = f; 
    to = t; 
    colindex=colindex; 
end
