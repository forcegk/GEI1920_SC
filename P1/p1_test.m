close all;
clearvars;

%% Añadimos los fuentes que me encontré por ahí...
addpath('./comm');
addpath('./commobsolete');

idx = 0:20;
BERs = zeros(size(idx));

% Espacio para 5 valores (los calculables: gray)
gray_idx = 1;
BERs_TH = zeros(5 ,size(idx, 2));

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
ylim([10^(-7) 10^0]);
grid on;
hold on;
%%%%%%%%%%%%

%% STEP 2 %% 4-PAM-REF
for ii = idx;
    [a, b] = p1_pam_ref(ii, false);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 3 %% 4-PAM-REF-GRAY
for ii = idx;
    [a, b] = p1_pam_ref(ii, true);
    BERs(ii+1) = a;
    BERs_TH(gray_idx, ii+1) = b;
end
clear ii;
gray_idx = gray_idx+1;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 4 %% BPSK
for ii = idx;
    [a, b] = p1_bpsk(ii, false);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 5 %% BPSK-GRAY
for ii = idx;
    [a, b] = p1_bpsk(ii, true);
    BERs(ii+1) = a;
    BERs_TH(gray_idx, ii+1) = b;
end
clear ii;
gray_idx = gray_idx+1;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 6 %% QPSK
for ii = idx;
    [a, b] = p1_qpsk(ii, false);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 7 %% QPSK-GRAY
for ii = idx;
    [a, b] = p1_qpsk(ii, true);
    BERs(ii+1) = a;
    BERs_TH(gray_idx, ii+1) = b;
end
clear ii;
gray_idx = gray_idx+1;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 8 %% 16-QAM
for ii = idx;
    [a, b] = p1_16qam(ii, false);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 9 %% 16-QAM-GRAY
for ii = idx;
    [a, b] = p1_16qam(ii, true);
    BERs(ii+1) = a;
    BERs_TH(gray_idx, ii+1) = b;
end
clear ii;
gray_idx = gray_idx+1;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 10 %% 64-QAM
for ii = idx;
    [a, b] = p1_64qam(ii, false);
    BERs(ii+1) = a;
end
clear ii;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

%% STEP 11 %% 64-QAM-GRAY
for ii = idx;
    [a, b] = p1_64qam(ii, true);
    BERs(ii+1) = a;
    BERs_TH(gray_idx, ii+1) = b;
end
clear ii;
gray_idx = gray_idx+1;

semilogy(idx, BERs, 'o-');
%%%%%%%%%%%%

legend('4-PAM', '4-PAM-REF', '4-PAM-REF-GRAY', 'BPSK', 'BPSK-GRAY', 'QPSK', 'QPSK-GRAY', '16-QAM', '16-QAM-GRAY', '64-QAM', '64-QAM-GRAY');
hold off;

%% Representamos los BER teóricos para las que aplicamos Gray mapping
figure();

for ii = 1:gray_idx-1;
    semilogy(idx, BERs_TH(ii,:), 'o-');
    hold on;
end

ylim([10^(-7) 10^0]);

xlabel('E_{b}/N_{0} (dB)');
ylabel('BER-TH');
grid on;

legend('4-PAM-REF-GRAY-TH', 'BPSK-GRAY-TH', 'QPSK-GRAY-TH', '16-QAM-GRAY-TH', '64-QAM-GRAY-TH');
hold off;

