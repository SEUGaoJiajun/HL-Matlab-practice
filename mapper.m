function [modulated_symbols,Mod] = mapper(b,N)
% If N is given, it generates a block of N random 2^b-PSK/QAM modulated symbols.
% Otherwise, it generates a block of 2^b-PSK/QAM modulated symbols for [0:2^b-1].

% MIMO-OFDM Wireless Communications with MATLAB¢ç   Yong Soo Cho, Jaekwon Kim, Won Young Yang and Chung G. Kang
% 2010 John Wiley & Sons (Asia) Pte Ltd

% http://www.wiley.com//legacy/wileychi/cho/

M = 2^b; % Modulation order or Alphabet (Symbol) size

if nargin == 2 % generates a block of N random 2^b-PSK/QAM modulated symbols
    msgint = randi(M,1,N) - 1;
else
    msgint = 0:M-1;
end

if b == 1
    Mod = 'BPSK'; A = 1; 
    % mod_object = modem.pskmod('M',M);
    modulated_symbols = pskmod(msgint,M,pi/2,'gray')*A;
elseif b == 2
    Mod = 'QPSK';  A = 1;
    % mod_object = modem.pskmod('M',M,'PhaseOffset',pi/4);
    modulated_symbols = pskmod(msgint,M,pi/4,'gray')*A;
else
    Mod = [num2str(2^b) 'QAM']; Es = 1; A = sqrt(3/2/(M-1)*Es);
    modulated_symbols = qammod(msgint,M,'gray')*A;
end

