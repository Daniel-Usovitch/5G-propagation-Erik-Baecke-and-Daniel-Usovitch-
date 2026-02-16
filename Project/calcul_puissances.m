function [puissances_dbm] = calcul_puissances(murs, nmurs, nrayons, nrefl, TX, n, Ym, Y, Xm, X, Z0, ...
    beta, omega, epsilon0, mu0, puissances_dbm, type, facteurTX, gain_max, delta, phi_3db, TXs, k)
  ind_y = 1;
  for y=n*Ym:n*Y
    ind_x = 1;
    for x=n*Xm:n*X
      RX = [(x/n);(y/n)];
      Prx = 0; %initialisation puissance   

      %cas direct
      dist_tot = sqrt((TX(1)-RX(1))^2+(TX(2)-RX(2))^2); %distance parcourue par le rayon
      coefficient = transmission(murs, nmurs, TX, RX, 0, 0, Z0, beta, omega, epsilon0, mu0);
      E = coefficient*(exp(-1j*(beta)*dist_tot))/dist_tot;
      Prx = Prx + abs(E)^2;        
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
              E = coefficient*(exp(-1j*(beta)*dist_tot))/dist_tot;
              if type == 1 %antenne de type TX3
                vect = TX-ptsI(1:2,refl); %premier segment 
                cos_phi = abs([1,0]*vect/sqrt(vect(1)^2+vect(2)^2));
                phi = acos(cos_phi);
                gain_theta = gain_max - 12*((phi-delta)/(phi_3db))^2; %en db
                gainTX3 = 10^(gain_theta/10);
                Prx = Prx + gainTX3*abs(E)^2; 
              else %antennes type TX1 et TX2
                Prx = Prx + abs(E)^2;            
              end
            end
          end
        end
      end 
      
      Prx = 30 + 10*log10(Prx*facteurTX); %dbm = 30+10*log(Prx);
      for u=1:k
        TXx = TXs(1,u);
        TXy = TXs(2,u);
        cercle_exclusion = ((x/n)-TXx)^2 + ((y/n)-TXy)^2;
        if cercle_exclusion <= (0.5)^2
          Prx = -inf;
        end
      end      
      if puissances_dbm(ind_y,ind_x) == 0 || Prx == -inf %matrice vide
        puissances_dbm(ind_y,ind_x) = Prx;
      else
        puissances_dbm(ind_y,ind_x) = max(puissances_dbm(ind_y,ind_x), Prx); 
      end 
      ind_x = ind_x + 1;       
    end
    ind_y = ind_y + 1;
  end
end