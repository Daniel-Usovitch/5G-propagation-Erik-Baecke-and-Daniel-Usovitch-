function T0 = transmission(murs, nmurs, ptA, ptB, ind1, ind2, Z0, beta, omega, epsilon0, mu0) 
%calcul coefficient de transmission pour un segment entre 2 points
    T0 = 1;
    for i=1:nmurs
        if (i ~= ind1 && i ~= ind2) %on exclut les cas ou il y a reflexion
            mur = murs{i};
            eps_r = mur(1,3);
            conductivite = mur(2,3);
            k = (conductivite/omega);
            if eps_r == 4.6 %on regarde quelle est l'epaisseur du mur
                l = 0.3;
            elseif eps_r == 5
                l = 0.5;
            elseif eps_r == 2.25
                l = 0.1;
            else
                l = 0.15;
            end        
            epsilon = (eps_r*epsilon0);
            eps_im = epsilon - 1i*(conductivite/omega);
            gamma = 1i*omega*sqrt(mu0*eps_im);
            Zm = sqrt(mu0/(epsilon-1j*k));
            ptI = point_intersection(mur, ptA, ptB);
            inter = intersection(mur, ptI, ptA, ptB);
            if inter == 1 %cas ou il y a transmission
                [cosi, sini] = calcul_cosi(mur, ptA, ptB);
                sint = sqrt(1/eps_r)*sini; 
                cost = sqrt(1-sint^2);
                s = (l/cost);
                gamma_per = (Zm*cosi-Z0*cost)/(Zm*cosi+Z0*cost);
                T0p = ((1-gamma_per^2)*exp(-gamma*s))/...
                    (1-(gamma_per^2)*exp(-2*gamma*s)*exp(1j*beta*2*s*sint*sini));
                T0 = T0*T0p;
            end
        end
    end
end