function [comb, ind] = combinaisons_rec(comb, nmurs, nrefl, i, ind, vec) 
%fonction qui calcule les combinaisons avec recursivite
    for j=1:nmurs
        if j ~= i
            if nrefl == 1
                vec(1,nrefl) = j;
                comb(ind,:) = vec;
                ind = ind+1;
            else
                vec(1,nrefl) = j;
                k = j;
                [comb, ind] = combinaisons_rec(comb, nmurs, nrefl-1, k, ind, vec);
            end
        end
    end
end