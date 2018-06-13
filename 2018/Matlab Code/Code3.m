Arr=[1 2 3 94 95 96];
n= length(Arr);
s=zeros(n,n);
for i=1:n
    for k=1:n
        s(i,k)=-norm(Arr(i)-Arr(k))^2;
    end
end
I=median(median(s))*eye(n);
s=s+I;
M=zeros(1,n-1);
preva=zeros(n,n);
prevr=zeros(n,n);
a=zeros(n,n);
r=zeros(n,n);
for i=1:n
  for j=1:n
    for j1=1:n
      if j1==k
        continue;
       else
          M(j1)=s(i,j1);
      end
    end      
    r(i,j)= s(i,j)- max(M);
    end
  end

prevr=r;    
comparison=10;
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
            r(i,k)=s(i,k)-max(arrlist);
            for i1=1:n
                if i1==i || i1==k
                    continue
                else
                    maxtrix(i1)=max(0,prevr(i1,k));
                end
            end
            smax=sum(maxtrix);
            if k==i
                a(i,k)=smax + max(0, prevr(k,k));
            else
                a(i,k)=min(0,prevr(k,k)+smax);
            end
            
        end
    end
   comparison=comparison-1;
   preva=a;
   prevr=r; 
    
end
% disp(a);
% disp(r);
    
exemplar=[];
% disp(comparison);
sum1=r+a;
c=zeros(1,n);

for i=1:n
    
    for k=1:n
        c(1,k)=sum1(i,k);
    end
    [p,q]=max(c);
    disp(["i=" Arr(i) " belongs to cluster q=" q])
end


disp(exemplar);    
            
                    
                
                
            
    
    


                
                
            
            
