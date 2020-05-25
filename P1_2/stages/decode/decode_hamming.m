%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%          MODULO DECODIFICACIÓN. P1_2 SC. ALONSO RODRIGUEZ 2020         %
%               -> HAMMING                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [bit_stream_out, num_errors] = decode_hamming(bit_stream_in, k, n)
    % caso practica es k=4, n=7, así que solo vamos a implementar
    % este caso particular
    % Generamos matriz
    if k==4 && n==7
        H = [1 0 1 0 1 0 1;
             0 1 1 0 0 1 1;
             0 0 0 1 1 1 1];
         
        %% Eliminamos padding a la entrada
        %bit_stream_in = [ bit_stream_in  zeros(1, n-mod(size(bit_stream_in, 2), n)) ];
        %bit_stream_in = bit_stream_in(1:size(bit_stream_in,2)-mod(size(bit_stream_in, 2), n));
        
        %% Partimos bit_stream_in en bloques de n bits
        words_in = reshape(bit_stream_in, n, []).';
        
        %% Calculamos los síndromes
        err_in = mod(words_in * (H.'), 2);
        num_errors = sum(sum(err_in)); % errores detectados
        
        %% Y los corregimos a sus posiciones
        syndrome = bi2de(err_in, 'right-msb');
        
        %% Corregimos las posiciones que nos indica el sindrome
        for ii = 1:length(syndrome);
            if syndrome(ii) ~= 0
                words_in(ii, syndrome(ii)) = mod(words_in(ii, syndrome(ii))+1, 2);
            end
        end

        %% Seleccionamos las palabras
        words_out = words_in(:, [3 5 6 7]);
        
        %% Reshape a forma de stream
        bit_stream_out = logical(reshape(words_out.', 1, []));

    else
        error('k!=4 or n!=7 => NOT SUPPORTED')
    end
end