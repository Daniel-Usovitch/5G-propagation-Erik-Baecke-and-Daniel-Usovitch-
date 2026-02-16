function [ptsI, rayon_poss] = trajectoire_rayons(murs, TXp, RX, nrefl)
   ptsI = zeros(3, nrefl);
    for i=1:nrefl
        ind_mur = TXp(3,nrefl+1-i);
        mur = murs{ind_mur};
        if i == 1
            ptsI(:,i) = [point_intersection(mur, RX, TXp(1:2,nrefl)); ind_mur];
        else
            ptsI(:,i) = [point_intersection(mur, ptsI(1:2,i-1), TXp(1:2,nrefl+1-i)); ind_mur];
        end
    end
    rayon_poss = 1; %indique si la trajectoire du rayon est possible
    inter = intersection(murs{ptsI(3,1)}, ptsI(1:2,1), RX, TXp(1:2,nrefl));
    if inter == 0
        rayon_poss = 0;
    end
    for j=2:nrefl
        mur = murs{ptsI(3,j)};
        inter = intersection(mur, ptsI(1:2,j), ptsI(1:2,j-1), TXp(1:2,nrefl+1-j));
        if inter == 0
            rayon_poss = 0;
        end
    end
end