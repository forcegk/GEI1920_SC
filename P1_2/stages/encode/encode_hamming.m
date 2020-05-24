%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%           MODULO CODIFICACIÓN. P1_2 SC. ALONSO RODRIGUEZ 2020          %
%               -> HAMMING                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bit_stream_out = encode_hamming(bit_stream_in, k, n)
    % caso practica es k=4, n=7, así que solo vamos a implementar
    % este caso particular
    % Generamos matriz
    if k==4 && n==7
        G = [1 1 1 0 0 0 0;
             1 0 0 1 1 0 0;
             0 1 0 1 0 1 0;
             1 1 0 1 0 0 1];
    
        % partimos bit_stream_in en bloques de k bits
        words_in = reshape(bit_stream_in, k, []).';

        words_out = mod(words_in * G, 2); % suma binaria

        bit_stream_out = logical(reshape(words_out.', 1, []));
    else
        error('k!=4 or n!=7 => NOT SUPPORTED')
    end
end