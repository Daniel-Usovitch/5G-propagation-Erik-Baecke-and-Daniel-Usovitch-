function dessine_rayons(RX, ptI, TX, nrefl,Prx)
    for i=1:nrefl+1      
        if i == 1
            line([RX(1),ptI(1,1)],[RX(2),ptI(2,1)])
            text(ptI(1,1),ptI(2,1),num2str(Prx))
            hold on;
        elseif i == nrefl+1
            line([ptI(1,i-1),TX(1)],[ptI(2,i-1),TX(2)])
            hold on;
        else
            line([ptI(1,i-1),ptI(1,i)],[ptI(2,i-1),ptI(2,i)])
            hold on;
        end
    end 
end