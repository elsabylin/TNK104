% topological sort is used to solve the project network
clc;
clear;

input = fopen("project_network.txt");
n_subtask = fscanf(input,'%d',1);
edge_list = fscanf(input,'%d %d',[2,n_subtask])'; % transposing the matrix so its 2xn

% plot the network
G = digraph(edge_list(:,1), edge_list(:,2));
figure;
plot(G);
title('Project network');

% toplogical sort (taken from lab1)
D = indegree(G); % compute indegree

Q = []; % queue for search
order = []; % topsort order

for i = 1:length(D) % add to queue if indegree is 0
    if D(i) == 0
        Q(end+1) = i; 
    end
end

% implement topsort function
while ~isempty(Q) % while there are still nodes to check
    at = Q(1);
    Q(1) = [];
    order(end+1) = at; % add node to topsort list

    neighbours = successors(G, at); % find the nodes that are affected by node at

    for j = 1:length(neighbours)
        D(neighbours(j)) = D(neighbours(j)) - 1; % decrease indegree by 1

        if D(neighbours(j)) == 0
            Q(end+1) = neighbours(j); % check if updated indegrees are 0
        end
    end
end

% nodes 7 and 10 appear but they are not in the input data 
order = order(ismember(order, unique(edge_list))); % filters out 7 and 10 (unwanted nodes)

disp('Topological sort of project network')
disp(order)

