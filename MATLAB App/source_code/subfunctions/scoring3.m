function score=scoring3(path,G,edges)

score=0;
lengths=[];

length_nodes=cellfun('length',path);
[~,max_length_idx]=max(length_nodes);
longest_path_in_nodes=path{max_length_idx};
longest_mm=0;

total_length=sum(G.Edges.Weight);
num_segments=numel(path);

%% I evaluate the longest subpath and its length
% I need this because a short segment could not be considered short if its
% length (in mm) is higher than the average between this maximum length (in
% mm) and the shortest distance in mm.

for i=1:numel(longest_path_in_nodes)-1

    ch_1=longest_path_in_nodes(i);
    ch_2=longest_path_in_nodes(i+1);
        
    A=[ch_1 ch_2];
    B=[ch_2 ch_1];
    
    if ~isempty(nonzeros(all(A == edges, 2)))
        logical_index = all(A == edges, 2);
    elseif ~isempty(nonzeros(all(B==edges,2))) 
        logical_index = all(B == edges, 2);
    end

    longest_mm=longest_mm+G.Edges.Weight(logical_index);

end

%% Assessment for each subpath of the path

for i=1:numel(path)
    subpath=path{i};

    length_container=0;

    for j=1:numel(subpath)-1

        ch_1=subpath(j);
        ch_2=subpath(j+1);
            
        A=[ch_1 ch_2];
        B=[ch_2 ch_1];
        
        if ~isempty(nonzeros(all(A == edges, 2)))
            logical_index = all(A == edges, 2);
        elseif ~isempty(nonzeros(all(B==edges,2))) 
            logical_index = all(B == edges, 2);
        end

        length_container=length_container+G.Edges.Weight(logical_index);

    end
    
    lengths(i)=length_container;

end

lengths_tot=cellfun('length',path);
lengths_span=unique(lengths_tot);
occurrences=[];

for j=1:numel(lengths_span)
    occurrences(j)=sum(lengths_tot==lengths_span(j));
end

scoring_matrix={};
scoring_matrix=zeros(max(occurrences),length(lengths_span));

for i=1:length(lengths_span)
    array_scoring=find(lengths_tot==lengths_span(i));
    scoring_matrix(1:length(array_scoring),i)=sort(lengths(array_scoring));
end

for k=1:length(lengths_span)
    spanner=nonzeros(scoring_matrix(:,k));
    
    [spannerUn,~,idx_rep]=unique(spanner,'stable');
    counts=histcounts(idx_rep,1:numel(spannerUn)+1);

    for j=1:length(spannerUn)
        score=score + (spannerUn(j)/(total_length*num_segments))*counts(j)*(lengths_span(k)-1);
    end


end

end