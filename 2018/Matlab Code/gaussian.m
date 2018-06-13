beta1=1;
beta2=5;
m=beta1:0.1:beta2;
c=(beta1+beta2)/2;
sig=(beta2-beta1)/7;
gauss=gaussmf(m,[sig c]);
plot(m,gauss);