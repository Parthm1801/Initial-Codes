%x=[1 2 3; 5 6 7; 3 4 5 ; 3 6 8; 9997 9919 9923; 299 218 224; 9920 9900 9994; 254 272 278 ; 260 198 230];
x=[1 2; 3 4; 4 5; 2 6; 99 100; 98 99; 95 99];

%x=randi(100,10,2);
%x=gpuArray(x);

n=length(x);
p=size(x,2);
Z=x;
m=n;
mf=ones(n,p,n);
%mf=gpuArray(mf);
prevmf=ones(n,p,n);
%prevmf=gpuArray(prevmf);
dis=zeros(n,p,m);
%dis=gpuArray(dis);
disbar=zeros(n,m);
%disbar=gpuArray(disbar);
devbar=zeros(n,m);
%devbar=gpuArray(devbar);
dev=zeros(n,p,m);
%dev=gpuArray(dev);
beta=1;
prevdisbar=zeros(n,m);
%prevdisbar=gpuArray(prevdisbar);
comparison2=1;
s=zeros(n,m);
%s=gpuArray(s);
% max=0;


%initializing prevmf
for i=1:n
    for k=1:n
        if(i==k)
        prevmf(i,:,k)= 0;
        else
            prevmf(i,:,k)=1;
        end
    end
end 


while comparison2==1

%iterations
    for i=1:n
        for k=1:m
            if(i~=k)
                
            sum2=0;
            sum3=0;
            for j=1:p
                dis(i,j,k)=abs(x(i,j)-Z(k,j));
                sum2 =sum2 + dis(i,j,k)*prevmf(i,j,k);
                sum3= sum3+ prevmf(i,j,k);
           end
          disbar(i,k)= sum2/sum3;
           end
        end
    end
%  disp(dev);
%  disp(disbar);   
%     
%Dev and devbar
for i1=1:n
  for k=1:m
      if(i1~=k)
    sum4=0;
    for j=1:p
      dev(i1,j,k)=abs(dis(i1,j,k)-disbar(i1,k));
      sum4=sum4+dev(i1,j,k);
    end
    devbar(i1,k)=sum4/p;
   end
   end
end


%disp(devbar)

%membershipfunction
for i2=1:n
  for k=1:m
      if(i2~=k)
         for j=1:p
             mf(i2,j,k)= exp(-dev(i2,j,k)^beta / devbar(i2,k)^beta);
             %disp([dev(i2,j,k) devbar(i2,k) mf(i2,j,k)]);
         end
      end
   end
end

disp("**************************************************************************");
 % disp(prevmf)
prevmf=mf;
comparison2=0;

for i=1:n
    for k=1:m
        comparison1=abs(prevdisbar(i,k)-disbar(i,k));
            if comparison1>0.01
                comparison2 =1;
            end 
    end
end
prevdisbar=disbar;


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
    s(i,i)= mins - m*(maxs-mins);
end


disp(s);













      
      
      
       


