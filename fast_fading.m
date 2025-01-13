%% Load dataset
clear all 
close all
load("group-02-02-2024-2025.mat")

figure
plot(P_1)
title("P_1")
ylabel('dBW')
figure
histogram(abs(P_1))
xlim([50 110])
ylim([0 900])
xline(median(abs(P_1)))

figure
plot(P_2)
title("P_2")
ylabel('dBW')

figure
histogram(abs(P_2))
xlim([50 110])
ylim([0 900])
xline(median(abs(P_2)))

mean_p1 = mean(P_1) %dB
mean_p2 = mean(P_2) %dB

%P1 LOS
%P2 NLOS = p_f
%Convert it to Watts
watt_p1 = 10.^(P_1/10);
watt_p2 = 10.^(P_2/10);
%meanWatt_p1 = 10^(mean_p1/10)
%meanWatt_p2 = 10^(mean_p2/10)
meanWatt_p1 = mean(watt_p1)
meanWatt_p2 = mean(watt_p2)
%P = meanWatt_p1/meanWatt_p2 %Rician K-factor

%P_dB = mean_p1 - mean_p2
p_f = meanWatt_p2; %in Watt
p_m = meanWatt_p1 - meanWatt_p2 %p_{rec,mean} - p_f in Watt

k = p_m/p_f

%second method
sigma_p = std(watt_p1);

k_2 = ((sigma_p/p_f)^2 - 1)/2

%k_3 = meanWatt_p1/p_f -1

%sigma_p2 = p_f * sqrt(1 + 2*k_3)

%% Histograms

figure
hold on
cdfplot(watt_p1)
title('Distribution LOS (Rician)')
%xlim([0 16])
hold off

figure
hold on
cdfplot(watt_p2)
title('Distribution NLOS (Rayleigh)')
%xlim([0 16])
hold off

figure
hold on
cdfplot(watt_p1)
cdfplot(watt_p2)
title('CDF Distribution LOS (Rician)')
yline(0.5)
%xlim([0 16])
hold off

% figure
% hold on
% cdfplot((watt_p1)/std(watt_p1))
% cdfplot((watt_p2)/std(watt_p2))
% hold off

figure
hold on
title('CDF Distribution NLOS (Rayleigh)')
histogram(watt_p2/meanWatt_p2,100, 'Normalization','cdf')
yline(0.5)
xline(1.1)
xlim([0 16])
hold off

