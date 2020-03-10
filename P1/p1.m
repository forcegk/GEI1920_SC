close all;
clearvars;

addpath('./comm');
addpath('./commobsolete');

idx = 0:40;
BERs = zeros(size(idx));

%% STEP 1 %% 4-PAM
for ii = idx;
    [a, b] = p1_pam(ii);
    BERs(ii+1) = a;
end
clear ii;

figure();
semilogy(idx, BERs, 'o-');
xlabel('E_{b}/N_{0} (dB)');
ylabel('BER');
grid on;
hold on;
%%%%%%%%%%%%

%% STEP 2 %% 4-PAM-INTEGRADO
for ii = idx;
    [a, b] = p1_pam_ref(ii);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 3 %% BPSK
for ii = idx;
    [a, b] = p1_bpsk(ii);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 4 %% QPSK
for ii = idx;
    [a, b] = p1_qpsk(ii);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 5 %% 16-QAM
for ii = idx;
    [a, b] = p1_16qam(ii);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 6 %% 64-QAM
for ii = idx;
    [a, b] = p1_64qam(ii, false);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 7 %% 64-QAM-GRAY
for ii = idx;
    [a, b] = p1_64qam(ii, true);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

legend('4-PAM', '4-PAM-REF', 'BPSK', 'QPSK', '16-QAM', '64-QAM', '64-QAM-GRAY');