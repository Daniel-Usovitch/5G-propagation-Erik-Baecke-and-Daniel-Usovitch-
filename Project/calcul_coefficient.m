function coefficient = calcul_coefficient(murs, nmurs, ...
    RX, ptsI, TX, nrefl, Z0, beta, omega, epsilon0, mu0) 
    coefficient = 1;

    %cas derniere reflexion
    mur = murs{ptsI(3,1)};
    gamma_mur = reflexion(mur, RX, ptsI(1:2,1), Z0, beta, omega, epsilon0, mu0);
    coefficient = coefficient*gamma_mur;
   
    %cas dernier segment et premier segment du rayon
    T0 = transmission(murs, nmurs, RX, ptsI(1:2,1), ptsI(3,1), ...
        ptsI(3,1), Z0, beta, omega, epsilon0, mu0);
    coefficient = coefficient*T0;
    T0 = transmission(murs, nmurs, ptsI(1:2,nrefl), TX, ...
        ptsI(3,nrefl), ptsI(3,nrefl), Z0, beta, omega, epsilon0, mu0);
    coefficient = coefficient*T0;
    
    for i=2:nrefl %cas segments intermediaires
        mur = murs{ptsI(3,i)};
        gamma_mur = reflexion(mur, ptsI(1:2,i-1), ptsI(1:2,i), Z0, beta, omega, epsilon0, mu0);
        coefficient = coefficient*gamma_mur; 
        T0 = transmission(murs, nmurs, ptsI(1:2,i-1), ptsI(1:2,i), ...
            ptsI(3,i-1), ptsI(3,i), Z0, beta, omega, epsilon0, mu0);
        coefficient = coefficient*T0;
    end
end