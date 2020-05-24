%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%           MODULO TRANSMISIÓN. P1_2 SC. ALONSO RODRIGUEZ 2020           %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function simb_stream_out = transmit_awgn(simb_stream_in, Eb, EbN0dB, k, n, noise_is_imaginary)
    %% Introducimos EbN0dB, y calculamos el valor de EbN0 y No
    EbN0   = 10^(EbN0dB/10);
    n0 = (n/k)*(Eb / EbN0);

    %% Generamos el AWGN
    if noise_is_imaginary;
        noise = sqrt(n0/2)*(randn(size(simb_stream_in))+1j*randn(size(simb_stream_in)));
    else
        noise = sqrt(n0/2)*randn(size(simb_stream_in));
    end

    %% TRANSMITIMOS EL VECTOR 
    simb_stream_out = (simb_stream_in + noise);
end