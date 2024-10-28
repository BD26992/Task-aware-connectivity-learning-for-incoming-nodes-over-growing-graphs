function N_avg = n_links_generated(p,w,N_rep,N)
   for i=1:N_rep%averaging over random sampling
            b_r = zeros(N,1);
            while sum(b_r)==0
                b_r=(rand(N,1)<p);
            end
            a_rel=b_r.*w;
            N_links(i)=nnz(a_rel);
   end
   N_avg=mean(N_links);
end