lam1=[0.5 0.6 0.7 0.75 0.8 0.9 0.95 ];
acc1=[80.33 81.46 87.64 88.20 87.64 88.20 88.20];

lam2=[0.5 0.6 0.7 0.75 0.8 0.9 0.95];
acc2=[84.27 84.27 91.57 91.01 89.33 89.83 89.83];

clear y label;
box on
hold on 
graph1=plot(lam1,acc1,'green');
graph2=plot(lam2,acc2,'blue');

set(graph1,'LineWidth',1.5);
set(graph2,'LineWidth',1.5);

yticks([50 60 70 80 90 100])
scatter(lam1,acc1,'green');
scatter(lam2,acc2,'blue');

legend('Type-1 AP','Interval Type-2 AP');
ylim([50 100]);
hold off