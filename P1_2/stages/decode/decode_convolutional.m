%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%          MODULO DECODIFICACIÓN. P1_2 SC. ALONSO RODRIGUEZ 2020         %
%               -> CONVOLUCIONAL                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bit_stream_out = decode_convolutional(bit_stream_in, constraint_length, code_generator)
    %% Eliminamos padding a la entrada
    %bit_stream_in = bit_stream_in(1:size(bit_stream_in,2)-mod(size(bit_stream_in, 2), constraint_length));
    
    %% Decodificamos
    trellis = poly2trellis(constraint_length, code_generator);
    bit_stream_out = logical(vitdec(bit_stream_in, trellis, 5*constraint_length, 'trunc', 'hard'));
end