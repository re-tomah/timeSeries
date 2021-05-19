function detectV = popularitydetection(dataset, alpha, T, p, q)
    trainingset = dataset(1:400, 1);
    i = 401;
    sigma = std(dataset);
    alpha = alpha*sigma;
    detect = zeros(size(dataset, 1)-400, 1);
    detectV = [];
    
    while (i < size(dataset, 1)-T)
        currentset = dataset((i-400):i-1, 1);
        [preV] = predictARMAmultistep(currentset,[],p,q,T,[]);
        s = (1 / T) * sum(abs((dataset((i+1):(i+T), 1) - preV)));
        if s > alpha
            i = i + T;
            detect(i) = 1;
            continue
        end
        i = i + 1;
    end
   
    for i = 1:size(detect, 1)
        if detect(i, 1) == 1
            detectV = [detectV i];
        end
    end
    
    figure
    plot(dataset)
    hold on
    for i = 1:size(detectV, 2)
        xline(detectV(1, i), '--r');
    end
    
end