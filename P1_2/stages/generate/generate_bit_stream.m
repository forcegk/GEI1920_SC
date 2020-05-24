%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%            MODULO GENERACIÓN. P1_2 SC. ALONSO RODRIGUEZ 2020           %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bit_stream_out = generate_bit_stream(n_bits)
    % generamos bit stream de n bits
    bit_stream_out = rand(1,n_bits)>0.5;

    % test
    %bit_stream_out = logical(([1 0 0 0    0 1 0 0    0 0 1 0    0 0 0 1   1 1 1 1] > 0.5));
end
