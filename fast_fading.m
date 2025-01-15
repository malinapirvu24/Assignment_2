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
meanWatt_p1 = mean(watt_p1);
meanWatt_p2 = mean(watt_p2);

figure
hold on
histogram(watt_p1, 100)
title('P_1')
ylabel('Frequency')
xlabel('Power (W)')
xlim([0 5e-6])
ylim([0 1000])
hold off

figure
hold on
histogram(watt_p2, 100)
title('P_2')
ylabel('Frequency')
xlabel('Power (W)')
xlim([0 5e-6])
ylim([0 1000])
hold off

p_f = meanWatt_p2; %in Watt
p_m = meanWatt_p1 - meanWatt_p2; %p_{rec,mean} - p_f in Watt

k = p_m/p_f;

%second method
sigma_p = std(watt_p1);

k_2 = ((sigma_p/p_f)^2 - 1)/2

%% Histograms

figure
hold on
cdfplot(watt_p1)
title('Distribution LOS (Rician)')
hold off

figure
hold on
cdfplot(watt_p2)
title('Distribution NLOS (Rayleigh)')
hold off

figure
hold on
cdfLOS = cdfplot(watt_p1);
cdfNLOS = cdfplot(watt_p2);
title('Both distributions')
legend('LOS','NLOS')
yline(0.5)
hold off

%Find the value for which the CDF of the LOS is 50%
cdfLOSx = cdfLOS.XData;
cdfLOSy = cdfLOS.YData;
WattLOS = cdfLOSx(cdfLOSy == 0.5);

cdfNLOSx = cdfNLOS.XData;
cdfNLOSy = cdfNLOS.YData;

percentvalueNLOS = cdfNLOSy(cdfNLOSx >= WattLOS(1));
disp(percentvalueNLOS(1))

figure
hold on
cdfLOS = cdfplot(watt_p1);
cdfNLOS = cdfplot(watt_p2);
title('Both distributions with lines')
legend('LOS','NLOS')
yline(0.5, '-' ,'DisplayName', '50%')
xline(WattLOS(1), ':', 'DisplayName', '0,88 \muW')
yline(percentvalueNLOS(1), '--', 'DisplayName', '97.38%')
hold off

%% Question 5

f = 5e3; %MHz
b = 200e6; %Hz
k_b = 1.38e-23;
T = 17 + 273; %Kelvin

N = k_b*T*b;

SNR_min = 10*log10(WattLOS(1)/N); %dB