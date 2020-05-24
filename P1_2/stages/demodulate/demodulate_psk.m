%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%           MODULO DEMODULACIÓN. P1_2 SC. ALONSO RODRIGUEZ 2020          %
%                -> PSK                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bit_stream_out = demodulate_psk(simb_stream_in, M, is_gray)
    %% Calculamos k
    k = log2(M);
    
    %%  Demodulamos
    if is_gray;
        recv = pskdemod(simb_stream_in, M, 0, 'GRAY');
    else
        recv = pskdemod(simb_stream_in, M);
    end

    %% Reconstruimos el vector original
    bit_stream_out = de2bi(recv, 'left-msb');
    bit_stream_out = logical(reshape(bit_stream_out.', [], k*size(bit_stream_out, 1)));
end