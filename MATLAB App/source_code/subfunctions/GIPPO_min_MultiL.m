function selected=GIPPO_min_MultiL(DirectoryLoadedCheckBox,...
    PathoptimizedCheckBox,TextArea,...
    SaveOptimizedPathButton)

directory = uigetdir('Select a directory');

if directory == 0
    set(TextArea,'Value','User did not select any directory!')
    return;
end
set(DirectoryLoadedCheckBox,'Value',1)

num_layers_dir=strcat(directory,'\num_layers.txt');
num_layers=load(num_layers_dir);

fig = uifigure;
fig.Position=[1000 200 400 100]
d = uiprogressdlg(fig,'Title','Optimizing your path',...
    'Indeterminate','on');
tic

for j=1:num_layers
    [G,edges,nodes]=inputs_path_multiL(directory,j); 
    numNodes=numel(nodes);
    
    max_length=600;
    n_iter=500;
    
    parfor i=1:n_iter
        [path{i},edges_visited{i}]=path_generator_randomizer_min(G,edges,nodes,max_length);
        score(i)=scoring3(path{i},G,edges);
    end
     [~,selected_idx]=max(score);
     selected_unsorted=path{selected_idx(1)};
     selected{j}=sorting(selected_unsorted);
end

close(d)
close (fig)

t=toc;

string=strcat("Min-based optimization correctly executed in "+t +" seconds !!");

set(TextArea,'Value',string)

set(PathoptimizedCheckBox,'Value',1)

set(SaveOptimizedPathButton,'Visible','on')

end