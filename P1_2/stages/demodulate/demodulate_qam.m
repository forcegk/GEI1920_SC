%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%           MODULO DEMODULACIÓN. P1_2 SC. ALONSO RODRIGUEZ 2020          %
%                -> QAM                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bit_stream_out = demodulate_qam(simb_stream_in, M, is_gray)
    %% Calculamos k
    k = log2(M);
    
    %%  Demodulamos
    if is_gray;
        recv = qamdemod(simb_stream_in, M, 0, 'GRAY');
    else
        recv = qamdemod(simb_stream_in, M);
    end

    %% Reconstruimos el vector original
    bit_stream_out = de2bi(recv, 'left-msb');
    bit_stream_out = logical(reshape(bit_stream_out.', [], k*size(bit_stream_out, 1)));
    
    %% Eliminamos padding
    bit_stream_out = bit_stream_out(1:length(bit_stream_out)-(k-mod(size(bit_stream_out, 2), k)));
end