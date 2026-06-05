%% 1. Paramètres (Chemins à modifier)
dossierImages = 'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Photos_one_sided'; 
excelFile     = 'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Excel_photo_one_side_RESULTATS.xlsx';

% --- NOUVEAU : Chemin du fichier qui sera créé ---
excelFileResultat = 'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Excel_photo_one_side_RESULTATS.xlsx';

cheminsOrigines = { ...
    fullfile(dossierImages, '0_0.jpg'), ... 
    fullfile(dossierImages, '1_13.jpg'), ...
    fullfile(dossierImages, '2_30.jpg'), ...
    fullfile(dossierImages, '3_52.jpg'), ...
    fullfile(dossierImages, '4_78.jpg'),  ...
    fullfile(dossierImages, '5_100.jpg')  ...
};

close all

%% 2. Lecture de l'Excel existant
opts = detectImportOptions(excelFile);
opts.VariableNamingRule = 'preserve'; 
T_Excel = readtable(excelFile, opts);

% On récupère le nom de la 4ème colonne (même si elle est vide)
if size(T_Excel, 2) >= 4
    nomCol4 = T_Excel.Properties.VariableNames{4};
    % On FORCE la colonne à être un tableau de nombres (double)
    T_Excel.(nomCol4) = nan(height(T_Excel), 1);
else
    % Si la colonne n'existe pas du tout, on la crée proprement
    T_Excel.Angle_Relatif = nan(height(T_Excel), 1);
end

%% 3. Pré-calcul des angles de référence (Origines)
numTypes = length(cheminsOrigines);
anglesOriginesRef = zeros(1, numTypes);

fprintf('Calcul des inclinaisons de référence...\n');
for t = 1:numTypes
    [ang, ~] = detecterAngleOrange(cheminsOrigines{t});
    anglesOriginesRef(t) = ang;
    fprintf('Type %d - Angle Zéro : %.2f°\n', t-1, ang);
end

%% 4. Analyse, Affichage et Mise à jour des données
fichiers = dir(fullfile(dossierImages, '*.jpg'));

figure('Name', 'Vérification Visuelle', 'Color', 'w', 'Position', [100, 100, 800, 600]);
longueurTrait = 150;

for i = 1:length(fichiers)
    nomFichier = fichiers(i).name;
    cheminComplet = fullfile(dossierImages, nomFichier);
    
    % Extraction Type et Numéro de photo depuis le nom : "Type_Num.jpg"
    % On enlève l'extension avant de split
    [~, nameOnly, ~] = fileparts(nomFichier);
    parts = split(nameOnly, '_');
    
    if length(parts) >= 2
        typeImg = str2double(parts{1});
        numPhoto = str2double(parts{2}); 

        % Analyse d'image
        [angleActuel, centreActuel] = detecterAngleOrange(cheminComplet);

        if ~isnan(angleActuel) && ~isnan(typeImg) && (typeImg + 1) <= numTypes
            % Calcul de l'angle relatif
            angleOrigineCourant = anglesOriginesRef(typeImg + 1);
            angleRelatif = angleActuel - angleOrigineCourant;

            % --- MISE À JOUR DANS LA TABLE ---
            % On cherche la ligne où Type (Col 1) et Numéro (Col 3) correspondent
            idxLigne = find(T_Excel{:, 1} == typeImg & T_Excel{:, 3} == numPhoto);

            if ~isempty(idxLigne)
                T_Excel{idxLigne, 4} = angleRelatif; % On écrit dans la 4ème colonne
            end

            % --- AFFICHAGE VISUEL ---
            imshow(imread(cheminComplet)); hold on;
            cx = centreActuel(1); cy = centreActuel(2);
            % Trait rouge (actuel)
            plot([cx-longueurTrait*cosd(angleActuel), cx+longueurTrait*cosd(angleActuel)], ...
                 [cy+longueurTrait*sind(angleActuel), cy-longueurTrait*sind(angleActuel)], 'r-', 'LineWidth', 3);
            % Trait bleu (origine)
            plot([cx-longueurTrait*cosd(angleOrigineCourant), cx+longueurTrait*cosd(angleOrigineCourant)], ...
                 [cy+longueurTrait*sind(angleOrigineCourant), cy-longueurTrait*sind(angleOrigineCourant)], 'b--', 'LineWidth', 2);

            title(sprintf('Fichier: %s\nType: %d | Angle Relatif: %.2f°', nomFichier, typeImg, angleRelatif), 'Interpreter', 'none');
            pause(0.2); 
            hold off;
        end
    end
end

%% 5. Sauvegarde dans un NOUVEL Excel
fprintf('\nAnalyse terminée.\n');
fprintf('Sauvegarde des résultats dans : %s\n', excelFileResultat);

writetable(T_Excel, excelFileResultat);

fprintf('Nouveau fichier créé avec succès !\n');

%% =========================================================================
%  FONCTION LOCALE
% =========================================================================
function [angle, centre] = detecterAngleOrange(cheminImage)
    angle = NaN; centre = [NaN, NaN];
    try
        img = imread(cheminImage);
        hsv = rgb2hsv(img);
        % Ajustement du masque pour le trait orange
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