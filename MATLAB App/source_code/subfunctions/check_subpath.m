function [edges_visited, completed,logical_flags,...
    nodes]=check_subpath(nodes_subpath,completed,G,...
    logical_flags,nodes,edges_visited)

%% check if any of the nodes is completed



for i=1:numel(nodes_subpath)
    
    neigh=neighbors(G,nodes_subpath(i));
    neigh(find(ismember(neigh,completed)))=[];
    neigh_to_del=[];

    for k=1:numel(neigh)

        ch_1=nodes_subpath(i);
        ch_2=neigh(k);
        
        A=[ch_1 ch_2];
        B=[ch_2 ch_1];
    
        if ~isempty(edges_visited) && (any(ismember(edges_visited, A,"rows")) || any(ismember(edges_visited, B,"rows")))
            neigh_to_del=[neigh_to_del neigh(k)];
        end
    end
    neigh(find(ismember(neigh,neigh_to_del)))=[];

    if isempty(neigh)
        completed=[completed nodes_subpath(i)];
    end

end

comp_idx=find(ismember(nodes,completed));
logical_flags(comp_idx)=0;


end