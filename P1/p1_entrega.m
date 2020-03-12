close all;
clearvars;

%% Añadimos los fuentes que me encontré por ahí...
addpath('./comm');
addpath('./commobsolete');

idx = 0:20;

gray_th_idx = 1;
gray_idx = 1;
natural_idx = 1;


BERs = zeros(6, size(idx, 2));
BERs_Gray = zeros(5, size(idx, 2));
BERs_Gray_TH = zeros(5, size(idx, 2));

%% STEP 1 %% 4-PAM
for ii = idx;
    [a, b] = p1_pam(ii);
    BERs(natural_idx, ii+1) = a;
end
clear ii;

natural_idx = natural_idx+1;
%%%%%%%%%%%%

%% STEP 2 %% 4-PAM-REF
for ii = idx;
    [a, b] = p1_pam_ref(ii, false);
    BERs(natural_idx, ii+1) = a;
end
clear ii;

natural_idx = natural_idx+1;
%%%%%%%%%%%%

%% STEP 3 %% 4-PAM-REF-GRAY
for ii = idx;
    [a, b] = p1_pam_ref(ii, true);
    BERs_Gray(gray_idx, ii+1) = a;
    BERs_Gray_TH(gray_th_idx, ii+1) = b;
end
clear ii;

gray_idx = gray_idx+1;
gray_th_idx = gray_th_idx+1;
%%%%%%%%%%%%

%% STEP 4 %% BPSK
for ii = idx;
    [a, b] = p1_bpsk(ii, false);
    BERs(natural_idx, ii+1) = a;
end
clear ii;

natural_idx = natural_idx+1;
%%%%%%%%%%%%

%% STEP 5 %% BPSK-GRAY
for ii = idx;
    [a, b] = p1_bpsk(ii, true);
    BERs_Gray(gray_idx, ii+1) = a;
    BERs_Gray_TH(gray_th_idx, ii+1) = b;
end
clear ii;

gray_idx = gray_idx+1;
gray_th_idx = gray_th_idx+1;
%%%%%%%%%%%%

%% STEP 6 %% QPSK
for ii = idx;
    [a, b] = p1_qpsk(ii, false);
    BERs(natural_idx, ii+1) = a;
end
clear ii;

natural_idx = natural_idx+1;
%%%%%%%%%%%%

%% STEP 7 %% QPSK-GRAY
for ii = idx;
    [a, b] = p1_qpsk(ii, true);
    BERs_Gray(gray_idx, ii+1) = a;
    BERs_Gray_TH(gray_th_idx, ii+1) = b;
end
clear ii;

gray_idx = gray_idx+1;
gray_th_idx = gray_th_idx+1;
%%%%%%%%%%%%

%% STEP 8 %% 16-QAM
for ii = idx;
    [a, b] = p1_16qam(ii, false);
    BERs(natural_idx, ii+1) = a;
end
clear ii;

natural_idx = natural_idx+1;
%%%%%%%%%%%%

%% STEP 9 %% 16-QAM-GRAY
for ii = idx;
    [a, b] = p1_16qam(ii, true);
    BERs_Gray(gray_idx, ii+1) = a;
    BERs_Gray_TH(gray_th_idx, ii+1) = b;
end
clear ii;

gray_idx = gray_idx+1;
gray_th_idx = gray_th_idx+1;
%%%%%%%%%%%%

%% STEP 10 %% 64-QAM
for ii = idx;
    [a, b] = p1_64qam(ii, false);
    BERs(natural_idx, ii+1) = a;
end
clear ii;

natural_idx = natural_idx+1;
%%%%%%%%%%%%

%% STEP 11 %% 64-QAM-GRAY
for ii = idx;
    [a, b] = p1_64qam(ii, true);
    BERs_Gray(gray_idx, ii+1) = a;
    BERs_Gray_TH(gray_th_idx, ii+1) = b;
end
clear ii;

gray_idx = gray_idx+1;
gray_th_idx = gray_th_idx+1;
%%%%%%%%%%%%







%% Representamos los BER empíricos para ordenamiento natural
figure();

for ii = 1:natural_idx-1;
    semilogy(idx, BERs(ii,:), 'o-');
    hold on;
end
clear ii;

xlim([0 20]);
ylim([10^(-7) 10^0]);

title('BER Empíricos para Ordenamiento Natural');
xlabel('E_{b}/N_{0} (dB)');
ylabel('BER-NATURAL');
grid on;

legend('4-PAM', '4-PAM-REF', 'BPSK', 'QPSK', '16-QAM', '64-QAM');
hold off;


%% Representamos los BER empíricos para Gray mapping
figure();

for ii = 1:gray_idx-1;
    semilogy(idx, BERs_Gray(ii,:), 'o-');
    hold on;
end
clear ii;

xlim([0 20]);
ylim([10^(-7) 10^0]);

title('BER Empíricos para Gray Mapping');
xlabel('E_{b}/N_{0} (dB)');
ylabel('BER-GRAY MAPPING');
grid on;

legend('4-PAM-REF-GRAY', 'BPSK-GRAY', 'QPSK-GRAY', '16-QAM-GRAY', '64-QAM-GRAY');
hold off;

%% Representamos los BER teóricos para Gray mapping
figure();

for ii = 1:gray_th_idx-1;
    semilogy(idx, BERs_Gray_TH(ii,:), 'o-');
    hold on;
end
clear ii;

xlim([0 20]);
ylim([10^(-7) 10^0]);

title('BER Teóricos para Gray Mapping');
xlabel('E_{b}/N_{0} (dB)');
ylabel('BER-TH-GRAY MAPPING');
grid on;

legend('4-PAM-REF-GRAY-TH', 'BPSK-GRAY-TH', 'QPSK-GRAY-TH', '16-QAM-GRAY-TH', '64-QAM-GRAY-TH');
hold off;


%% Representamos los BER para BPSK, QPSK, QPSK-GRAY, QPSK-GRAY-TH
figure();

for ii = [3 4];
    semilogy(idx, BERs(ii,:), 'o-');
    hold on;
end
for ii = [3];
    semilogy(idx, BERs_Gray(ii,:), 'o-');
    hold on;
end
for ii = [3];
    semilogy(idx, BERs_Gray_TH(ii,:), 'o-');
    hold on;
end
clear ii;

xlim([0 20]);
ylim([10^(-7) 10^0]);

title('BER Empíricos para BPSK, QPSK, QPSK-GRAY y Teóricos para QPSK-GRAY');
xlabel('E_{b}/N_{0} (dB)');
ylabel('BER');
grid on;

legend('BPSK', 'QPSK', 'QPSK-GRAY', 'QPSK-GRAY-TH');
hold off;


%% Representamos los BER para 64-QAM, 64-QAM-GRAY, 64-QAM-GRAY-TH
figure();

for ii = [6];
    semilogy(idx, BERs(ii,:), 'o-');
    hold on;
end
for ii = [5];
    semilogy(idx, BERs_Gray(ii,:), 'o-');
    hold on;
end
for ii = [5];
    semilogy(idx, BERs_Gray_TH(ii,:), 'o-');
    hold on;
end
clear ii;

xlim([0 20]);
ylim([10^(-7) 10^0]);

title('BER Empíricos para 64-QAM, 64-QAM-GRAY y Teóricos para 64-QAM-GRAY');
xlabel('E_{b}/N_{0} (dB)');
ylabel('BER');
grid on;

legend('64-QAM', '64-QAM-GRAY', '64-QAM-GRAY-TH');
hold off;