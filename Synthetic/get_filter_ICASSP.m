function h = get_filter(profile,alpha,K)
switch profile
    case 'decaying'
        h=flipud((alpha*ones(K+1,1)).^([0:K]'));
    case 'pagerank'
    case 'uniform'
end
end