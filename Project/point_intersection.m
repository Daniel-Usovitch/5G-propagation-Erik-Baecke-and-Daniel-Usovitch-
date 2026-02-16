function ptI = point_intersection(mur, ptA, ptB) 
%calcul de l'intersection de 2 droites connaissant 2 points de chaque droite
    mx = mur(1,1)-mur(1,2); 
    my = mur(2,1)-mur(2,2);
    px = ptA(1)-ptB(1);
    py = ptA(2)-ptB(2);
    if mx == 0 %mur vertical
        xI = mur(1,1);
        yI = py/px*(xI-ptA(1))+ptA(2); %calcul de y connaissant x
    elseif px == 0 %rayon vertical
        xI = ptA(1);
        yI = my/mx*(xI-mur(1,1))+mur(2,1);
    else %autres cas
        myx = my/mx; %pentes des droites
        pyx = py/px;
        xI = (ptA(2)-pyx*ptA(1)-mur(2,1)+myx*mur(1,1))/(myx-pyx);
        yI = my/mx*(xI-mur(1,1))+mur(2,1);
    end
    ptI = [xI;yI];   
end