% x=[1 2 99 91 4000 4005]';
 data=split(importdata('iris dataset.txt'),",");
 size(data)
% disp(data)
 X=data(:,1:4);
 Y=data(:,5);
% disp(X)
% disp(Y)
 x=str2double(X);
n=length(x);
p=size(x,2);
Z=x;
m=n;


%Initalizations for membership function corresponding to beta1
mf1=ones(n,p,n);
prevmf1=ones(n,p,n);
dis1=zeros(n,p,m);
disbar1=zeros(n,m);
devbar1=zeros(n,m);
dev1=zeros(n,p,m);
beta1=1;
prevdisbar1=zeros(n,m);
comparison2=1;


%Initializations for membership function corresponding to beta2
mf2=ones(n,p,n);
prevmf2=ones(n,p,n);
dis2=zeros(n,p,m);
disbar2=zeros(n,m);
devbar2=zeros(n,m);
dev2=zeros(n,p,m);
beta2=3;
prevdisbar2=zeros(n,m);
comparison4=1;


%Initializations for overall membership functions
dis=zeros(n,p,m);
disbar=zeros(n,m);
s=zeros(n,m);
mfdown=zeros(n,p,m);
mfup=zeros(n,p,m);
mftemp=zeros(n,p,m);
update=0.001;


%Computations for Membership function corresponding to beta1

%initializing prevmf1
for i=1:n
    for k=1:n
        if(i==k)
        prevmf1(i,:,k)= 0;
        end
    end
end 

%initializing dis1 and disbar1
for i=1:n
        for k=1:m
            if(i~=k)
            sum2=0;
            sum3=0;
                for j=1:p
                    dis1(i,j,k)=abs(x(i,j)-Z(k,j));
                    sum2 =sum2 + dis1(i,j,k);
                end
          disbar1(i,k)= sum2/p;
           end
        end
end


%iterations
% while comparison2==1
    for l=1:50
    for i=1:n
        for k=1:m
            if(i~=k)
                sum2=0;
                sum3=0;
                    for j=1:p
                        dis1(i,j,k)=abs(x(i,j)-Z(k,j));
                        sum2 =sum2 + dis1(i,j,k)*prevmf1(i,j,k);
                        sum3= sum3+ prevmf1(i,j,k);
                    end
                if sum3~=0
                    disbar1(i,k)= sum2/sum3;
                else
                    disbar1(i,k)=0;
              
                end
           end
        end
    end


%Dev1 and devbar1
for i=1:n
  for k=1:m
      if(i~=k)
    sum4=0;
    for j=1:p
      dev1(i,j,k)=abs(dis1(i,j,k)-disbar1(i,k));
      sum4=sum4+dev1(i,j,k);
    end
    devbar1(i,k)=sum4/p;
   end
   end
end


%membershipfunction1
for i2=1:n
  for k=1:m
      if(i2~=k)
         for j=1:p
             if(devbar1(i2,k)~=0)
             mf1(i2,j,k)= exp(-dev1(i2,j,k)^beta1 / devbar1(i2,k)^beta1);
             else
                 mf1(i2,j,k)=0;
             end
         end
      end
   end
end


prevmf1=mf1;
comparison2=0;

for i=1:n
    for k=1:m
        comparison1=abs(prevdisbar1(i,k)-disbar1(i,k));
            if comparison1>0.01
                comparison2 =1;
            end 
    end
end
prevdisbar1=disbar1;

end





%Computations for Membership function corresponding to beta2

%initializing prevmf2
for i=1:n
    for k=1:n
        if(i==k)
        prevmf2(i,:,k)= 0;
        end
    end
end 

%initializing dis2 and disbar2
for i=1:n
        for k=1:m
            if(i~=k)
            sum2=0;
            sum3=0;
                for j=1:p
                    dis2(i,j,k)=abs(x(i,j)-Z(k,j));
                    sum2 =sum2 + dis2(i,j,k);
                end
          disbar2(i,k)= sum2/p;
           end
        end
end


