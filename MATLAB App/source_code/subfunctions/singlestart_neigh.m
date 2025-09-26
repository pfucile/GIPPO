function [nextNode, current_node_check,complete_flag,insert_flag, ...
    visited,previous,edges_visited]=singlestart_neigh(G,current_node_check,previous,...
    completed,visited,edges,edges_visited)

nextNode=0;
insert_flag=0;
complete_flag=0;
neigh=neighbors(G,current_node_check);

neigh(find(ismember(neigh,completed)))=[];

    

%% ADD CONTROL ON EXISTING EDGES TO BE REMOVED - VISITED_PREV AND MAT2STR
neigh_to_del=[];
for i=1:numel(neigh)
    ch_1=current_node_check;
    ch_2=neigh(i);
    
    A=[ch_1 ch_2];
    B=[ch_2 ch_1];

    if ~isempty(edges_visited) && (any(ismember(edges_visited, A,"rows")) || any(ismember(edges_visited, B,"rows")))
        neigh_to_del=[neigh_to_del neigh(i)];
    end
end

neigh(find(ismember(neigh,neigh_to_del)))=[];

if isempty(neigh)
    complete_flag=1;
    return;
end

neigh_edges=[];
weight_edges=[];

for k=1:numel(neigh)
    
    % First of all I have to find the corresponding edge to my two
    % nodes (the selected and the k-th neighbor). I will look for
    % correspondence of [current neigh] or [neigh current] in the edges
    % list

    ch_1=current_node_check;
    ch_2=neigh(k);

    A=[ch_1 ch_2];
    B=[ch_2 ch_1];

    if ~isempty(nonzeros(all(A == edges, 2)))
        logical_index = all(A == edges, 2);
    elseif ~isempty(nonzeros(all(B == edges, 2))) 
        logical_index = all(B == edges, 2);
    end

    matching_rows = find(logical_index);
    
    % Having selected the edges for each couple current/neigh, I will
    % associate the weight to them

    weight_edges(k)=G.Edges.Weight(matching_rows);

end

[min_weight min_weight_idx]=min(weight_edges);

%Preparing for next subpath iteration
nextNode=neigh(min_weight_idx);

insert_flag=0;

visited=[visited current_node_check];
previous=current_node_check;
current_node_check=nextNode;

%% ADDING THE EDGE TO THE VISITED_EDGE ARRAY
% I have to do this for each node added to the subpath. It's needed for
% next iteration checks

ch_1=previous;
ch_2=nextNode;
    
A=[ch_1 ch_2];
B=[ch_2 ch_1];

if ~isempty(nonzeros(all(A == edges, 2)))
    logical_index = all(A == edges, 2);
elseif ~isempty(nonzeros(all(B==edges,2))) 
    logical_index = all(B == edges, 2);
end

matching_rows = find(logical_index);

edges_visited=[edges_visited; edges(matching_rows,:)];

end

