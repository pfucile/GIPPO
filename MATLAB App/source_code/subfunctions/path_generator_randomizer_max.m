function [path,edges_visited]=path_generator_randomizer_max(G,edges,nodes,max_length)

path={};
j=1;            % This is the counter of the path array
nodes_subpath=[];
visited=[]; %list of visited nodes during this checking procedure
completed=[];

% I create a logic array of numNodes elements. In the beginning all
% the values will be put to true, but set to false when the node is
% completely visited
logical_flags=true(length(nodes),1);
previous=0;
i=1;
insert_flag=0;      % This has to be 1 if the next node is a neighbor of
                    % the first element of the subpath
                    
first_iter_flag=1;
complete_flag=0;
edges_visited=[];
non_completed=[];
new_start_idx=0;
new_start=0;



while any (logical_flags)

    % Here I check if the current node was a neighbor of the first or last
    % node of the subpath at the previous iteration. In case I will add it
    % on top of the subpath or I will append it.

    if i==1 
        non_completed=find(logical_flags);
        new_start_idx=randperm(length(non_completed),1);
        new_start=non_completed(new_start_idx);
        current_node_check=nodes(new_start);
        i=0;
        non_completed=[];
    elseif i==0 && insert_flag==0 
        current_node_check=unique([nodes_subpath(1),current_node_check],'stable');
        i=0;
    elseif i==0 && insert_flag==1
        current_node_check=unique([current_node_check,nodes_subpath(end)],'stable');
        i=0;
    end

    if first_iter_flag == 1
        nodes_subpath=[nodes_subpath current_node_check];
        first_iter_flag=0;
    elseif insert_flag==1
        nodes_subpath = [nextNode nodes_subpath];
    else
        nodes_subpath = [nodes_subpath current_node_check(end)];
    end


    %% GREEDY EXECUTION

    if numel(nodes_subpath)==max_length
        complete_flag=1;
    elseif numel(current_node_check)==1 && complete_flag==0


        %% MAX

        [nextNode, current_node_check,complete_flag,insert_flag, ...
        visited,previous,edges_visited]=singlestart_neigh_max(G,current_node_check,previous,...
        completed,visited,edges,edges_visited);

    elseif numel(current_node_check)==2 && complete_flag==0

        %% MAX

        [nextNode, current_node_check,complete_flag,insert_flag, ...
        visited,previous,edges_visited]=multistart_neigh_max(G,current_node_check,previous,...
        completed,visited,edges,nextNode,edges_visited);
    end


    if complete_flag==1

        [edges_visited, completed,logical_flags, ...
            nodes]=check_subpath(nodes_subpath,completed,G,...
            logical_flags,nodes,edges_visited);
    
        edges_visited_idxs=find(ismember(edges,edges_visited,'rows'));


        path{j}=nodes_subpath;
        j=j+1;

        current_node_check=[];
        nodes_subpath=[];

        visited=[];
        previous=0;
        i=1;
        complete_flag=0;
        insert_flag=0;

        
        continue
    end


end

end