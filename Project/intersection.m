function inter = intersection(mur, ptI, ptA, ptB) %détermine si le rayon et le mur s'intersectent
    xI = ptI(1);
    yI = ptI(2);
    xmmin = min(mur(1,1),mur(1,2)); %points extremaux du mur et du rayon 
    xmmax = max(mur(1,1),mur(1,2));
    ymmin = min(mur(2,1),mur(2,2));
    ymmax = max(mur(2,1),mur(2,2));
    xpmin = min(ptA(1),ptB(1));
    xpmax = max(ptA(1),ptB(1));
    ypmin = min(ptA(2),ptB(2));
    ypmax = max(ptA(2),ptB(2));
    if (xmmin<=xI && xI<=xmmax && ymmin<=yI && yI<=ymmax) 
        %on vérifie si le point d'intersection se trouve bien sur le mur
        if  (xpmin<=xI && xI<=xpmax && ypmin<=yI && yI<=ypmax) %et sur le rayon
            inter = 1;
        else
            inter = 0;
        end
    else
        inter = 0;
    end
end