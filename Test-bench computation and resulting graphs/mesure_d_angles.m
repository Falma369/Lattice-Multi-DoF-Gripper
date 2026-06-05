%% 1. Paramètres (Chemins à modifier)
dossierImages = 'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Photos_symetrique'; 

% Liste des chemins pour chaque origine (Type 0, 1, 2, 3, 4)
% Ajoute les 5 chemins ici :
cheminsOrigines = { ...
    'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Photos_symetrique\0_0_0.jpg', ... % Origine pour Type 0
    'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Photos_symetrique\1_15_0.jpg',   ... % Origine pour Type 1
    'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Photos_symetrique\2_31_0.jpg',   ... % Origine pour Type 2
    'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Photos_symetrique\3_54_0.jpg',   ... % Origine pour Type 3
    'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Photos_symetrique\4_73_0.jpg'        % Origine pour Type 4
};

close all

%% 2. Pré-calcul de TOUS les angles de référence
numTypes = length(cheminsOrigines);
anglesOriginesRef = zeros(1, numTypes);

fprintf('Calcul des inclinaisons de référence...\n');
for t = 1:numTypes
    [ang, ~] = detecterAngleOrange(cheminsOrigines{t});
    if isnan(ang)
        warning('Origine non détectée pour le Type %d !', t-1);
    end
    anglesOriginesRef(t) = ang;
    fprintf('Type %d - Angle Zéro : %.2f°\n', t-1, ang);
end

%% 3. Analyse et Affichage Visuel
fichiers = dir(fullfile(dossierImages, '*.jpg'));
nomsFichiers = strings(length(fichiers), 1);
anglesAbsolus = zeros(length(fichiers), 1);
anglesRelatifs = zeros(length(fichiers), 1);

figure('Name', 'Vérification Visuelle', 'Color', 'w', 'Position', [100, 100, 800, 600]);
longueurTrait = 150;

for i = 1:length(fichiers)
    nomFichier = fichiers(i).name;
    cheminComplet = fullfile(dossierImages, nomFichier);
    
    % --- Identifier le Type pour choisir la bonne origine ---
    % On suppose que le titre commence par "Type_" (ex: "0_5_12.jpg")
    parts = split(nomFichier, '_');
    typeImg = str2double(parts{1}); % Récupère le premier chiffre
    
    % --- Analyse ---
    [angleActuel, centreActuel] = detecterAngleOrange(cheminComplet);
    
    % On récupère l'angle origine correspondant (Type 0 est à l'indice 1)
    if ~isnan(typeImg) && typeImg < numTypes
        angleOrigineCourant = anglesOriginesRef(typeImg + 1);
        angleRelatif = angleActuel - angleOrigineCourant;
    else
        angleRelatif = NaN; % Si le type n'est pas reconnu
        angleOrigineCourant = NaN;
    end
    
    % Sauvegarde
    nomsFichiers(i) = string(nomFichier);
    anglesAbsolus(i) = angleActuel;
    anglesRelatifs(i) = angleRelatif;
    
    % --- Affichage Visuel ---
    if ~isnan(angleActuel)
        imshow(imread(cheminComplet)); hold on;
        cx = centreActuel(1); cy = centreActuel(2);
        
        % Trait Actuel (Rouge)
        plot([cx-longueurTrait*cosd(angleActuel), cx+longueurTrait*cosd(angleActuel)], ...
             [cy+longueurTrait*sind(angleActuel), cy-longueurTrait*sind(angleActuel)], 'r-', 'LineWidth', 3);
        
        % Trait Origine Spécifique (Bleu Pointillé)
        if ~isnan(angleOrigineCourant)
            plot([cx-longueurTrait*cosd(angleOrigineCourant), cx+longueurTrait*cosd(angleOrigineCourant)], ...
                 [cy+longueurTrait*sind(angleOrigineCourant), cy-longueurTrait*sind(angleOrigineCourant)], 'b--', 'LineWidth', 2);
        end
        
        title(sprintf('Fichier: %s\nType détecté: %d | Relatif: %.2f°', ...
            nomFichier, typeImg, angleRelatif), 'Interpreter', 'none');
        pause(0.5); % Un peu plus rapide
        hold off;
    end
end

%% 4. Résultat final
Resultats = table(nomsFichiers, anglesAbsolus, anglesRelatifs);
disp(Resultats);

%% FONCTION LOCALE
function [angle, centre] = detecterAngleOrange(cheminImage)
    angle = NaN; centre = [NaN, NaN];
    try
        img = imread(cheminImage);
        hsv = rgb2hsv(img);
        mask = (hsv(:,:,1) > 0.04 & hsv(:,:,1) < 0.14) & (hsv(:,:,2) > 0.4);
        mask = bwareaopen(mask, 150); 
        stats = regionprops(mask, 'Orientation', 'Area', 'Centroid');
        if ~isempty(stats)
            [~, maxIdx] = max([stats.Area]);
            angle = stats(maxIdx).Orientation;
            centre = stats(maxIdx).Centroid;
        end
    catch
    end
end