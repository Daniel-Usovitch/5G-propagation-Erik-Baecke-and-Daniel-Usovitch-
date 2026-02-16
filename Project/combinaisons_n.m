function [comb, ind] = combinaisons_n(nmurs, nrayons, nrefl) 
%fonction qui calcule les combinaisons de n réflexions
    ind = 1;
    i = 0;
    comb = zeros(nrayons, nrefl);
    vec = zeros(1,nrefl); %pour stocker les valeurs
    [comb, ind] = combinaisons_rec(comb, nmurs, nrefl, i, ind, vec);
end