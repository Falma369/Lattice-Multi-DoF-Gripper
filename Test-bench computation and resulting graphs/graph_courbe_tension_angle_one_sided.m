%% 1. Paramètres
folderPath = 'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Photos_one_sided'; 
excelFile  = 'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Excel_photo_one_side_RESULTATS.xlsx';

numTypes   = 6;  % Modifié de 5 à 6
colType    = 1; 
colTension = 2; 
colPhoto   = 3; 
colAngle   = 4; 

%% 2. Lecture des données Excel
dataMatrix  = readmatrix(excelFile); 
allTypes    = dataMatrix(:, colType);
allTensions = dataMatrix(:, colTension);
allAngles   = dataMatrix(:, colAngle);

%% 3. Initialisation du Graphique
figure('Color', 'w'); hold on; grid on;

% Palette de couleurs étendue (6 lignes mtn)
couleurs = [
    0.7, 0.04, 0.6; % Violet (1 layer)
    0.0, 0.8, 0.9; % Bleu   (1.5 layers)
    0.1, 0.8, 0.2; % Vert   (2 layers)
    1.0, 0.9, 0.0; % Jaune  (2.5 layers)
    1.0, 0.4, 0.0; % Orange (3 layers)
    0.8, 0.05, 0.05  % Rouge foncé (3.5 layers) -> AJOUTÉ
];

%% 4. Boucle de traitement
for t = 0:numTypes-1
    indicesLignes = find(allTypes == t);
    
    tensionsBloc = allTensions(indicesLignes);
    anglesBloc   = allAngles(indicesLignes);
    
    validIdx     = ~isnan(tensionsBloc) & ~isnan(anglesBloc);
    tensionsBloc = tensionsBloc(validIdx);
    anglesBloc   = anglesBloc(validIdx);
    
    if ~isempty(tensionsBloc)
        [tensionsBloc, sIdx] = sort(tensionsBloc);
        anglesBloc = anglesBloc(sIdx);
        
        % Calcul dynamique : t=5 donnera 3.5 layers
        valeurCouche = 1 + (t * 0.5);
        
        plot(tensionsBloc, anglesBloc, '-o', 'LineWidth', 1.8, ...
             'Color', couleurs(t+1,:), ...
             'DisplayName', ['Layers : ', num2str(valeurCouche)]);
    end
end

%% 5. Mise en forme
xlabel('Tension [N]', 'FontSize', 12);
ylabel('Resulting angle [°]', 'FontSize', 12);

% Correction du titre multi-ligne avec des accolades {}
title('Asymmetrical joints :', 'Resulting angle versus applied tensile force', 'FontSize', 14);

% --- AJOUT DU TITRE À LA LÉGENDE ---
lgd = legend('Location', 'best');
title(lgd, 'nbr of mesh layers'); 

set(gca, 'Box', 'off', 'TickDir', 'out', 'LineWidth', 1);