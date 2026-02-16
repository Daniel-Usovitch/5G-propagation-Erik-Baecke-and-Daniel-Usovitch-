function normal = normale(mur) %fonction qui calcule la normale normalisée à un mur 
   mx = mur(1,1)-mur(1,2);
   my = mur(2,1)-mur(2,2);
   if my == 0
       normal = [0;1];
   else 
       ny = -mx/my;
       normal = [1;ny];
       normal = normal/sqrt(normal(1)^2+normal(2)^2);
    end
end