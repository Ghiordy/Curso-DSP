load handel; % the signal is in y and sampling freq in Fs
sound(y,Fs); pause(10); % Play the original sound
alpha = 0.9; D = 4196; % Echo parameters
b = [1,zeros(1,D),alpha]; % Filter parameters
x = filter(b,1,y); % Generate sound plus its echo
sound(x,Fs); % Play sound with echo

%%
% 
% $$x[n]=y[n]+\alpha y[n-D], \hspace{0.5cm} \mid \alpha \mid < 1$$
% 
