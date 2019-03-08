%% Lab 1: Fundamentals signals into MATLAB
% Digital Signal Processing Course

%% Exercise 1
t=linspace(0,2,100); % Continuous-time input array.
y_t=sin(2*pi.*t); % Continuous-time output array.
n=0:20; % Discrete-time input array.
y_n=sin(0.2*pi*n); % Discrete-time output array.
% We've plotted both math signals into a figure 1 in order 
% to undesrtand easily the diference among continuous-time 
% signal and discrete-time signals.
figure(1),subplot(1,2,1),plot(t,y_t),grid on; 
figure(1),subplot(1,2,2),stem(n,y_n,'r'),grid on; 

%% Exercise 2
% At the bottom of this algorithm you may find the function to
% generate a Delta Sequence where [x,n]=impseq(n0,n1,n2) such as:
% n0: value for x(n) function be equal to 1. Otherwise it'll be 0.
% n1: minimum value for vector or bottom limit.
% n2: maximum value for vector or top limit.
[x,n]=impseq(1,-10,10) % Example using MATLAB function.
% This function has the following condition:
% n1 < n0 < n2

%% Exercise 3
% At the bottom of this algorithm you may find the function to
% generate a Step Sequence where [x,n]=stepseq(n0,n1,n2) such as:
% n0: value for x(n) function starts to deal 1 values.
% n1: minimum value for vector or bottom limit.
% n2: maximum value for vector or top limit.
[x,n]=stepseq(2,-10,10) % Example using MATLAB function.
% This function has the following condition:
% n1 < n0 < n2

%% Exercise 4
% Signal adition '+'.
n_1=-15:15; % First reference array
x_1=exp(-0.2.*n_1); % First sequence.
n_2=-15:15; % Second reference array.
x_2=sin(0.1*pi*n_2); % Second sequence.
% At the bottom of this algorithm you may find the function to
% generate a Signal Adition where [y,n]=sigadd(x1,n1,x2,n2) such as:
% x1: First sequence.
% n1: First reference array.
% x2: Second sequence.
% n2: Second reference array.
[y,n]=sigadd(x_1,n_1,x_2,n_2) % Example using MATLAB function.

%% Exercise 5
% Signal multiplication '*'.
n_1=-15:15; % First reference array.
x_1=exp(-0.2.*n_1); % First sequenece.
n_2=-15:15; % Second reference array.
x_2=sin(0.25*pi*n_2); % Second sequence.
% At the bottom of this algorithm you may find the function to generate 
% a Signal Multiplication where [y,n]=sigmult(x1,n1,x2,n2) such as:
% x1: First sequence.
% n1: First reference array.
% x2: Second sequence.
% n2: Second reference array.
[y,n]=sigmult(x_1,n_1,x_2,n_2) % Example using MATLAB function.

%% Exercise 6
% Signal shifting 'x(n-k)'.
n=[-3 -2 -1 0 1 2 3 4 5 6]; % Signal reference.
x=[0 9 8 7 6 5 4 3 2 1]; % Signal sequence.
% At the bottom of this listing you may find the algorithm to
% generate a Signal Shifiting where [y,n]=sigshift(x,m,k) such as:
% x: Signal sequence.
% m: Signal reference.
% k: Amount shifted.
[y,n]=sigshift(x,n,4) % Example using MATLAB function.

%% Exercise 7
% Signal folding 'x(-n)'.
n=[-3 -2 -1 0 1 2 3 4 5 6]; % Signal reference.
x=[0 9 8 7 6 5 4 3 2 1]; % Signal sequence.
% At the bottom of this listing you may find the algorithm to
% generate a Signal Folding where [y,n]=sigfold(x,n) such as:
% x1: First sequence.
% n1: First reference array.
% x2: Second sequence.
% n2: Second reference array.
[y,n]=sigfold(x,n)

%% Exercise 8a
n1 = 0; n2 = 20; n0 = 0; %initial values for u(n)
n = [n1:n2]; %array limits

[x11,n11] = stepseq(n0,n1,n2);%u(n)
[x12,n12] = sigshift(x11,n11,10);%u(n-10)
[x13,n13] = sigshift(x11,n11,20);%u(n-20)

