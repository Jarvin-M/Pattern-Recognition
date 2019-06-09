%---------------------------------
%Question 2
%---------------------------------
f = load("data/kmeans1.mat");
feature_vectors = f.kmeans1;
k =[2,4,8];
%2

for i =1:length(k)
    figure(1);
    prototypes = get_prototypes(feature_vectors,k(i),0);
    [mu,all_means,closest] = kmeans(feature_vectors,prototypes);
    subplot(length(k),1,i); 
    scatter(feature_vectors(:,1), feature_vectors(:,2),[],closest); 
    hold on;
    
    plot(mu(:,1),mu(:,2),'ko','MarkerFaceColor','k'); %finalclusters
    title("Kmeans clustering, K= " +k(i)); 
    hold off;
    
    %3 all intermediate positions of cluster means using plot arrow
    
    
    figure(2);
    subplot(length(k),1,i);
    for ki=1:k(i)
        x_values = squeeze(all_means(ki,1,:)); 
        y_values = squeeze(all_means(ki,2,:));
        xy = [x_values y_values]; % x and y values for each iteraction for given prototype i
        mu_length = length(xy(:,1));
        
        
        for pi=1:(mu_length-1) %iteration to plot the arrow graph
            plot_arrow(xy(pi,1),xy(pi,2), xy(pi+1,1),xy(pi+1,2));
            hold on;
        end
        
    end
    hold off;
    
    
end

%------------
%4
% Plot the function D(k) in a figure and determine the value kopt of k for which D(k) reaches its maximum, 
%kopt = argmax k D(k). This is the optimal number of clusters to be used. Mark the position of kopt in the 
%figure
%----------------
kmax =10;
[J,D, R] = quantization(feature_vectors,kmax,0);

figure();
plot((1:kmax),D);
%xlim([1 kmax]);
hold on;

D_max = max(D);
kopt = find(D == D_max);%kopt = argmax k D(k)
plot(kopt,D_max,'ko','MarkerFaceColor','k');
xlabel("Value of K ");
ylabel('value');
legend("D(k)");
title("Function D(k) as a function of K");
hold off;

%---------------------------------
%5
%Plot the functions J(k) and R(k) simultaneously in one figure using different colors and mark the 
% position of kopt in that figure.
%---------------------------------
figure();

plot((1:kmax),J)
hold on;
plot((1:kmax), R)
hold on;
plot([kopt kopt],[ylim],'k', 'LineWidth',0.8);
%xlim([1 kmax]);
xlabel("Value of K ");
ylabel('value');

title("Functions J(k) and R(k)");
legend("J(k) - Quantization error", "R(k) - Reference function","Kopt");




