function [X,Y] = alternative_g(BB,AA,n_ex)
%BB, AA cells with empty elements in the same positions
S=length(BB);
X=zeros(1,n_ex);Y=zeros(1,n_ex);c=zeros(S,1);
for s=1:S
    if isempty(BB{s})
        X=X;
        Y=Y;
        c(s)=0;
    else
        X=X+sum(BB{s},1);
        Y=Y+sum(AA{s},1);
        c(s)=size(BB{s},1);
    end
end   
    X=X/sum(c); Y=Y/sum(c);
end