%Arr=[1 2; 3 4; 4 5; 2 6; 99 100; 98 99; 95 99];
Arr=[3 4 3 2 1; 4 3 5  1 1;3 5 3 3 3; 2 1 3 3 2;1 1 3 2 3]
n= length(Arr);
lambda=0.5;
s=zeros(n,n);
for i=1:n
    for k=1:n
        s(i,k)=-norm(Arr(i,:)-Arr(k,:))^2;
    end
end
I=median(median(s))*eye(n);
s=s+I;
M=zeros(1,n-1);
preva=zeros(n,n);
prevr=zeros(n,n);
a=zeros(n,n);
r=zeros(n,n);

prevr=r;    
comparison=50;
maxtrix=zeros(n-1,1);
arrlist=zeros(1,n-1);

while comparison>=1
    for i=1:n
        for k=1:n
            for k1=1:n
                if k1==k
                    continue
                else
                    arrlist(k1)=s(i,k1)+preva(i,k1);
                end
            end
            r(i,k)=(1-lambda)*(s(i,k)-max(arrlist)) + lambda*prevr(i,k);
            end
            end
     for i=1:n
        for k=1:n
            for i1=1:n
                if i1==i || i1==k
                    continue
                else
                    maxtrix(i1)=max(0,r(i1,k));
                end
            end
            smax=sum(maxtrix);
            if k==i
                a(i,k)=(1-lambda)*(smax + max(0,r(k,k))) + lambda* preva(i,k);
            else
                a(i,k)=(1-lambda)*(min(0,r(k,k)+smax))+ lambda * preva(i,k);
            end
            
        end
    end
   comparison=comparison-1;
   preva=a;
   prevr=r; 
    
end
 
exemplar=[];
data=zeros(1,n);
count=0;
for i=1:n
 Matr=zeros(1,n);
    for j=1:n
        if j~=i && r(i,i)+a(i,i)>r(i,j)+a(i,j)
            count=count+1;
        end
    end
     if count==n-1
         disp([i "Hey there"]);
     end
     [p,q]=max(Matr);
     data(i)=q;
     %fprintf("i= %d belongs to cluster q=%d\n",i, q);
     exemplar(end+1)= Arr(q);
end

%exemplar check
for i=1:size(exemplar,1)
    temp1=find(ismember(Arr,exemplar(i,:)),1);
    data(temp1)=temp1;
end


countarray=zeros(1,length(data));
for i=1:length(data)
    temp4=data(i);
    count=1;
    for j=1:length(data)
        if i~=j && data(i)==data(j)
            count=count+1;
        end
    end
    countarray(i)=count;
end 

distancestore= zeros(1,length(data));

for i=1:length(countarray)
    if countarray(i)==1
        for j=1:length(data)
            if i~=j
            distancestore(j)=abs(norm(Arr(data(j))-Arr(data(i))));
            end
        end
        
        for j=1:length(data)
            if i==j
            distancestore(j)=max(distancestore);
            end
        end
        
        [row,col]=min(distancestore);
        data(i)=data(col);
    end
end

%

data1=unique(data);
Exem=zeros(size(data1,1),size(Arr,2));
for i=1:length(data1)
    Exem(i,:)=Arr(data1(i),:);
end



c=size(data1,2);
U=zeros(c,n);

for i=1:c
    for j=1:n
        if data(1,j)==data1(1,i)
            U(i,j)=1;
        end
    end
end



% disp(U);

% graph(Arr,exemplar,U);
% 
% 
% function graph(Arr,exemplar,U)
%     color=max((max(U)==U).*linspace(0,1/2,size(U,1))')';
%     hold on
%     scatter(Arr(:,1),Arr(:,2),20, color);
%     scatter(exemplar(:,1),exemplar(:,2),100,'filled');
%     hold off
% end


