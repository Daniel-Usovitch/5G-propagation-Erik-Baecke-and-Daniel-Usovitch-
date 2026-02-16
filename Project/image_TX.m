function TXp = image_TX(TX, mur) %calcule l'image d'un point TX par rapport à un mur
    normal = normale(mur);
    ptI = point_intersection(mur, TX, TX+normal);
    TXp = TX - 2*(TX-ptI);
end