Arr=[1 2 3 4 5 6 7 8  997 998 999 996 995 994 4000 4002 4003];
n= length(Arr);
s=zeros(n,n);
for i=1:n
    for k=1:n
        s(i,k)=-norm(Arr(i)-Arr(k))^2;
    end
end

meds=median(median(s));
for i=1:n
    s(i,i)=meds;
end
% oldr=zeros(n,n);
% olda=zeros(n,n);
preva=zeros(n,n);
prevr=zeros(n,n);
a=zeros(n,n);
r=zeros(n,n);
%M=zeros(1,n-1);

% for i=1:n
%   for j=1:n
%     for j1=1:n
%       if j1==k
%         continue;
%        else
%           M(j1)=s(i,j1);
%       end
%     end      
%     r(i,j)= s(i,j)- max(M);
%     end
%   end
% prevr=r;
comparison=50;
maxtrix=zeros(n-1,1);
arrlist=zeros(1,n-1);
alpha=0.5;

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
            r(i,k)=0.5*(s(i,k)-max(arrlist))+0.5*prevr(i,k);
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
                a(i,k)=0.5*(smax+max(0,r(k,k)))+0.5*preva(i,k);
            else
                a(i,k)=0.5*min(0,r(k,k)+smax)+0.5*preva(i,k);
            end
        end
    end
    
    prevr(i,k)=r(i,k);
    preva(i,k)=a(i,k);
    comparison=comparison-1;
    
    
    
end
% disp(a);
% disp(r);
    
exemplar=[];
% disp(comparison);

% for i=1:n
% %     disp (["a(i,i)" a(i,i)]);
% %     disp (["r(i,i)" r(i,i)]);
% %     disp (a(i,i)+r(i,i));
%     if a(i,i)+r(i,i)>0
%         exemplar(end + 1)= Arr(i);
%           
%     end
% end
% disp(exemplar);
sum1=r+a;
c=zeros(1,n);

for i=1:n
    
    for k=1:n
        c(1,k)=sum1(i,k);
    end
    [p,q]=max(c);
    disp(["i=" Arr(i) " belongs to cluster q=" Arr(q)])
end
    
            
                    
                
                
            
    
    


                
                
            
            
