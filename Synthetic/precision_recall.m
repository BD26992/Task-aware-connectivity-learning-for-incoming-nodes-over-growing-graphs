function [precision,recall,ppcr]=precision_recall(target,prediction,N)

true_positive=0;true_negative=0;false_positive=0;false_negative=0;

for i=1:N
    
if target(i)==1 && prediction(i)==1
    true_positive=true_positive+1;
elseif target(i)==1 && prediction(i)==0
    false_negative=false_negative+1;
elseif target(i)==0 && prediction(i)==1
    false_positive=false_positive+1;
else
    true_negative=true_negative+1;
end
end

precision=true_positive/(true_positive+false_positive);

recall=true_positive/(true_positive+false_negative);

ppcr=(true_positive+false_positive)/(true_positive+false_positive+true_negative+false_negative);

end
