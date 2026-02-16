function [Prx] = calcul_puissanceRX_TP8(murs, nmurs, nrayons, nrefl, TX, Z0, ...
    beta, omega, epsilon0, mu0,RX,facteurTX)   
  
      
      E = 0; %initialisation puissance   

      %cas direct
      dist_tot = sqrt((TX(1)-RX(1))^2+(TX(2)-RX(2))^2); %distance parcourue par le rayon
      coefficient = transmission(murs, nmurs, TX, RX, 0, 0, Z0, beta, omega, epsilon0, mu0);
      E = E + coefficient*(exp(-1j*(beta)*dist_tot))/dist_tot;
      Prx = facteurTX*abs(E)^2; 
      if nrefl == 0
      figure(3);
      hold on;
      dessine_murs(murs); 
      dessine_rayons(RX, TX, TX, nrefl,Prx);
      xlabel('mètre'); ylabel('mètre');
      end
              
              %cas avec reflexions

      for refl=1:nrefl %on boucle sur le nombre de reflexions
        comb_n = combinaisons_n(nmurs, nrayons(refl+1), refl); %combinaisons de reflexion
        for i=1:nrayons(refl+1) %trace tous les rayons et calcule les champs/coefficients
          TXp = images_nreflexions(murs, comb_n(i,:), TX, refl); %calcul images pour reflexions donnees
          
          [ptsI, rayon_poss] = trajectoire_rayons(murs, TXp, RX, refl); %donne la trajectoire d'un rayon

          if rayon_poss == 1 %verifie si le rayon est possible
            TXn = TXp(1:2,refl); %derniere image de TX 
            dist_tot = sqrt((TXn(1)-RX(1))^2+(TXn(2)-RX(2))^2); %distance parcourue par le rayon
            coefficient = calcul_coefficient(murs, nmurs, RX, ptsI, TX, refl, Z0, beta, omega, epsilon0, mu0);                   
            if ~isnan(coefficient) %on enlève les cas ou le rayon se reflete 2 fois sur un coin
              E = E + coefficient*(exp(-1j*(beta)*dist_tot))/dist_tot;
              Prx_text = facteurTX*abs(E)^2;  
              figure(3);
              hold on;
              dessine_murs(murs); 
              dessine_rayons(RX, ptsI, TX, refl,Prx_text);
              xlabel('mètre'); ylabel('mètre');
            end
          end
        end
      end

      Prx = facteurTX*abs(E)^2;
end
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
         