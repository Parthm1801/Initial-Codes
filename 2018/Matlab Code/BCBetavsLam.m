lam1=[0.9 0.91 0.92 0.93 0.94 0.95];
acc1=[65.24 72.1 85.69 82.69 85.26 65.52];

lam2=[0.9 0.91 0.92 0.93 0.94 0.95 0.96];
acc2=[86.83 85.56 85.69 86.83 86.83 86.83 86.83];

lam3=[0.86 0.87 0.88  0.89  0.9 0.91 0.92 0.93 0.94 0.95 0.96];
acc3=[87.12 90.7 88.13 89.13  90.4 86.83 86.56 85.98 86.26 85.54 85.54 ];

clear y label;
hold on 
plot(lam1,acc1,'red');
plot(lam2,acc2,'blue');
plot(lam3,acc3,'green');

title('Recognition Rate vs Lambda');
xlabel('Lambda');
%ylabel('Recognition Rate(%)');

scatter(lam1,acc1,'red');
scatter(lam2,acc2,'blue');
scatter(lam3,acc3,'green','filled');
legend('Crisp','Type-1 AP','Interval Type-2 AP');
%legend('Type-2 AP','Type-2 Data','Type-1 AP','Type-1 Data');
ylim([0 100]);
hold off