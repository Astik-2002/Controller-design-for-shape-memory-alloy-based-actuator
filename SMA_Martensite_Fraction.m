%martensite fraction
%based on :https://github.com/gabrielegilardi/FingerControl/blob/master/Code_Matlab/SMA1_Martensite_Fraction.m
function E = SMA_Martensite_Fraction(T,dTdt,sigma)

global As Af Ms Mf aA bA cA aM bM cM
global Es1 Ef1 Esave1

% As-Austetite starting temp
% Af-Austetite final temp
% Ms-Martensite starting temp
% Mf-Martensite final temp
% aA = pi/(Af-As)
% bA = -aA/cA
% cA and bA are curve fitting params for heating
% aM = pi/(Mf-Ms)
% bM = -aM/cM
% cM and bM are curve fitting params for cooling
% - T and dTdt are temp and rate of change of temp respectively, obtained
% using heat transfer function
% - sigma is the stress developed in the wire

% Bounds
Lm = Ms + sigma/cM; 
Um = Mf + sigma/cM;
La = Af + sigma/cA;
Ua = As + sigma/cA;

kA = cos( aA*(T-As) + bA*sigma );
kM = cos( aM*(T-Mf) + bM*sigma );

% Heating phase
if (dTdt > 0)

    if ( T < Ua )
        E = Es1;
    elseif ( (T >= Ua) && (T <= La) )
        E = (Es1/2)*( kA + 1.0 );
    else
        E = 0.0;
    end

    if (T < Lm)
        Ef1 = ( 2*E - (1+kM) ) / (1-kM);
    else
        Ef1 = E;
    end
    
end

% Cooling phase
if (dTdt < 0)

    if ( T > Lm )
        E = Ef1;
    elseif ( (T <= Lm) && (T >= Um) )
        E = ((1-Ef1)/2)*kM + (1+Ef1)/2;
    else
        E = 1.0;
    end

    if (T > Ua)
        Es1 = 2*E /( kA + 1.0 );
    else
        Es1 = E;
    end

end

% If temperature constant martensite fraction does not change
if (phase == 0) 
    E = Esave1;
end

Esave1 = E;

% End of function