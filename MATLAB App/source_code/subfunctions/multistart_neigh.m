function [nextNode, current_node_check,complete_flag,insert_flag, ...
    visited,previous,edges_visited]=multistart_neigh(G,current_node_check,previous,...
    completed,visited,edges,nextNode,edges_visited)

complete_flag=0;
insert_flag=0;
neigh_start=neighbors(G,current_node_check(1));
neigh_end=neighbors(G,current_node_check(2));

neigh_start(find(ismember(neigh_start,completed)))=[];
neigh_end(find(ismember(neigh_end,completed)))=[];
neigh_start(find(neigh_start==nextNode))=[];
neigh_end(find(neigh_end==nextNode))=[];



%% ADD CONTROL ON EXISTING EDGES TO BE REMOVED - VISITED_PREV AND MAT2STR

neigh_to_del=[];

for i=1:numel(neigh_start)
    ch_1=current_node_check(1);
    ch_2=neigh_start(i);
    
    A=[ch_1 ch_2];
    B=[ch_2 ch_1];

    if ~isempty(edges_visited) && (any(ismember(edges_visited, A,"rows")) || any(ismember(edges_visited, B,"rows")))
        neigh_to_del=[neigh_to_del neigh_start(i)];
    end
end
neigh_start(find(ismember(neigh_start,neigh_to_del)))=[];

neigh_to_del=[];

for i=1:numel(neigh_end)
    ch_1=current_node_check(2);
    ch_2=neigh_end(i);
    
    A=[ch_1 ch_2];
    B=[ch_2 ch_1];

    if ~isempty(edges_visited) && (any(ismember(edges_visited, A,"rows")) || any(ismember(edges_visited, B,"rows")))
        neigh_to_del=[neigh_to_del neigh_end(i)];
    end
end
neigh_end(find(ismember(neigh_end,neigh_to_del)))=[];


if isempty(neigh_start) & isempty(neigh_end)
    complete_flag=1;
    return;
end

weight_edges=[];
weight_edges_start=[];
weight_edges_end=[];

for k=1:numel(neigh_start)

    % First of all I have to find the corresponding edge to my two
    % nodes (the selected and the k-th neighbor). I will look for
    % correspondence of [current neigh] or [neigh current] in the edges
    % list

    ch_1=current_node_check(1);
    ch_2=neigh_start(k);

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

    weight_edges_start(k)=G.Edges.Weight(matching_rows);

end

for k=1:numel(neigh_end)

    ch_1=current_node_check(2);
    ch_2=neigh_end(k);

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

    weight_edges_end(k)=G.Edges.Weight(matching_rows);

end


[min_weight_start min_weight_start_idx]=min(weight_edges_start);
[min_weight_end min_weight_end_idx]=min(weight_edges_end);

if isempty(min_weight_end)
    nextNode=neigh_start(min_weight_start_idx);
    insert_flag=1;
    previous=current_node_check(1);
    current_node_check=nextNode;
elseif min_weight_start<min_weight_end
    nextNode=neigh_start(min_weight_start_idx);
    insert_flag=1;
    previous=current_node_check(1);
    current_node_check=nextNode;
elseif isempty(min_weight_start)
    nextNode=neigh_end(min_weight_end_idx);
    insert_flag=0;
    previous=current_node_check(2);
    current_node_check=nextNode;
elseif min_weight_end<=min_weight_start
    nextNode=neigh_end(min_weight_end_idx);
    insert_flag=0;
    previous=current_node_check(2);
    current_node_check=nextNode;
end

visited=[visited previous];

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