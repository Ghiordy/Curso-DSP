clc
close all
clear all
delete(instrfind({'Port'},{'COM3'}));
an = arduino('COM3'); %Puerto donde esta conectado el arduino
Fs = 50; %Frecuencia de muestreo
N = 1000; %Tamaño del vector
y = zeros(N, 1);
t = linspace(0, (N-1)/Fs, N); %Crea el vector tiempo
l1 = line(nan, nan, 'Color', 'r', 'LineWidth', 2);% Genera una línea a partir de los datos leidos
ylim = ([-0.1 5.1]); %Límites del eje Y
xlim = ([0 (N-1)/Fs]); %Límites del eje X
grid %Abre la grilla
%Crear un botón de parada para la toma de datos
stop = 1;
%Diseño del botón
uicontrol('Style', 'Pushbutton', 'String', 'Parar', 'Callback', 'stop=0;');
tic %Inicio del compas
while(stop)
    if toc > 1/Fs
        tic
        y(1:end-1) = y(2:end); %Mueve el vector
        y(end) = an.analogRead(0)*5/1023;%Lee los datos a través de arduino
        set(l1, 'XData', t, 'YData', y);%Pone los datos para graficar
        drawnow %Grafica
    end
end