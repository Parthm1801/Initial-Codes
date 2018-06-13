
%Arr=[1 2 3 4 5 6 7 8 997 998 996 999 4000 4002 4004 ];
%Arr=sort(Arr);
Arr= [50 55 45 52 57 47 42 32 34 35 37 33 43 49 51 56 40 41 48 31 38 46 59 58 44 54 36 39 53 60 10 29 11 23 28 13 20 6 12 7 18 17 30 2 8 14 15 16 22 21 25 24 4 1 3 27 9 26 5 19];
%Arr=randi(20,1,10);
n= length(Arr);
lambda=0.5;
s=zeros(n,n);
M=zeros(1,n-1);
preva=zeros(n,n);
prevr=zeros(n,n);
a=zeros(n,n);
r=zeros(n,n);
prevr=r;
preva=a;    
comparison=50;
maxtrix=zeros(n-1,1);
arrlist=zeros(1,n);

%Similarity Matrix
for i=1:n
    for k=1:n
        s(i,k)=-norm(Arr(i)-Arr(k))^2;
    end
end

I=median(median(s))*eye(n);
s=s+I;

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
            
            for k1=1:n
                if k1==k
                    arrlist(k1)= min(arrlist);
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

data=zeros(1,n);
for i=1:n
 Matr=zeros(1,n);
    for j=1:n
      Matr(j)=r(i,j)+a(i,j);
     end
    [p,q]=max(Matr);
     data(i)=q;
     fprintf("i= %d belongs to cluster q=%d\n",Arr(i), Arr(q));
end

data1=unique(data);
disp(data1);
