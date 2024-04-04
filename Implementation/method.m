
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%%                            Proposed method 
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   Authors:   Alejandro Antonio Salvador Navarro  
%              Juan de la Torre Cruz
%              Francisco Jesus Canadas Quesada 
%
%   Reference: Respiratory rate estimation applying non-negative
%              matrix partial co-factorization from breath sounds
% ---------------------------------------------------------------------------
% Inputs:
%   fs: Sampling frequency
%   N: Samples of Hanning window
%   S: Overlap between consecutive windows
%   Sources: Number of respiratory recordings for training signal
%   Kr: Number of respiratory bases
%   Kn: Number of noise bases
%   nu: Relative similarity significance between X and Y
%   nIter: Number of iterations
%
% Outputs:
%   RR: Estimated respiratory rate

clc; clear all; close all;

%% Parameters
fs = 8e3; % Sampling rate
N = 256;  % Samples of Hanning window
S = 5e-1;  % Overlap between consecutive window
Sources = 17; % Respiratory recordings for training signal
Kr = 4;   % Respiratory bases
Kn = 2e1;  % Noise bases
nu = 5e-1; % Relative similarity significance between X and Y
nIter = 3e2; % Number of iterations

%% Stage I. Signal pre-processing
x = zeros(8e3*70,2); 
[file, path] = uigetfile('*.wav'); % Read recorded signal
[x,Fs] = audioread([path file]); 
x = x(1:Fs*60,:); x = x'; longx = length(x); 

if size(x,2) == 2, x = mean(x,2); end % Converted to mono 
if Fs ~= fs, x = resample(x,Fs,fs); end % Downsample
    
%% Stage II. Spectrogram conversion
Hop_samples = round(S*N); 
NFrames = floor((longx-N+(N*S))/Hop_samples); 

window = hamming(N); 
noverlap = N-Hop_samples; 

nfft = 2^nextpow2(N*2); % Number of FFT points
X = spectrogram(x,nfft,fs,window,noverlap); % Spectrogram
X = abs(X); 
F = size(X,1); % Number of frequency bins
T = size(X,2); % Number of time frames
X = X / (sum(sum(X))/F*T); % Normalized spectrogram
  
%% Stage III. NMPCF
training(fs,Kr,N,S,nIter); % Function call to obtain Wr and Ar

filename = sprintf(['Wr_K' num2str(Kr) '.mat']); 
Wr = load(filename); 
Wr_cell = struct2cell(Wr); 
Wr = cell2mat(Wr_cell{1,1}');

filename = sprintf(['Ar_K' num2str(Kr) '.mat']); 
Ar = load(filename); 
Ar_cell = struct2cell(Ar);
Ar = []; 
max_row = 1; 
max_col = 1; 

for i = 1:length(Ar_cell{:,:})
     mat = cell2mat(Ar_cell{:,:}(i)'); 
     [rows, cols] = size(mat); 
     max_row = max(max_row, rows); 
     max_col = max(max_col, cols); 
end

for i = 1:1:length(Ar_cell{:,:})
    mat = cell2mat(Ar_cell{:,:}(i)'); 
    [rows, cols] = size(mat); 
    padded_mat = padarray(mat, [max_row-rows max_col-cols], 'post'); % Padding matrix
    Ar = [Ar; padded_mat]; % Concatenating padded matrix to Ar
end

Kr = Kr*Sources; % Updating Kr
Hr = rand(Kr,T); % Generating random matrix Hr
Wn = rand(F,Kn); % Generating random matrix Wn
Hn = rand(Kn,T); % Generating random matrix Hn

V = Wr*Hr + Wn*Hn; 
Y = Wr*Ar; 

for j = 1:nIter  
   % Update Wr
   numWr = (X*transpose(Hr) + nu.*(Y*transpose(Ar))); 
   denWr = (Wr*Hr*transpose(Hr)) + (Wn*Hn*transpose(Hr)) + nu.*(Wr*Ar*transpose(Ar)); 
   Wr = Wr.*(numWr./denWr); 
   V = Wr*Hr + Wn*Hn; 
   Y = Wr*Ar; 
   
   % Update Hr
   numHr = (transpose(X)*Wr); 
   denHr = (transpose(Hr)*(transpose(Wr)*Wr))+(transpose(Hn)*(transpose(Wn)*Wr)); 
   Hr = Hr.*transpose((numHr./denHr));
   V = Wr*Hr + Wn*Hn; 
   Y = Wr*Ar; 
   
   % Update Wn
   numWn = (X*transpose(Hn)); 
   denHn = (Wn*Hn*transpose(Hn)) + (Wr*Hr*transpose(Hn)); 
   Wn = Wn.*(numWn./denHn); 
   V = Wr*Hr + Wn*Hn; 
   Y = Wr*Ar; 
   
   % Update Hn
   numHn = (transpose(X)*Wn); 
   denHn = (transpose(Hn)*transpose(Wn)*Wn) + (transpose(Hr)*transpose(Wr)*Wn); 
   Hn = Hn.*transpose((numHn./denHn)); 
   V = Wr*Hr + Wn*Hn; 
   Y = Wr*Ar; 
   
   % Update Ar
   numAr = (transpose(Y)*Wr); 
   denAr = (transpose(Ar)*transpose(Wr)*Wr); 
   Ar = Ar.*transpose(numAr./denAr); 
   Y = Wr*Ar; 
   
   div1 = 1/2.*((X - Wr*Hr - Wn*Hn).^2);
   div2 = (nu/2).*((Y - Wr*Ar).^2); 
   D(j) = sum(div1(:)) + sum(div2(:)); % Global objective function
end

%% Stage IV. RR estimation:
ts = 128/fs; fs = 1/ts; % Computing sampling time and frequency
for hkr = 1:Kr
    Ekr = fftshift(abs(fft(Hr(hkr,:)))); % Computing FFT of Hr
    index = floor((length(Ekr) + 10) / 2); 
    Ekr(1:index) = 0; % Removing lower frequencies
    vf = -fs/2 : fs/(length(Ekr)-1) : fs/2; % Frequency vector
    [~,pos] = max(Ekr); % Finding peak position
    Ekr_max = round(vf(pos),4); 
    RR(hkr) = round(round(60*Ekr_max,3)); % Calculating respiratory rate
end

condition = (RR > 30) | (RR < 5); % Filtering outlying RR values
RR = mode(RR(~condition)); % Computing mode of RR

disp(['The estimated respiratory rate (RR) is ' num2str(RR) ' bpm']);





