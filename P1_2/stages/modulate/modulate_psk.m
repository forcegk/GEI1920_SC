%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%            MODULO MODULACIÓN. P1_2 SC. ALONSO RODRIGUEZ 2020           %
%                -> PSK                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [simb_stream_out, Eb] = modulate_psk(bit_stream_in, M, is_gray)
    %% Calculamos k   
    k = log2(M);

    %% Añadimos padding a la entrada
    bit_stream_in = [ bit_stream_in  zeros(1, k-mod(size(bit_stream_in, 2), k)) ];
    
    %% Calculamos el vector de datos a transmitir
    simb = reshape(bit_stream_in, k, []);
    simb = bi2de(simb.', 'left-msb');
    
    %% Calculamos empiricamente Es y generamos Eb (utilizamos simb_stream_out temporalmente)
    simb_stream_out = pskmod(0:(M)-1, (M));

    Es = mean(abs(simb_stream_out).^2);
    Eb = Es/k;
    
    %% Generamos el vector de símbolos a transmitir
    if is_gray;
        simb_stream_out = pskmod(simb, M, 0, 'GRAY');
    else
        simb_stream_out = pskmod(simb, M);
    end
    
end