%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%           MODULO CODIFICACIÓN. P1_2 SC. ALONSO RODRIGUEZ 2020          %
%               -> CONVOLUCIONAL                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bit_stream_out = encode_convolutional(bit_stream_in, constraint_length, code_generator)
    %% Codificamos
    trellis = poly2trellis(constraint_length, code_generator);
    bit_stream_out = convenc(bit_stream_in, trellis);
end