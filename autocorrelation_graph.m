function acxM = autocorrelation_graph(xV, alpha, maxtau, titl)

figure
zalpha = norminv(1-alpha/2);
n = size(xV,1);
acxM = autocorrelation(xV, maxtau);
autlim = zalpha/sqrt(n);
clf
hold on
for ii=1:maxtau
    plot(acxM(ii+1,1)*[1 1],[0 acxM(ii+1,2)],'b','linewidth',1.5)
end
plot([0 maxtau+1],[0 0],'k','linewidth',1.5)
plot([0 maxtau+1],autlim*[1 1],'--c','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--c','linewidth',1.5)
xlabel('\tau')
ylabel('r(\tau)')
title(sprintf('Autocorrelation of %s', titl))