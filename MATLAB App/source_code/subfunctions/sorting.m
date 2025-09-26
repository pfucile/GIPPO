function sorted=sorting(path)

 % Get lengths of each cell
cellLengths = cellfun(@length, path);

% Sort indices based on cell lengths
[~, sortedIndices] = sort(cellLengths,'descend');

% Sort the cell array based on sorted indices
sorted = path(sortedIndices);

end