tic

data=split(importdata('iris dataset.txt'),",");
 size(data);
 X=data(:,1:4);
 Y=data(:,5);
 x=str2double(X);
beta1=2;
beta2=5;
p=2:0.1:5;
c=(beta1+beta2)/2;
sig=(beta2-beta1)/7;
syms m;
gauss(m)=gaussmf(m,[sig c]);
boss=matlabFunction(gauss);
gaussinv=finverse(gauss);
F=matlabFunction(gaussinv);
L=zeros(5,2);
update=0.01;
for I=1:5
        L(I,1)=beta1+beta2-F(I/5);
        L(I,2)=F(I/5);
end

i=1;
j=1;
k=120;
mfup=1;
mfdown=0.99;

beta=L;
u=zeros(5,1);
for I=1:5
    u(I,1)=boss(F(I/5));
end

points=zeros(10,1);
alpha=zeros(10,1);

for iter=1:5
%%%%%%%%%%%%%%%%%%%%%major loop%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n=length(x);
p=size(x,2);
Z=x;
m=n;
    %Initalizations for membership function corresponding to beta1
mf1=ones(n,p,m);
prevmf1=ones(n,p,m);
dis1=zeros(n,p,m);
disbar1=zeros(n,p,m);
devbar1=zeros(n,m);
dev1=zeros(n,p,m);
prevdisbar1=zeros(n,m);
comparison2=1;

%Initializations for membership function corresponding to beta2
mf2=ones(n,p,m);
prevmf2=ones(n,p,m);

disbar2=zeros(n,p,m);
devbar2=zeros(n,m);
dev2=zeros(n,p,m);
prevdisbar2=zeros(n,m);
comparison4=1;

%initializing dis and disbar

for J=1:n
    dis1(:,:,J)=abs(x-Z(J,:));
end
        disbar1=squeeze(sum(dis1,2)/p);
        disbar2=disbar1;

%iterations
for l=1:20
    
sum21=sum((dis1.*prevmf1),2);
sum31=sum(prevmf1,2);
disbar1=sum21./sum31;

sum22=sum((dis1.*prevmf2),2);
sum32=sum(prevmf2,2);
disbar2=sum22./sum32;

B1=repmat(disbar1,1,p,1);
B2=repmat(disbar2,1,p,1);

dev1=abs(dis1-B1);
dev2=abs(dis1-B2);

devbar1=(sum(dev1,2))/p;
devbar2=(sum(dev2,2))/p;


    mf1=exp(1).^((dev1.^beta(iter,1))./B1.^beta(iter,1));
    mf2=exp(1).^((dev2.^beta(iter,2))./B2.^beta(iter,2));

prevmf1=mf1;
prevmf2=mf2;
comparison2=0;

G1=abs(prevdisbar1(I,K)-disbar1(I,K));
G2=abs(prevdisbar2(I,K)-disbar2(I,K));

if sum(sum(G1>0.01))~=0 || sum(sum(G1>0.01))~=0
    comparison2=1;
end

prevdisbar1=disbar1;
prevdisbar2=disbar2;

end

     points(iter,1)= mf1(i,j,k);
     points(11-iter,1)= mf2(i,j,k);
     alpha(iter,1)=u(iter);
     alpha(11-iter,1)=u(iter);
 
 %%%%%%%%%%%%%%%%%%%major loop%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
end
 
count=0;
var=points(1);
for i=1:9
    if points(i)==var
        count=count+1;
    end
end

if count==9
    secgrade=0;  %%%%%%%%% but actually it should be 1 at x axis =points(i)
else
secgrade = fit(points,alpha,'gauss3');
end

mftemp=mfdown;

sum5=0;
sum6=0;

if count~=9
     while mfdown<=mftemp && mftemp<=mfup
          disp("hey");
        sum5= sum5+ mftemp*secgrade(mftemp);
        sum6= sum6 + secgrade(mftemp);
        mftemp=mftemp+update;
      end
else
    sum5=1;
    sum6=1;
end

toc
time=toc;