%iterations
% while comparison2==1
    for l=1:50
    for i=1:n
        for k=1:m
            if(i~=k)
                sum2=0;
                sum3=0;
                    for j=1:p
                        dis2(i,j,k)=abs(x(i,j)-Z(k,j));
                        sum2 =sum2 + dis2(i,j,k)*prevmf2(i,j,k);
                        sum3= sum3+ prevmf2(i,j,k);
                    end
                if sum3~=0
                    disbar2(i,k)= sum2/sum3;
                else
                    disbar2(i,k)=0;
              
                end
           end
        end
    end


%Dev2 and devbar2
for i=1:n
  for k=1:m
      if(i~=k)
    sum4=0;
    for j=1:p
      dev2(i,j,k)=abs(dis2(i,j,k)-disbar2(i,k));
      sum4=sum4+dev2(i,j,k);
    end
    devbar2(i,k)=sum4/p;
   end
   end
end


%membershipfunction2
for i2=1:n
  for k=1:m
      if(i2~=k)
         for j=1:p
             if(devbar2(i2,k)~=0)
             mf2(i2,j,k)= exp(-dev2(i2,j,k)^beta2 / devbar2(i2,k)^beta2);
             else
                 mf2(12,j,k)=0;
             end
         end
      end
   end
end


prevmf2=mf2;
comparison4=0;

for i=1:n
    for k=1:m
        comparison3=abs(prevdisbar2(i,k)-disbar2(i,k));
            if comparison3>0.01
                comparison4 =1;
            end 
    end
end
prevdisbar2=disbar2;

end

% disp(mf1);
% disp(mf2);

%Computing overall membership function
for i=1:n
  for k=1:m
    sum5=0;
    sum6=0;
   if i~=k
    for j=1:p
      if mf1(i,j,k)<=mf2(i,j,k)
        mfdown(i,j,k)=mf1(i,j,k);
        mfup(i,j,k)=mf2(i,j,k);
      else
        mfdown(i,j,k)=mf2(i,j,k);
        mfup(i,j,k)=mf1(i,j,k);
      end
    
     [arr1 arr2]= SG(mfup(i,j,k), mfdown(i,j,k), i,j,k);
     mf(i,j,k)=arr1/(arr2*(mfup(i,j,k)-mfdown(i,j,k))); %arr(1,1) is sum5 ; arr(1,2) is sum6
    end
   end
  end
end


%Computing dis and disbar
for i=1:n
   for k=1:m
       if(i~=k)
            sum2=0;
            sum3=0;
                for j=1:p
                    sum2 =sum2 + dis(i,j,k)*mf(i,j,k);
                    sum3= sum3+ mf(i,j,k);
                end
                if sum3~=0
                    disbar(i,k)= sum2/sum3;
                else
                    disbar(i,k)=0;
              
                end
        end
    end
end


%Similarity matrix
for i=1:n
    for k=1:m
        if(i~=k)
            s(i,k)=-disbar(i,k);
        end
    end
end


%calculating max and min of similarity matrix

mins=min(min(s));
maxs=s(1,2);
for i=1:n
    for k=1:m
        if(i~=k && s(i,k)>=maxs)
            maxs=s(i,k);
        end
    end
end

            
%preference values
 for i=1:n
   s(i,i)= (mins - 4.5*(maxs-mins));
end

S=s;


% Initialize messages
N=size(S,1); 
A=zeros(N,N); 
R=zeros(N,N); 
S=(S+(eps*randn(N,N))*(max(S(:))-min(S(:)))); % Remove degeneracies
lam=0.8; % Set damping factor
for i=1:100
    % Compute responsibilities
    Rold=R;
    AS=A+S; 
    [Y,I]=max(AS,[],2);
    for i=1:N 
      AS(i,I(i))=-realmax; 
    end
    [Y2,I2]=max(AS,[],2);
    R=S-repmat(Y,[1,N]);
    for i=1:N 
      R(i,I(i))=S(i,I(i))-Y2(i);
    end
    R=(1-lam)*R+lam*Rold; % Dampen responsibilities

    % Compute availabilities
    Aold=A;
    Rp=max(R,0); 
    for k=1:N 
      Rp(k,k)=R(k,k); 
    end
    A=repmat(sum(Rp,1),[N,1])-Rp;
    dA=diag(A); 
    A=min(A,0); 
    for k=1:N 
      A(k,k)=dA(k);
    end
    A=(1-lam)*A+lam*Aold; % Dampen availabilities
