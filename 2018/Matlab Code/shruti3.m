%Arr=[1 2; 3 4; 4 5; 2 6; 4 6; 3 5; 6 7; 99 100; 98 99; 95 99; 97 100; 98 97; 4000 4000; 4005 4002; 4006 4007; 10000 10789 ; 10444 10665];
%Arr=[3 4 3 2 1; 4 3 5 1 1;3 5 3 3 3; 2 1 3 3 2;1 1 3 2 3]
Arr= [50 0;  55 0; 45 0; 52 0; 57 0; 47 0; 42 0; 32 0; 34 0; 35 0; 37 0; 33 0; 43 0; 49 0; 51 0; 56 0; 40 0; 41 0; 48 0; 31 0; 38 0; 46 0; 59 0; 58 0; 44 0; 54 0; 36 0; 39 0; 53 0; 60 0; 10 0; 29 0; 11 0; 23 0; 28 0; 13 0; 20 0; 6  0;12 0; 7  0;18 0; 17 0; 30 0; 2  0;8  0;14 0; 15 0; 16 0; 22 0; 21 0; 25 0; 24 0; 4 0; 1  0;3  0;27 0; 9 0; 26 0; 5  0;19 0;];
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
arrlist=zeros(1,n);

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
 
exemplar=[];
data=zeros(1,n);

for i=1:n
 Matr=zeros(1,n);
    for j=1:n
      Matr(j)=r(i,j)+a(i,j);
     end
    [p,q]=max(Matr);
     data(i)=q;
     fprintf("i= %d belongs  xxxxx to cluster q=%d\n",i, q);
    exemplar(end+1)= Arr(q);
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



