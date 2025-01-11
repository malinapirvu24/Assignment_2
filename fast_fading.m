%% Load dataset
clear all 
close all
load("group-02-02-2024-2025.mat")

figure
plot(P_1)
ylabel('dBW')
figure
histogram(P_1)

figure
plot(P_2)
ylabel('dBW')
figure
histogram(P_2)