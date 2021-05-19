clear
alpha = 0.05;
maxtau = 50;
display = 1;

data = xlsread('VideoViews.xlsx');
dataset1 = data(:, 6);
dataset2 = data(:, 16);

%% A
figure
plot(dataset1)
title('Timeseries A');
figure
subplot(2, 1, 1)
autocorr(dataset1, 'NumLags', 50);
subplot(2, 1, 2)
parcorr(dataset1, 'NumLags', 50);
% autocorrelation_graph(dataset1, alpha, maxtau, 'Timeseries A');
% parautocorrelation_graph(dataset1, alpha, maxtau, 'Timeseries A');

xV1 = diff(sqrt(dataset1), 1);
sV1 = seasonalcomponents(xV1, 7);
xV1 = xV1 - sV1;
figure
plot(xV1);
figure
subplot(2, 1, 1)
autocorr(xV1, 'NumLags', 50);
subplot(2, 1, 2)
parcorr(xV1, 'NumLags', 50);
[~, ~, aic] = aic_graph(xV1, maxtau);

%%% Fit MA(1)
[nrmseV,phiV,thetaV,~,aicS,~,~] = fitARMA(xV1,0,1, maxtau);
fprintf('NRMSE value for timeseries A: %.2f\n', nrmseV(1));
xV11 = generateARMAts(phiV,thetaV, length(xV1), 1);
residuals1 = (xV1) - (xV11);
figure
autocorr(residuals1);

detectV1 = popularitydetection(xV1, 2, 4, 0, 1);
figure
plot(dataset1)
hold on
for i = 1:length(detectV1)
    xline(detectV1(i), '--r')
end
hold off

%%% Non-linear Analysis
maxtaunl = 10;
[mutM] = mutualinformation(xV1, maxtaunl);
tau1 = 2;
fnnM = falsenearest(xV1, tau1, maxtaunl);
for i = 1:length(fnnM)
    if isnan(fnnM(i, 2))
        fnnM(i, 2) = 0;
    end
end
figure
plot(fnnM(:, 2), '-o');
title('False Nearest Neighbour (τ = 2)');
xlabel('m');
m1 = 4;
xM_embedded = embeddelays(xV1, m1, tau1);
[nrmseV,preM] = localfitnrmse(xV1,tau1,m1,maxtaunl,1,0,'NRMSE for Timeseries A');
nnei = 5;
Tnl = 4;
anl = 2;
detectV1nl = popularitydetectionnl(dataset1, xV1, anl, Tnl, m1, tau1, nnei);
title(sprintf('Number of Neighbours %d, T = %d, a = %d*s', nnei, Tnl, anl));

%% B
figure
plot(dataset2)
title('Timeseries B');
subplot(2, 1, 1)
autocorr(dataset2, 'NumLags', 50);
subplot(2, 1, 2)
parcorr(dataset2, 'NumLags', 50);
% autocorrelation_graph(dataset2, alpha, maxtau, 'Timeseries B');
% parautocorrelation_graph(dataset2, alpha, maxtau, 'Timeseries B');

xV2 = diff(sqrt(dataset2));
figure
plot(xV2)
title('Timeseries B');
figure
subplot(2, 1, 1)
autocorr(xV2, 'NumLags', 50);
subplot(2, 1, 2)
parcorr(xV2, 'NumLags', 50);
[~, ~, aic] = aic_graph(xV2, maxtau);
% autocorrelation_graph(xV2, alpha, maxtau, 'Timeseries B');
% parautocorrelation_graph(xV2, alpha, maxtau, 'Timeseries B');

%%% Fit MA(1)
[nrmseV,phiV,thetaV,~,aicS,~,armamodel] = fitARMA(xV2,0,1, 1);
xV22 = generateARMAts(phiV,thetaV, size(dataset2, 1)-1, 1);
residuals2 = xV2 - xV22;
autocorrelation_graph(residuals2, alpha, maxtau, 'Residuals');

detectV2 = popularitydetection(xV2, 1.5, 4, 0, 1);
figure
plot(dataset2)
hold on
for i = 1:length(detectV2)
    xline(detectV2(i), '--r')
end
hold off

%%% Non-linear Analysis
maxtaunl = 10;
[mutM] = mutualinformation(xV2, maxtaunl);
tau2 = 2;
fnnM = falsenearest(xV2, tau2, maxtaunl);
for i = 1:length(fnnM)
    if isnan(fnnM(i, 2))
        fnnM(i, 2) = 0;
    end
end
figure
plot(fnnM(:, 2), '-o');
title('False Nearest Neighbour (τ = 2)');
xlabel('m');
m2 = 6;
xM_embedded = embeddelays(xV2, m2, tau2);
[nrmseV,preM] = localfitnrmse(dataset2, xV2,tau2,m2,maxtaunl,1,0,'NRMSE for Timeseries A');
nnei2 = 5;
Tnl2 = 4;
anl2 = 2;
detectV2nl = popularitydetectionnl(dataset2, xV2, anl2, Tnl2, m2, tau2, nnei2);
title(sprintf('Number of Neighbours %d, T = %d, a = %d*s', nnei2, Tnl2, anl2));
