%x=[1 2 99 91 4000 4005]';
x=[3 4 3 2 1; 4 3 5 1 1;3 5 3 3 3; 2 1 3 3 2;1 1 3 2 3];
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
beta2=2;
prevdisbar2=zeros(n,m);
comparison4=1;


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
while comparison2==1
    
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
                 mf1(12,j,k)=0;
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
while comparison2==1
    
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

disp(mf1);
disp(mf2);