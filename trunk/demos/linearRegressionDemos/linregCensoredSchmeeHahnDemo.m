
%#author Hannes Bretschneider

%% Load
load failuretime;
% from Schmee and Hahn, "A simple method for regression analysis
% with censored data", technometrics 1979 table 1
y = log10(time);
x = 1000./(temp+273.2);
n = length(y);
censored = false(1,n);
censored(18:end) = true;
uncensored = ~censored;

%% Estimate EM
[model, Ez] = linregCensoredFitEm(x, y, censored);
fprintf('w0 = %5.3f, w1 = %5.3f, sigma = %5.3f\n', ...
  model.w(1), model.w(2), model.sigma);
% These numbers correspond to those on
% p69 of Tanner "Tools for statistical inference"

%% Estimate OLS
X = [ones(n,1) x];
wOLS = X\y;

%% Compute predictions
yhatEM = X*model.w;
yhatOLS = X*wOLS;

%% Plot
figure; hold on;
plot(x, yhatEM, 'r:', 'linewidth', 2);
plot(x, yhatOLS, 'b-', 'linewidth', 2);
plot(x(uncensored), y(uncensored), 'ko', 'markersize', 8, 'linewidth', 2);
plot(x(censored), y(censored), 'rx', 'markersize', 8, 'linewidth', 2);
plot(x(censored), Ez(censored), 'g*', 'markersize', 8, 'linewidth', 2);
legend('EM', 'OLS');
xlabel('inverse temperature')
ylabel('survival time')
title('regression with censored data; red x = censored, green * = predicted')
printPmtkFigure('linregCensoredSchmeeHahn')
