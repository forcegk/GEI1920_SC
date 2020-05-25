%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%                 PRÁCTICA 1_2 SC. ALONSO RODRIGUEZ 2020                 %
%                                                                        %
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

%% Variables generales
% Bit stream
n_bits = 1000000;

%% Variables de control
EbN0dB_cnt = 0:15;
BER_psk = zeros(5, size(EbN0dB_cnt, 2));
BER_qam = zeros(5, size(EbN0dB_cnt, 2));


%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %%
%%                                 QPSK                                 %%
%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %%

%% Variables de modulación
M = 4;
%% Inicializamos variables de control
BER_idx = 1;

%% Transmitimos sin Hamming
for ii = EbN0dB_cnt;
    % Pasamos por todas las fases
    bit_stream = generate_bit_stream(n_bits);
    [simb_stream, eb] = modulate_psk(bit_stream, M, true);
    simb_stream_awgn = transmit_awgn(simb_stream, eb, ii, 1, 1, true);
    simb_stream_recv = demodulate_psk(simb_stream_awgn, M, true);
    %bit_stream_recv = decode_crop(simb_stream_recv, n_bits);
    bit_stream_recv = simb_stream_recv;
    
    % Calculamos los bits que son diferentes
    bit_stream_diff = bit_stream ~= bit_stream_recv;
    err_cnt = sum(bit_stream_diff);

    % Guardamos el BER
    BER_psk(BER_idx, ii+1) = err_cnt / length(bit_stream_diff);
end

BER_idx = BER_idx + 1;


%% Transmitimos para Hamming
% Código Hamming
k = 4;
n = 7;
for ii = EbN0dB_cnt;
    % Pasamos por todas las fases
    bit_stream = generate_bit_stream(n_bits);
    bit_stream_hamming = encode_hamming(bit_stream, k, n);
    [simb_stream_hamming, eb] = modulate_psk(bit_stream_hamming, M, true);
    simb_stream_hamming_awgn = transmit_awgn(simb_stream_hamming, eb, ii, k, n, true);
    simb_stream_hamming_recv = demodulate_psk(simb_stream_hamming_awgn, M, true);
    [bit_stream_recv, num_err_detected] = decode_hamming(simb_stream_hamming_recv, k, n);
    
    % Calculamos los bits que son diferentes
    bit_stream_diff = bit_stream ~= bit_stream_recv;
    err_cnt = sum(bit_stream_diff);

    % Guardamos el BER
    BER_psk(BER_idx, ii+1) = err_cnt / length(bit_stream_diff);
end

BER_idx = BER_idx + 1;

%% Transmitimos para Convolucional de Ejemplo
% Código Conv
constraint_length = 3;
code_generator = [7 5 6]; % correcto
for ii = EbN0dB_cnt;
    % Pasamos por todas las fases
    bit_stream = generate_bit_stream(n_bits);
    bit_stream_conv = encode_convolutional(bit_stream, constraint_length, code_generator);
    [simb_stream_conv, eb] = modulate_psk(bit_stream_conv, M, true);
    simb_stream_conv_awgn = transmit_awgn(simb_stream_conv, eb, ii, 1, length(code_generator), true); % dividimos por n0 por length(code_generator)
    simb_stream_conv_recv = demodulate_psk(simb_stream_conv_awgn, M, true);
    bit_stream_recv = decode_convolutional(simb_stream_conv_recv, constraint_length, code_generator);

    % Calculamos los bits que son diferentes
    bit_stream_diff = bit_stream ~= bit_stream_recv;
    err_cnt = sum(bit_stream_diff);

    % Guardamos el BER
    BER_psk(BER_idx, ii+1) = err_cnt / length(bit_stream_diff);
end

BER_idx = BER_idx + 1;

%% Transmitimos para Convolucional Catastrófico
% Código Conv
constraint_length = 3;
code_generator = [3 5 6]; % catastrófico
for ii = EbN0dB_cnt;
    % Pasamos por todas las fases
    bit_stream = generate_bit_stream(n_bits);
    bit_stream_conv = encode_convolutional(bit_stream, constraint_length, code_generator);
    [simb_stream_conv, eb] = modulate_psk(bit_stream_conv, M, true);
    simb_stream_conv_awgn = transmit_awgn(simb_stream_conv, eb, ii, 1, length(code_generator), true); % dividimos por n0 por length(code_generator)
    simb_stream_conv_recv = demodulate_psk(simb_stream_conv_awgn, M, true);
    bit_stream_recv = decode_convolutional(simb_stream_conv_recv, constraint_length, code_generator);

    % Calculamos los bits que son diferentes
    bit_stream_diff = bit_stream ~= bit_stream_recv;
    err_cnt = sum(bit_stream_diff);

    % Guardamos el BER
    BER_psk(BER_idx, ii+1) = err_cnt / length(bit_stream_diff);
