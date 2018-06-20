betaT1=[1 10 20 30 40 50 60 70 80 90 100];
acc1=[99.14 89.22 89.22 88.79 88.79 88.79 88.79 88.79 88.79 88.79 88.79];

betaIT2=[1 10 20 30 40 50 60 70 80 90 100];
acc2=[99.14 90.1 90.1 89.7 89.7 89.7 89.7 89.7 89.7 89.7 89.7];

clear y label;
box  on
hold on 

graph1=plot(betaT1,acc1,'blue');
graph2=plot(betaIT2,acc2,'red');
set(graph1,'LineWidth',1.5);
set(graph2,'LineWidth',1.5);
yticks([50 60 70 80 90 100])
scatter(betaT1,acc1,30,'blue');
scatter(betaIT2,acc2,30,'red','filled');
legend('Type-1 AP','Interval Type-2 AP');
ylim([50 100]);

hold off