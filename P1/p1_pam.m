function [ber, ber_th] = p1_pam(EbN0dB)

b = rand(1,1000000)>0.5;
%b = [1 0 0 0 1 1 0 1 0 0 1 0] > 0.5;
%b = [0 1 0 0 1 1] > 0.5;

%% Introducimos valor de k y sqrt_ep
k = 2;
sqrt_ep = 1;

M = 2^k;

%% Introducimos calculo de Es y generamos Eb
Es = ((M^2)-1)/3;
Eb = Es/k;


%% Calculamos el vector de datos a transmitir
simb = reshape(b, k, []);
simb = bi2de(simb.', 'left-msb');


%% Generamos el vector de símbolos a transmitir
modulation_values = mpam(M, sqrt_ep); %% Aquí ajustamos la modulación que 
                                       %  queremos aplicar

simb_sent = zeros(1, length(simb)); % Preasignamos el espacio
for ii = 1:length(simb);
    simb_sent(ii) = modulation_values(simb(ii)+1);
end
clear ii;

    
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
recv_repl = repmat(recv, M, 1);
modulation_values_repl = repmat(modulation_values.', 1, size(recv_repl, 2));

%% Calculamos las diferencias
diffs = abs(recv_repl - modulation_values_repl);
% Extraemos los valores
[~, pos] = min(diffs);
simb_recv = pos-1;

%% Reconstruimos el vector original
b_recv = de2bi(simb_recv, 'left-msb');
b_recv = reshape(b_recv.', [], k*size(b_recv, 1));

%% Calculamos los bits que son diferentes
b_diff = b ~= b_recv;
error_cnt = sum(b_diff);
ber =  error_cnt / length(b_recv);

%% Calculamos el BER teórico correspondiente a la modulación
ber_th = (((M-1)/M) * erfc(sqrt( (3/((M^2)-1))*(Es/n0) )));
%ber_th = (1/M) * (2*(M-1)) * (1/2) * erfc(sqrt((sqrt_ep^2)/n0));

end




