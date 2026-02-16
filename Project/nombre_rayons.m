function nrayons = nombre_rayons(nmurs, nrefl)
%calcule le nombre de rayons pour un nombre max de réflexions
    nrayons = zeros(1,nrefl);
    nrayons(1) = 1; %un rayon pour aucune réflexion
    for i=1:nrefl %i est le nombre de réflexions prises en compte
        nrayref = nmurs; %nombre de rayons pour un nombre donné de réflexions
        for j=1:i-1
            nrayref = nrayref*(nmurs-1); 
        end
        nrayons(i+1) = nrayref;
    end
end