end

BER_idx = BER_idx + 1;

%% Transmitimos para Convolucional Mejorado
% Código Conv
constraint_length = 3;
code_generator = [7 5 6]; % correcto
for ii = EbN0dB_cnt;
    % Pasamos por todas las fases
    bit_stream = generate_bit_stream(n_bits);
    bit_stream_conv = encode_convolutional(bit_stream, constraint_length, code_generator);
    [simb_stream_conv, eb] = modulate_psk(bit_stream_conv, M, true);
    simb_stream_conv_awgn = transmit_awgn(simb_stream_conv, eb, ii, 1, length(code_generator), true); % dividimos por n0 por length(code_generator)
    simb_stream_conv_recv = demodulate_psk(simb_stream_conv_awgn, M, true);
    bit_stream_recv = decode_convolutional(simb_stream_conv_recv, constraint_length, code_generator);

    % Calculamos los bits que son diferentes
    bit_stream_diff = bit_stream ~= bit_stream_recv;
    err_cnt = sum(bit_stream_diff);

    % Guardamos el BER
    BER_psk(BER_idx, ii+1) = err_cnt / length(bit_stream_diff);
end

BER_idx = BER_idx + 1;


%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %%
%%                                16-QAM                                %%
%% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %% %%

%% Variables de modulación
M = 16;
%% Inicializamos variables de control
BER_idx = 1;

%% Transmitimos sin Hamming
for ii = EbN0dB_cnt;
    % Pasamos por todas las fases
    bit_stream = generate_bit_stream(n_bits);
    [simb_stream, eb] = modulate_qam(bit_stream, M, true);
    simb_stream_awgn = transmit_awgn(simb_stream, eb, ii, 1, 1, true);
    simb_stream_recv = demodulate_qam(simb_stream_awgn, M, true);
    %bit_stream_recv = decode_crop(simb_stream_recv, n_bits);
    bit_stream_recv = simb_stream_recv;
    
    % Calculamos los bits que son diferentes
    bit_stream_diff = bit_stream ~= bit_stream_recv;
    err_cnt = sum(bit_stream_diff);

    % Guardamos el BER
    BER_qam(BER_idx, ii+1) = err_cnt / length(bit_stream_diff);
end

BER_idx = BER_idx + 1;


%% Transmitimos para Hamming
% Código Hamming
k = 4;
n = 7;
for ii = EbN0dB_cnt;
    % Pasamos por todas las fases
    bit_stream = generate_bit_stream(n_bits);
    bit_stream_hamming = encode_hamming(bit_stream, k, n);
    [simb_stream_hamming, eb] = modulate_qam(bit_stream_hamming, M, true);
    simb_stream_hamming_awgn = transmit_awgn(simb_stream_hamming, eb, ii, k, n, true);
    simb_stream_hamming_recv = demodulate_qam(simb_stream_hamming_awgn, M, true);
    [bit_stream_recv, num_err_detected] = decode_hamming(simb_stream_hamming_recv, k, n);
    
    % Calculamos los bits que son diferentes
    bit_stream_diff = bit_stream ~= bit_stream_recv;
    err_cnt = sum(bit_stream_diff);

    % Guardamos el BER
    BER_qam(BER_idx, ii+1) = err_cnt / length(bit_stream_diff);
end

BER_idx = BER_idx + 1;

%% Transmitimos para Convolucional de Ejemplo
% Código Conv
constraint_length = 3;
code_generator = [7 5 6]; % correcto
for ii = EbN0dB_cnt;
    % Pasamos por todas las fases
    bit_stream = generate_bit_stream(n_bits);
    bit_stream_conv = encode_convolutional(bit_stream, constraint_length, code_generator);
    [simb_stream_conv, eb] = modulate_qam(bit_stream_conv, M, true);
    simb_stream_conv_awgn = transmit_awgn(simb_stream_conv, eb, ii, 1, length(code_generator), true); % dividimos por n0 por length(code_generator)
    simb_stream_conv_recv = demodulate_qam(simb_stream_conv_awgn, M, true);
    bit_stream_recv = decode_convolutional(simb_stream_conv_recv, constraint_length, code_generator);

    % Calculamos los bits que son diferentes
    bit_stream_diff = bit_stream ~= bit_stream_recv;
    err_cnt = sum(bit_stream_diff);

    % Guardamos el BER
    BER_qam(BER_idx, ii+1) = err_cnt / length(bit_stream_diff);
