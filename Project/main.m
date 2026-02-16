clear; close; clc;



%% constantes for project

 f = (26*10^9); % 5G 26GHz
 omega = (2*pi*f);
 epsilon0 = (8.85*10^-12);
 mu0 = (4*pi*10^-7);
 c = (3*10^8);
 Z0 = sqrt(mu0/epsilon0);
 beta = (omega/c);
 lambda = (c/f);
 Ra = 73;

%% constantes for tp8.1

%f = (868.3*10^6); % 5G 26GHz
%omega = (2*pi*f);
%epsilon0 = (8.85*10^-12);
%mu0 = (4*pi*10^-7);
%c = (3*10^8);
%Z0 = sqrt(mu0/epsilon0);
%beta = (omega/c);
%lambda = (c/f);
%Ra = 73;


%% Emetteurs for projects
 % TX1
 puissanceTX1 = 20; %en dbm
 gainTX1 = 1; 
 PtxGtxTX1 = gainTX1*10^((puissanceTX1-30)/10);
 facteurTX1 = 60*lambda^2*PtxGtxTX1/(8*pi^2*Ra);
 
 % TX2
 puissanceTX2 = 35; %en dbm
 gainTX2 = 1.7; 
 PtxGtxTX2 = gainTX2*10^((puissanceTX2-30)/10);
 facteurTX2 = 60*lambda^2*PtxGtxTX2/(8*pi^2*Ra);
 
 % TX3
 puissanceTX3 = 35; %en dbm
 gain_max = 21.5836; %en db
 delta = -0.3; %en radians
 phi_3db = (30*pi/180); %en radians
 Ptx3 = 10^((puissanceTX3-30)/10);
 facteurTX3 = 60*lambda^2*Ptx3/(8*pi^2*Ra);


%% Emetteurs for tp 8.1 

%TX 
 %PtxGtxTX = 60*1.64*10^-3;
 %facteurTX = lambda^2*PtxGtxTX/(8*pi^2*Ra);


%% Configuration de la piece for project

murs = {[[0;-45],[75;-45],[5;0.014]],[[75;-45],[75;-70],[5;0.014]],...
    [[75;-70],[100;-70],[5;0.014]],[[100;-70],[100;0],[4.6;0.02]],...
     [[100;0],[0;0],[4.6;0.02]],[[0;0],[0;-45],[4.6;0.02]],...
     [[15;0],[15;-4],[2.25;0.04]],[[15;-5],[15;-13],[2.25;0.04]],...
     [[15;-14],[15;-22],[2.25;0.04]],[[15;-23],[15;-31],[2.25;0.04]],...
     [[15;-32],[15;-40],[2.25;0.04]],[[15;-41],[15;-45],[2.25;0.04]],...
     [[0;-9],[15;-9],[2.25;0.04]],[[0;-18],[15;-18],[2.25;0.04]],...
     [[0;-27],[15;-27],[2.25;0.04]],[[0;-36],[15;-36],[2.25;0.04]],...
     [[35;-20],[40;-15],[2.25;0.04]],[[50;-15],[55;-20],[2.25;0.04]],...
     [[50;-35],[55;-30],[2.25;0.04]],[[35;-30],[40;-35],[2.25;0.04]],...
     [[85;0],[85;-12.8398],[4.6;0.02]],[[85;-14.8398],[85;-27.6796],[4.6;0.02]],...
     [[75;-45],[85;-27.6796],[4.6;0.02]],[[85;-27.6796],[91.5;-27.6796],[4.6;0.02]],...
     [[93.5;-27.6796],[100;-27.6796],[4.6;0.02]]};  
  
 nmurs = numel(murs); %nombre de murs
 nrefl = 1; %nombre de reflexions
 TX3 = [-10;0.55]; %fixé
 n = 2; %nombre de pas par mètre
 X = 100; %x max
 Y = 0.5; %y max
 Xm = -10; %x min
 Ym = -70; %y min



%% configuration for tp8.1

%murs = {[[0;0], [0;80], [4.8;0.018]], [[0;20], [80;20], [4.8;0.018]], [[0;80], [80;80], [4.8;0.018]]};

