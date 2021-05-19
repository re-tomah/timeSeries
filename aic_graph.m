function [p_value, q_value, aic] = aic_graph(xV, maxtau)

figure
min_aic = 10000;
aic = zeros(6, 16);
for q = 0:5
    for p = 0:15
       [~,~,~,~,aicS,~,~]=fitARMA(xV,p,q,maxtau);
       aic(q+1, p+1) = aicS;
       if aicS < min_aic
           min_aic = aicS;
           p_value = p;
           q_value = q;
       end
    end
    hold on
    plot((0:15), aic(q+1, :), '-o');
end

legend('q = 0','q = 1','q = 2','q = 3','q = 4','q = 5')
hold off