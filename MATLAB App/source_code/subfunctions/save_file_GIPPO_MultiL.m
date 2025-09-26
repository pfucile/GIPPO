function save_file_GIPPO_MultiL(selected,TextArea)

% Open file selection dialog
[filename, filepath] = uiputfile('*.txt', 'Select or create a file');

% Check if the user canceled the operation
if isequal(filename, 0) || isequal(filepath, 0)
    disp('Operation canceled.');
    return;
end

[~,name_OG,ext]=fileparts(filename);

for j=1:numel(selected)
    
    to_save=selected{j};

    new_name = sprintf('_Layer_%02d', j);
    layerName=append(name_OG,new_name,ext);
    
    % Combine file path and file name
    full_file_path = fullfile(filepath, layerName);
    
    % Open the file for writing
    fileID = fopen(full_file_path, 'w');
    
    % Check if the file is opened successfully
    if fileID == -1
        error('Cannot open file for writing: %s', full_file_path);
    end
    
    % Loop through the cell array and write each cell to the file
    for i = 1:numel(to_save) %Backup final_path_nodes
        % Use fprintf to write each element of the array
        % fprintf(fileID, '%d ', final_path_nodes{i});
        fprintf(fileID, '%d ', to_save{i});
        % Add a newline character after each array
        fprintf(fileID, '\n');
    end
end

% Close the file
fclose(fileID);

set(TextArea,'Value','Optimized path saved')

end