end
E=R+A; % Pseudomarginals
I=find(diag(E)>0); 
K=length(I); % Indices of exemplars
[tmp,c]=max(S(:,I),[],2); 
idx=I(c); % Assignments
%disp(idx)

disp([unique(idx),histc(idx,unique(idx))]);




%%%%%%%%%%% Secondary function %%%%%%%%%%%%%%%%
function [sum5,sum6]=SG(mfup,mfdown,i,j,k)

data=split(importdata('iris dataset.txt'),",");
 size(data)
% disp(data)
 X=data(:,1:4);
 Y=data(:,5);
% disp(X)
% disp(Y)
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
for rownum=1:5
        L(rownum,1)=beta1+beta2-F(rownum/5);
        L(rownum,2)=F(rownum/5);
end

% for i=1:5
%     disp([s(i,1),s(i,2)]);
% end

% 
% hold on        
% plot(p,boss(p));
% for rownum=1:5
%     plot(L(rownum,1),boss(L(rownum,1)),'*');
%     plot(L(rownum,2),boss(L(rownum,2)),'*');
% end
% hold off

beta=L;
u=zeros(5,1);
for rownum=1:5
    u(rownum,1)=boss(F(rownum/5));
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
disbar1=zeros(n,m);
devbar1=zeros(n,m);
dev1=zeros(n,p,m);
prevdisbar1=zeros(n,m);
comparison2=1;


%Initializations for membership function corresponding to beta2
mf2=ones(n,p,m);
prevmf2=ones(n,p,m);
dis2=zeros(n,p,m);
disbar2=zeros(n,m);
devbar2=zeros(n,m);
dev2=zeros(n,p,m);
prevdisbar2=zeros(n,m);
comparison4=1;


% %Initializations for overall membership functions
% dis=zeros(n,p,m);
% disbar=zeros(n,m);
% s=zeros(n,m);


%Computations for Membership function corresponding to beta1

%initializing prevmf1
for rownum=1:n
    for clusternum=1:n
        if(rownum==clusternum)
        prevmf1(rownum,:,clusternum)= 0;
        end
    end
end 

%initializing dis1 and disbar1
for rownum=1:n
        for clusternum=1:m
            if(rownum~=clusternum)
            sum2=0;
            sum3=0;
                for featurenum=1:p
                    dis1(rownum,featurenum,clusternum)=abs(x(rownum,featurenum)-Z(clusternum,featurenum));
                    sum2 =sum2 + dis1(rownum,featurenum,clusternum);
                end
          disbar1(rownum,clusternum)= sum2/p;
           end
        end
end

dis=dis1;
%iterations
for l=1:50
    
    for rownum=1:n
        for clusternum=1:m
            if(rownum~=clusternum)
                sum2=0;
                sum3=0;
                    for featurenum=1:p
                        dis1(rownum,featurenum,clusternum)=abs(x(rownum,featurenum)-Z(clusternum,featurenum));
                        sum2 =sum2 + dis1(rownum,featurenum,clusternum)*prevmf1(rownum,featurenum,clusternum);
                        sum3= sum3+ prevmf1(rownum,featurenum,clusternum);
                    end
                if sum3~=0
                    disbar1(rownum,clusternum)= sum2/sum3;
                else
                    disbar1(rownum,clusternum)=0;
              
                end
           end
        end
    end


%Dev1 and devbar1
for rownum=1:n
  for clusternum=1:m
   if(rownum~=clusternum)
    sum4=0;
    for featurenum=1:p
      dev1(rownum,featurenum,clusternum)=abs(dis1(rownum,featurenum,clusternum)-disbar1(rownum,clusternum));
      sum4=sum4+dev1(rownum,featurenum,clusternum);
    end
    devbar1(rownum,clusternum)=sum4/p;
   end
   end
end


%membershipfunction1
for i2=1:n
  for clusternum=1:m
      if(i2~=clusternum)
         for featurenum=1:p
             if(devbar1(i2,clusternum)~=0)
             mf1(i2,featurenum,clusternum)= exp(-dev1(i2,featurenum,clusternum)^beta(iter,1) / devbar1(i2,clusternum)^beta(iter,1));
             else
                 mf1(i2,featurenum,clusternum)=0;
             end
         end
      end
   end
