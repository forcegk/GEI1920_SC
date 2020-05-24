%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%          MODULO DECODIFICACIÓN. P1_2 SC. ALONSO RODRIGUEZ 2020         %
%               -> UNICAMENTE RECORTAMOS                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bit_stream_out = decode_crop(bit_stream_in, n_bits)
    %% Eliminamos padding a la entrada
    bit_stream_out = bit_stream_in(1:n_bits);
end