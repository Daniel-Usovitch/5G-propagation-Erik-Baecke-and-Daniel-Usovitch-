function TXp = images_nreflexions(murs, comb_n, TX, nrefl) 
%calcule les images de TX pour n reflexions
    TXp = zeros(3, nrefl);
    for i=1:nrefl
        ind_mur = comb_n(1,i);
        mur = murs{ind_mur};
        if i == 1
            TXp(:,i) = [image_TX(TX, mur); ind_mur];     
        else
            TXp(:,i) = [image_TX(TXp(1:2,i-1), mur); ind_mur];
        end
    end
end