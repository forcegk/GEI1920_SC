function [ber, ber_th] = p1_pam_ref(EbN0dB, isGray)

b = rand(1,1000000)>0.5;

%% Introducimos valor de k y sqrt_ep
k = 2;

M = 2^k;

%% Calculamos el vector de datos a transmitir
simb = reshape(b, k, []);
simb = bi2de(simb.', 'left-msb');

%% Calculamos empiricamente Es y generamos Eb
modulation_values = pammod(0:M-1, M);

Es = mean(abs(modulation_values).^2);
Eb = Es/k;

%% Generamos el vector de símbolos a transmitir
if isGray;
    simb_sent = pammod(simb, M, 0, 'GRAY');
else
    simb_sent = pammod(simb, M);
end
    
%% Introducimos EbN0dB, y calculamos el valor de EbN0 y No
%ebn0db = 0;
ebn0db = EbN0dB;

ebn0   = 10^(ebn0db/10);
n0 = (Eb / ebn0);

%% Generamos el AWGN
noise = sqrt(n0/2)*randn(size(simb_sent));

%noise = sqrt(n0/2)*(randn(size(simb_sent))+1j*randn(size(simb_sent)));


%% %% %% %% TRANSMITIMOS EL VECTOR %% %% %% %%
recv = (simb_sent + noise);  % Lo trasponemos para mandarlo como fila
%% %% %% %% %% %% %% %%%% %% %% %% %% %% %% %%


%%  Demodulamos
if isGray;
    simb_recv = pamdemod(recv, M, 0, 'GRAY');
else
    simb_recv = pamdemod(recv, M);
end

%% Reconstruimos el vector original
b_recv = de2bi(simb_recv, 'left-msb');
b_recv = reshape(b_recv.', [], k*size(b_recv, 1));

%% Calculamos los bits que son diferentes
b_diff = b ~= b_recv;
error_cnt = sum(b_diff);
ber =  error_cnt / length(b_recv);

%% Calculamos el BER teórico correspondiente a la modulación
if isGray;
    ber_th = (((M-1)/M) * erfc(sqrt( (3/((M^2)-1))*(Es/n0) ))) / k;
else
    ber_th = 0;
end
    
end