%nmurs = numel(murs); %nombre de murs
%nrefl = 4; %nombre de reflexions
%n = 10; %nombre de pas par mètre
%X = 80; %x max
%Y = 80; %y max
%Xm = 0; %x min
%Ym = 0; %y min
%TX = [32;10];

tic %mesure temps debut

nrayons = nombre_rayons(nmurs, nrefl); %calcul nombre rayons max
puissances_dbm = zeros(n*(Y-Ym)+1, n*(X-Xm)+1); %matrice des puissances
debit = zeros(n*(Y-Ym)+1, n*(X-Xm)+1); %matrice des débits
TXs = zeros(2,3);

%% TX for tp8.1

 %TXs(:,1) = TX;
 %k = 1;
 %RX = [47;65];
 %[Prx] = calcul_puissanceRX_TP8(murs, nmurs, nrayons, nrefl, TX, Z0, ...
  %  beta, omega, epsilon0, mu0,RX,facteurTX) ;
 %fprintf('%s Watt est la puissance en (47,65).\n',Prx)
 %[puissances_dbm] = calcul_puissances_TP8(murs, nmurs, nrayons, nrefl, TX, n, Ym, Y, Xm, X, Z0, ...
  %  beta, omega, epsilon0, mu0, puissances_dbm, facteurTX,TXs, k);



%% TX3
 TXs(:,1) = TX3;
 k = 1;
 [puissances_dbm]  = calcul_puissances(murs, nmurs, nrayons, nrefl, TX3, n, Ym, Y, Xm, X, Z0, ...
    beta, omega, epsilon0, mu0, puissances_dbm, 0, facteurTX2, gain_max, delta, phi_3db, TXs, k);

%% TX1
 TX1_1 = [45;-25];
 TXs(:,2) = TX1_1;
 k = 2;
 [puissances_dbm]  = calcul_puissances(murs, nmurs, nrayons, nrefl, TX1_1, n, Ym, Y, Xm, X, Z0, ...
     beta, omega, epsilon0, mu0, puissances_dbm, 0, facteurTX1, gain_max, delta, phi_3db, TXs, k);
 
TX1_2 = [99;-29];
 TXs(:,3) = TX1_2;
 k = 3;
 [puissances_dbm]  = calcul_puissances(murs, nmurs, nrayons, nrefl, TX1_2, n, Ym, Y, Xm, X, Z0, ...
     beta, omega, epsilon0, mu0, puissances_dbm, 0, facteurTX1, gain_max, delta, phi_3db, TXs, k);
 
 %verification puissance maximale
 for i=1:45*n
       for j=10*n:n*110 + 1
            if puissances_dbm(i,j) > -30 
             disp('Erreur: exposition onde admise dépassée !')
           end
      end
 end
 for i=n*45+1:n*70+1
     for j=85*n:n*110 + 1
         if puissances_dbm(i,j) > -30 
             disp('Erreur: exposition onde admise dépassée !')
         end
     end
 end
 
 %calcul debit
  for ind_y=1:n*(Y-Ym)+1
      for ind_x=1:n*(X-Xm)+1 
          debit(ind_y,ind_x) = 15*(puissances_dbm(ind_y,ind_x)+80)+50;
     end
  end

min_dbm = round(min(puissances_dbm(:)));  
max_dbm = round(max(puissances_dbm(:)));
extremums = [100, 350]; %minimum = débit minimal que les robots puissent fonctionner correctement.

hold on; 
figure(1) 
imagesc([Xm,X], [Ym,Y], debit, extremums); %dessine le graphe de la repartition de débit
c = colorbar;
xlabel('mètre'); ylabel('mètre');c.Label.String = 'Débit [MB/s]';
set(gca,'YDir','normal') %sinon inversion axe Y
dessine_murs(murs); %dessine les murs
hold on;
figure(2)
imagesc([Xm,X], [Ym,Y], puissances_dbm, [-100, -30]); %dessine le graphe de la repartition de puissance
d = colorbar;
d.Label.String = 'Puissance[Dbm]';
xlabel('mètre'); ylabel('mètre');
set(gca,'YDir','normal') %sinon inversion axe Y
dessine_murs(murs); %dessine les murs


toc %mesure temps fin