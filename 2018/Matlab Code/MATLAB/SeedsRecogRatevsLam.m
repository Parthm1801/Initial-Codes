lam1=[0.5 0.6 0.7 0.8 0.9];
acc1=[79.05 78.57 85.2 82.86 84.29];

lam2=[0.5 0.6 0.7 0.8 0.9 ];
acc2=[90.48 80.48 88.10 88.57 88.57];

lam3=[0.5 0.6 0.7 0.8 0.9 ];
acc3=[92.86 90 89.05 89.52 89.52];
clear y label;
box on
hold on 
graph1=plot(lam1,acc1,'green');
graph2=plot(lam2,acc2,'blue');
graph3=plot(lam3,acc3,'red');
set(graph1,'LineWidth',1.5);
set(graph2,'LineWidth',1.5);
set(graph3,'LineWidth',1.5);
yticks([50 60 70 80 90 100])
scatter(lam1,acc1,'green');
scatter(lam2,acc2,'blue');
scatter(lam3,acc3,'red','filled');
legend('Crisp','Type-1 AP','Interval Type-2 AP');
ylim([50 100]);
hold off