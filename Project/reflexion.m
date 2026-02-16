function gamma_mur = reflexion(mur, ptA, ptB, Z0, beta, omega, epsilon0, mu0) 
%calcul coefficient de reflexion
    [cosi, sini] = calcul_cosi(mur, ptA, ptB); 
    eps_r = mur(1,3);
    sint = (sqrt(1/eps_r)*sini);
    cost = sqrt(1-sint^2);
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
    s = (l/cost);
    gamma_per = (Zm*cosi-Z0*cost)/(Zm*cosi+Z0*cost); %perpendiculaire
    gamma_mur = gamma_per - (1-gamma_per^2)*(gamma_per*exp(-2*gamma*s)*exp(1j*beta*2*s*sint*sini))/...
        (1-(gamma_per^2)*exp(-2*gamma*s)*exp(1j*beta*2*s*sint*sini));
end