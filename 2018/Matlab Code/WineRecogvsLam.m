lam1=[0.5 0.6 0.7 0.75 0.8 0.9 0.95 ];
acc1=[80.33 81.46 87.64 88.20 87.64 88.20 88.20];

lam2=[0.5 0.6 0.7 0.75 0.8 0.9 0.95];
acc2=[84.27 84.27 91.57 91.01 89.33 89.83 89.83];

clear y label;
hold on 
plot(lam1,acc1,'red');
plot(lam2,acc2,'blue');
title('Recognition Rate vs Damping Factor(Lambda)');
xlabel('Damping Factor(Lambda)');
%ylabel('Recognition Rate(%)');

scatter(lam1,acc1,'red');
scatter(lam2,acc2,'blue','filled');
legend('Type-1 AP','Interval Type-2 AP');
%legend('Type-2 AP','Type-2 Data','Type-1 AP','Type-1 Data');
ylim([50 100]);
hold off