end


prevmf1=mf1;
comparison2=0;

for rownum=1:n
    for clusternum=1:m
        comparison1=abs(prevdisbar1(rownum,clusternum)-disbar1(rownum,clusternum));
            if comparison1>0.01
                comparison2 =1;
            end 
    end
end
prevdisbar1=disbar1;

end





%Computations for Membership function corresponding to beta2

%initializing prevmf2
for rownum=1:n
    for clusternum=1:n
        if(rownum==clusternum)
        prevmf2(rownum,:,clusternum)= 0;
        end
    end
end 

%initializing dis2 and disbar2
for rownum=1:n
        for clusternum=1:m
            if(rownum~=clusternum)
            sum2=0;
            sum3=0;
                for featurenum=1:p
                    dis2(rownum,featurenum,clusternum)=abs(x(rownum,featurenum)-Z(clusternum,featurenum));
                    sum2 =sum2 + dis2(rownum,featurenum,clusternum);
                end
          disbar2(rownum,clusternum)= sum2/p;
           end
        end
end


%iterations
%while comparison2==1
 for l=1:50   
    for rownum=1:n
        for clusternum=1:m
            if(rownum~=clusternum)
                sum2=0;
                sum3=0;
                    for featurenum=1:p
                        dis2(rownum,featurenum,clusternum)=abs(x(rownum,featurenum)-Z(clusternum,featurenum));
                        sum2 =sum2 + dis2(rownum,featurenum,clusternum)*prevmf2(rownum,featurenum,clusternum);
                        sum3= sum3+ prevmf2(rownum,featurenum,clusternum);
                    end
                if sum3~=0
                    disbar2(rownum,clusternum)= sum2/sum3;
                else
                    disbar2(rownum,clusternum)=0;
              
                end
           end
        end
    end


%Dev2 and devbar2
for rownum=1:n
  for clusternum=1:m
      if(rownum~=clusternum)
    sum4=0;
    for featurenum=1:p
      dev2(rownum,featurenum,clusternum)=abs(dis2(rownum,featurenum,clusternum)-disbar2(rownum,clusternum));
      sum4=sum4+dev2(rownum,featurenum,clusternum);
    end
    devbar2(rownum,clusternum)=sum4/p;
   end
   end
end


%membershipfunction2
for i2=1:n
  for clusternum=1:m
      if(i2~=clusternum)
         for featurenum=1:p
             if(devbar2(i2,clusternum)~=0)
             mf2(i2,featurenum,clusternum)= exp(-dev2(i2,featurenum,clusternum)^beta(iter,2) / devbar2(i2,clusternum)^beta(iter,2));
             else
                 mf2(i2,featurenum,clusternum)=0;
             end
         end
      end
   end
end


prevmf2=mf2;
comparison4=0;

for rownum=1:n
    for clusternum=1:m
        comparison3=abs(prevdisbar2(rownum,clusternum)-disbar2(rownum,clusternum));
            if comparison3>0.01
                comparison4 =1;
            end 
    end
end
prevdisbar2=disbar2;

 end
 

     points(iter,1)= mf1(i,j,k);
     points(11-iter,1)= mf2(i,j,k);
     alpha(iter,1)=u(iter);
     alpha(11-iter,1)=u(iter);
 
 %%%%%%%%%%%%%%%%%%%major loop%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
end
  points(5)=[];
  alpha(5)=[];

  
  count=0;
var=points(1);
for ij=1:9
    if points(ij)==var
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
    if sum5==0 && sum6==0
        sum6=1;
    end
disp([i j k]);
end
% secgrade = fit(points,alpha,'gauss3');
% mftemp=mfdown;
% 
% disp([i j k]);
% sum5=0;
% sum6=0;
% while mfdown<=mftemp && mftemp<=mfup
%           disp("hey");
%         sum5= sum5+ mftemp*secgrade(mftemp);
%         sum6= sum6 + secgrade(mftemp);
%         mftemp=mftemp+update;
%       end
% 
% end
    