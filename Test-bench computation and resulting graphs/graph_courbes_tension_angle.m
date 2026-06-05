%% 1. Paramètres
folderPath = 'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Photos_symetrique'; 
excelFile  = 'C:\1-Tifaine\01_COURS_EPFL_01\2-Master\Projets semestre-master\Lattice Multi-DoF Gripper\Week_9\Excel_photo_symetrique.xlsx';
numTypes   = 5; 
colType    = 1; 
colTension = 2; 
colPhoto   = 3; 

%% 2. Lecture des données Excel
dataMatrix = readmatrix(excelFile); 
allTypes    = dataMatrix(:, colType);
allTensions = dataMatrix(:, colTension);
allPhotos   = dataMatrix(:, colPhoto);

%% 3. Initialisation du Graphique
figure('Color', 'w'); hold on; grid on;
couleurs = [
    0.7, 0.04, 0.6; % Violet
    0.0, 0.8, 0.9; % Bleu
    0.1, 0.8, 0.2; % Vert
    1.0, 0.9, 0.0; % Jaune
    1.0, 0.4, 0.0  % Rouge
];

%% 4. Boucle de traitement
for t = 0:numTypes-1
    indicesLignes = find(allTypes == t);
    tensionsBloc = [];
    anglesBloc = [];
    
    for idx = 1:length(indicesLignes)
        row = indicesLignes(idx);
        numPhoto   = allPhotos(row);
        tensionVal = allTensions(row);
        
        pattern = sprintf('%d_%d_*.jpg', t, numPhoto); 
        listeFichiers = dir(fullfile(folderPath, pattern));
        
        if ~isempty(listeFichiers)
            fileName = listeFichiers(1).name;
            parts = split(fileName, '_');
            if length(parts) >= 3
                angleStr = strrep(parts{3}, '.jpg', '');
                angleVal = str2double(angleStr);
                if ~isnan(angleVal)
                    tensionsBloc(end+1) = tensionVal;
                    anglesBloc(end+1) = angleVal;
                end
            end
        end
    end
    
    if ~isempty(tensionsBloc)
        [tensionsBloc, sIdx] = sort(tensionsBloc);
        anglesBloc = anglesBloc(sIdx);
        
        % Calcul de la valeur des couches (Même logique)
        valeurCouche = 1 + t;
        
        plot(tensionsBloc, anglesBloc, '-o', 'LineWidth', 1.8, ...
             'Color', couleurs(t+1,:), ...
             'DisplayName', ['Layers : ', num2str(valeurCouche)]);
    end
end

%% 5. Mise en forme (Identique pour les deux)
xlabel('Tension [N]', 'FontSize', 12);
ylabel('Resulting angle [°]', 'FontSize', 12);
title('Symmetrical joints :', 'Resulting angle versus applied tensile force (Symmetric)', 'FontSize', 14);

lgd = legend('Location', 'best');
title(lgd, 'nbr of mesh layers'); 

set(gca, 'Box', 'off', 'TickDir', 'out', 'LineWidth', 1, 'FontSize', 10);