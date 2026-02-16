function dessine_murs(murs) %fonction qui dessine les murs à partir de leur liste
    nmurs = numel(murs);
    for i=1:nmurs
        line(murs{i}(1,1:2), murs{i}(2,1:2),'Color', 'black')
    end
end