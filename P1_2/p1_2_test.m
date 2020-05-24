%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%                 PRÁCTICA 1_2 SC. ALONSO RODRIGUEZ 2020                 %
%                           ARCHIVO DE PRUEBAS                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
slCharacterEncoding('UTF-8');

%% Añadimos las etapas
addpath('./stages/decode');
addpath('./stages/demodulate');
addpath('./stages/encode');
addpath('./stages/generate');
addpath('./stages/modulate');
addpath('./stages/transmit');

%% Variables
% Bit stream
n_bits = 1000000;
% Código Hamming
k = 4;
n = 7;
% Código Conv
constraint_length = 3;
code_generator = [7 5 6];
% Modulación
M = 4;
% Canal
EbN0dB = 10;

%% Variables de control
EbN0dB_cnt = 0:15;
BER_idx = 1;


% Pasamos por todas las fases
bit_stream = generate_bit_stream(n_bits);
bit_stream_conv = encode_convolutional(bit_stream, constraint_length, code_generator);
[simb_stream_conv, eb] = modulate_psk(bit_stream_conv, M, true);
simb_stream_conv_awgn = transmit_awgn(simb_stream_conv, eb, EbN0dB, 1, constraint_length, true);
simb_stream_conv_recv = demodulate_psk(simb_stream_conv_awgn, M, true);
bit_stream_recv = decode_convolutional(simb_stream_conv_recv, constraint_length, code_generator);

% Calculamos los bits que son diferentes
bit_stream_diff = bit_stream ~= bit_stream_recv;
err_cnt = sum(bit_stream_diff);

% Guardamos el BER
BER = err_cnt / length(bit_stream_diff);