end

BER_idx = BER_idx + 1;

%% Transmitimos para Convolucional Catastrófico
% Código Conv
constraint_length = 3;
code_generator = [3 5 6]; % catastrófico
for ii = EbN0dB_cnt;
    % Pasamos por todas las fases
    bit_stream = generate_bit_stream(n_bits);
    bit_stream_conv = encode_convolutional(bit_stream, constraint_length, code_generator);
    [simb_stream_conv, eb] = modulate_qam(bit_stream_conv, M, true);
    simb_stream_conv_awgn = transmit_awgn(simb_stream_conv, eb, ii, 1, length(code_generator), true); % dividimos por n0 por length(code_generator)
    simb_stream_conv_recv = demodulate_qam(simb_stream_conv_awgn, M, true);
    bit_stream_recv = decode_convolutional(simb_stream_conv_recv, constraint_length, code_generator);

    % Calculamos los bits que son diferentes
    bit_stream_diff = bit_stream ~= bit_stream_recv;
    err_cnt = sum(bit_stream_diff);

    % Guardamos el BER
    BER_qam(BER_idx, ii+1) = err_cnt / length(bit_stream_diff);
end

BER_idx = BER_idx + 1;

%% Transmitimos para Convolucional Mejorado
% Código Conv
constraint_length = 3;
code_generator = [7 5 6]; % correcto
for ii = EbN0dB_cnt;
    % Pasamos por todas las fases
    bit_stream = generate_bit_stream(n_bits);
    bit_stream_conv = encode_convolutional(bit_stream, constraint_length, code_generator);
    [simb_stream_conv, eb] = modulate_qam(bit_stream_conv, M, true);
    simb_stream_conv_awgn = transmit_awgn(simb_stream_conv, eb, ii, 1, length(code_generator), true); % dividimos por n0 por length(code_generator)
    simb_stream_conv_recv = demodulate_qam(simb_stream_conv_awgn, M, true);
    bit_stream_recv = decode_convolutional(simb_stream_conv_recv, constraint_length, code_generator);

    % Calculamos los bits que son diferentes
    bit_stream_diff = bit_stream ~= bit_stream_recv;
    err_cnt = sum(bit_stream_diff);

    % Guardamos el BER
    BER_qam(BER_idx, ii+1) = err_cnt / length(bit_stream_diff);
end

BER_idx = BER_idx + 1;


%% Representamos los BER empíricos para QPSK
figure();

for ii = 1:BER_idx-1;
    semilogy(EbN0dB_cnt, BER_psk(ii,:), 'o-');
    hold on;
end
clear ii;

xlim([min(EbN0dB_cnt) max(EbN0dB_cnt)]);
ylim([10^(-7) 10^0]);

title('BER Empíricos para QPSK (Gray Mapping)');
xlabel('E_{b}/N_{0} (dB)');
ylabel('BER');
grid on;

legend('SIN CORRECCIÓN', 'HAMMING', 'CONVOLUCIONAL-EJEMPLO', 'CONVOLUCIONAL-CATASTRÓFICO', 'CONVOLUCIONAL-MEJORADO');
hold off;

%% Representamos los BER empíricos para 16-QAM
figure();

for ii = 1:BER_idx-1;
    semilogy(EbN0dB_cnt, BER_qam(ii,:), 'o-');
    hold on;
end
clear ii;

xlim([min(EbN0dB_cnt) max(EbN0dB_cnt)]);
ylim([10^(-7) 10^0]);

title('BER Empíricos para 16-QAM (Gray Mapping)');
xlabel('E_{b}/N_{0} (dB)');
ylabel('BER');
grid on;

legend('SIN CORRECCIÓN', 'HAMMING', 'CONVOLUCIONAL-EJEMPLO', 'CONVOLUCIONAL-CATASTRÓFICO', 'CONVOLUCIONAL-MEJORADO');
hold off;











