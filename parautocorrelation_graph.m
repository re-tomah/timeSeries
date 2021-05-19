function pacxM = parautocorrelation_graph(xV, alpha, maxtau, titl)

figure
zalpha = norminv(1-alpha/2);
n = size(xV,1);
acxM = autocorrelation(xV, maxtau);
autlim = zalpha/sqrt(n);
pacxM = parautocor(xV,maxtau);
hold on
for ii=1:maxtau
    plot(acxM(ii+1,1)*[1 1],[0 pacxM(ii)],'b','linewidth',1.5)
end
plot([0 maxtau+1],[0 0],'k','linewidth',1.5)
plot([0 maxtau+1],autlim*[1 1],'--c','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--c','linewidth',1.5)
xlabel('\tau')
ylabel('\phi_{\tau,\tau}')
title(sprintf('Partial Autocorrelation of %s', titl))