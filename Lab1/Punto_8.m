%%
%Inciso a
clc 
clear all

n1 = 0; n2 = 20; n0 = 0;
n = [n1:n2];

[x11,n11] = stepseq(n0,n1,n2);%u(n)
[x12,n12] = sigshift(x11,n11,10);%u(n-10)
[x13,n13] = sigshift(x11,n11,20);%u(n-20)

[y_1,n_1] = sigsubt(x11,n11,x12,n12);%n(u(n) - u(n-10)
[y_1a,n_1a] = sigmult(y_1,n_1,n,n);%n(u(n) - u(n-10)
[y_2,n_2] = sigsubt(x12,n12,x13,n13);%u(n-10) - u(n-20)

y12 = (10).*exp(-0.3.*(n-10));

[y_3,n_3] = sigmult(y12,n,y_2,n_2)

[y_a,n_a] = sigadd(y_1a,n_1a,y_3,n_3)

stem(n_a,y_a);
xlim([0 20])

%%