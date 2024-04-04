
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%%                            Training signal
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   Authors:   Francisco Jesus Canadas Quesada Juan de la Torre Cruz
%              Juan de la Torre Cruz
%              Alejandro Antonio Salvador Navarro
%
%   Reference: Respiratory rate estimation applying non-negative
%              matrix partial co-factorization from breath sounds
% ---------------------------------------------------------------------------
% Inputs:
%   fs: Sampling frequency
%   K: Input signal
%   N: Length of the window
%   S: Overlap between consecutive windows
%   nIter: Number of iterations
%
% Outputs:
%   Wr: Dictionary of respiratory spectral patterns
%   Ar: Temporal respiratory gains

function training(fs,K,N,S,nIter)

directory = 'C:\Users\Alejandro\Documents\Paper MELECON\Respiratory training signals'; % Directory containing audio files
files = dir(fullfile(directory, '*.wav')); 

y = cell(length(files), 1); 
Wr = cell(length(files), 1); 
Ar = cell(length(files), 1); 

for i = 1:length(files)
   
    name = fullfile(directory, files(i).name);
    [data, Fs] = audioread(name);
    y{i} = data;
    
    if size(y{i},2) == 2, y{i} = (y{i}(:,1)+ y{i}(:,2))/2; end
    if Fs ~= fs, y{i} = resample(y{i},fs,Fs); end
    
    y{i} = y{i}'; 
    long_y{i} = length(y{i}); 
    
    Hop_samples = round(S*N); 
    NFrames = floor((long_y{i}-N+(N*S))/Hop_samples); 

    window = hamming(N); 
    noverlap = N-Hop_samples; 

    nfft = 2^nextpow2(N*2);
    Y{i} = spectrogram(y{i},nfft,Fs,window,noverlap); 
    Y{i} = abs(Y{i}); 
    F = size(Y{i},1); 
    T = size(Y{i},2); 
    Y{i} = Y{i} / (sum(sum(Y{i}))/F*T); 

    W = rand(F,K); 
    A = rand(K,T); 
    L = W*A; 
    
    for j = 1:nIter
        % Update W
        numW = (Y{i}./(L))*transpose(A);
        denW = ((L).^0)*transpose(A); 
        W = W.*(numW./denW); 
        L = W*A; 
    
        % Update A
        numA = transpose(W)*(Y{i}./(L)); 
        denA = transpose(W)*((L).^0); 
        A = A.*(numA./denA); 
        L = W*A; 
    
        div = Y{i}.*log10(Y{i}./(L))-Y{i}+(L); 
        DK(j) = sum(div(:)); % Global objective function
    end

    Wr{i} = W; % Store learned W matrix
    Ar{i} = A; % Store learned A matrix
    
end

filename = sprintf(['Wr_K' num2str(K) '.mat']); save(filename, 'Wr'); 
filename = sprintf(['Ar_K' num2str(K) '.mat']); save(filename, 'Ar'); 

end