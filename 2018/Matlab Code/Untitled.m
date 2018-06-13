Arr = [1 2 3 100 95 105];
n = length(Arr);
s=zeros(n,n);
temp=0;
for i=1:n
    for k=1:n
        
    s(i,k)=  -norm(Arr(i) - Arr(k))^2;
    %temp=temp+s(i,k);
    end
end
temp2=median(median(s));
% disp(temp2);
% disp(temp/((n*n)-n));
for i=1:n
    s(i,i)= temp2;
end

%disp(s);
arrlist=zeros(1,n);

comparison=10;
r=zeros(n,n);
a=zeros(n,n);
prevr=zeros(n,n);
preva=zeros(n,n);
while comparison>=1
for i=1:n
    for k=1:n
         p=0;
        for k1=1:n 
            if k1==k
                continue;
            
            else
                arrlist(k1)=preva(i,k1)+s(i,k1);
            end
        end
       r(i,k)=s(i,k)-max(arrlist);
       
       if k==i
           for i1=1:n
               %disp(["i1" i1])
               if i1~=i
                 p= p + max(0, prevr(i1,k));
%                  disp(["p" p]);
               end
           end
           a(i,k)=p;
       
       elseif k~=i
            a(i,k)=min(0,prevr(k,k)+p);
            disp(a)
            disp(r)
            
        end 
       
    end
    
end
% disp(preva);
% disp(a);
% disp(prevr); 
% disp(r);
% if sum(sum(preva==a))~=n^2 || sum(sum(prevr==r))~=n^2
%     preva=a;
%     prevr=r;
%     comparison=0;
%    

comparison=comparison-1;
end
exemplar=[];
% disp(comparison);

for i=1:n
%     disp (["a(i,i)" a(i,i)]);
%     disp (["r(i,i)" r(i,i)]);
%     disp (a(i,i)+r(i,i));
    if a(i,i)+r(i,i)>0
        exemplar(end + 1)= Arr(i);
          
    end
end
% disp(exemplar);





           
                
        
        
                
         
                
        
