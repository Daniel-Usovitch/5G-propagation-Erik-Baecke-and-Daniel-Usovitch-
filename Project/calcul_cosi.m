function [cosi, sini] = calcul_cosi(mur, ptA, ptB) 
%fonction calculant le cosinus du rayon incident
    normal = normale(mur);
    d = ptA-ptB;
    cosi = abs(d'*normal/sqrt(d(1)^2+d(2)^2));
    sini = sqrt(1-cosi^2);
end