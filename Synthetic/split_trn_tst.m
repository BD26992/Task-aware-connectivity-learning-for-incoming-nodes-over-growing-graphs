function [trn,tst] = split_trn_tst(d_aplus,d_bplus,d_xplus,trn_pct,R)
Data=[d_aplus,d_bplus,d_xplus];
ind=randperm(R);
trn_ind=ind(1:(trn_pct*R));tst_ind=ind(trn_pct*R+1:R);
trn=Data(trn_ind,:);tst=Data(tst_ind,:);
end