[y_1,n_1] = sigrest(x11,n11,x12,n12);%n(u(n) - u(n-10)
[y_1a,n_1a] = sigmult(y_1,n_1,n,n);%n(u(n) - u(n-10)
[y_2,n_2] = sigrest(x12,n12,x13,n13);%u(n-10) - u(n-20)

y12 = (10).*exp(-0.3.*(n-10)); % 10e^(-0.3(n-10))

[y_3,n_3] = sigmult(y12,n,y_2,n_2)%(10e^(-0.3(n-10)))*(u(n-10) - u(n-20))

[y_a,n_a] = sigadd(y_1a,n_1a,y_3,n_3)%(n(u(n) - u(n-10))+(10e^(-0.3(n-10)))
                                      %*(u(n-10) - u(n-20))

figure(8),subplot(2,2,1),stem(n_a,y_a,'r'),title('(a).'),grid on;
xlim([0 20])

%% Exercise 8b
n=-2:10;% Signal reference.
x=[1 2 3 4 5 6 7 6 5 4 3 2 1];% Signal Sequence.
[y_0,n_0]=sigfold(x,n);%Reflection x(n) to x(-n)
[y_1,n_1]=sigshift(y_0,n_0,-3);%Shift +3 x(-n) to x(3-n)
[y_2,n_2]=sigshift(x,n,2);%Shift +2 x(n) to x(n-2)
[y_3,n_3]=sigmult(x,n,y_2,n_2);%x(n)*x(n-2)
[y,n]=sigadd(y_1,n_1,y_3,n_3);%x(3-n)+(x(n)*x(n-2))
figure(8),subplot(2,2,2),stem(n,y,'g'),title('(b).'),grid on;

%% Exercise 8c
[xe,xo,m]=evenodd(y,n)%component even and odd function
figure(8),subplot(2,2,3),stem(m,xe),title('(c). Even.'),grid on;%
figure(8),subplot(2,2,4),stem(m,xo),title('(c). Odd.'),grid on;%

%% Functions

% Impulse Sequence.
function[x,n]=impseq(n0,n1,n2)
n=[n1:n2];
x=[(n-n0)==0];
end
% Step Sequence.
function[x,n]=stepseq(n0,n1,n2)
n=[n1,n2];
x=[(n-n0)>=0];
end
% Signal Adition.
function [y,n] = sigadd(x1,n1,x2,n2)
n = min(min(n1),min(n2)):max(max(n1),max(n2)); % duration of y(n)
y1 = zeros(1,length(n)); y2 = y1; % initialization
y1(find((n>=min(n1))&(n<=max(n1))==1))=x1; % x1 with duration of y
y2(find((n>=min(n2))&(n<=max(n2))==1))=x2; % x2 with duration of y
y = y1+y2;
end
% Signal Shifting.
function [y,n] = sigshift(x,m,k)
n = m+k; y = x;
end
% Signal Folding.
function [y,n] = sigfold(x,n)
y = fliplr(x); n = -fliplr(n);
end
% Signal Substration.
function [y,n] = sigsubt(x1,n1,x2,n2)
n = min(min(n1),min(n2)):max(max(n1),max(n2)); % duration of y(n)
y1 = zeros(1,length(n)); y2 = y1; % initialization
y1(find((n>=min(n1))&(n<=max(n1))==1))=x1; % x1 with duration of y
y2(find((n>=min(n2))&(n<=max(n2))==1))=x2; % x2 with duration of y
y = y1-y2;
end
% Even & Odd components for signals x(n).
function [xe, xo, m] = evenodd(x,n)
if any(imag(x) ~= 0)
error('x is not a real sequence')
end
m = -fliplr(n);
m1 = min([m,n]); m2 = max([m,n]); m = m1:m2;
nm = n(1)-m(1); n1 = 1:length(n);
x1 = zeros(1,length(m)); x1(n1+nm) = x; x = x1;
xe = 0.5*(x + fliplr(x)); xo = 0.5*(x - fliplr(x));
end