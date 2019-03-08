%% UNIVERSIDAD FRANCISCO DE PAULA SANTANDER.
% Facultad de Ingeniería.
% Departamento de Electricidad & Electrónica.
% Programa de Ingeniería Electrónica.
% Procesamiento digital de señales.

% Ghiordy F. Contreras C. cód. 1161146.
% Richard S. Hernandez M. cód. 1161062
%% Algoritmo de filtros digitales para imagen

function varargout = Lab_gui_02(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Lab_gui_02_OpeningFcn, ...
                   'gui_OutputFcn',  @Lab_gui_02_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% --- Función de inicio añadiendo información institucional.
function Lab_gui_02_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
axes(handles.axes1);
logoUFPS= imread('Figures/logoufps.png');
imshow(logoUFPS);
axes(handles.axes2);
logoUFPSie= imread('Figures/EEufps.png');
imshow(logoUFPSie);
set(handles.imagen1,'Visible','Off');
set(handles.imagen2,'Visible','Off');
set(handles.actualizar,'Visible','Off');
handles.myImage = []; % Localización de imagen procesando
handles.myImageP = []; % Localización catché

function varargout = Lab_gui_02_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Presenta los autores del trabajo.
function Creditos_Callback(hObject, eventdata, handles)
msgbox({'Ghiordy Ferney Contreras Contreras 1161146';
        'Richard Samir Hernandez Mesa 1161062.'});

% --- Presenta el texto guía de Ayuda.
function Ayuda_Callback(hObject, eventdata, handles)
msgbox({'';
    'En la interfaz gráfica de usuario usted podré encontrar dos ejes gráficos';
    'para presentar la imagen procesando a la izquierda con su respectivo título';
    'y a la derecha se encuentra el resultado del obtenido justo después de ';
    'presionar el botón actualizar que se encuentra en la parte intermedia de';
    'la interfaz gráfica de usuario.';
    '';
    'La interfaz recoge dentro de un panel denominado filtros aquellas ';
    'operaciones aplicables a la imagen de la izquierda, las cuales son: ';
    'conteo de objetos(Conteo),detección de bordes(Bordes), ';
    'binarización(Binarizada, sal y pimienta(Sal y pimienta),filtro ';
    'mediana(Mediana) y detección de rostros. Adicionalmente encontrará un';
    'slider para ajustar la densidad con que se aplica el filtro para cada '
    'una de las opciones';
    '';
    'Conteo: realiza una binarización (con la barra de ajuste se espicifíca'; 
    'el parámetro de binarización) y detección de bordes donde inicialmente';
    'se deja a diposición con el método sobel, después de estos dos procesos';
    'se aplica bwlabel y mostrando un título que indica el número de objetos.';
    'Bordes: detecta los bordes con el método canny el cual no solo asume '
    'bordes externos sino que también bordes internos.';
    'Binarizada: binariza la imagen de entrada ajustando el parámetro de ';
    'binarización con el slider.';
    'Sal y pimienta: aplica el filtro de sal y pimienta donde el slider ';
    'ajusta la densidad de aplicación del filtro';
    'Mediana: aplica el filtro mediana con la imagen llevada a escala de ';
    'grises.';
    'Rostros: detecta rostros dentro de la figura usando un modelo de ';
    'clasificación ajustado para detectar rostros de perfil en conjunto';
    'con el cuello y parte del pecho de la persona, esté método no depende de';
    'binarización o traspasa la imagen a escala de grises.'});

% --- Acción de Salir.
function Salir_Callback(hObject, eventdata, handles)
close(handles.output);

% --- Ejecución al presionar el botón de actualizar.
function actualizar_Callback(hObject, eventdata, handles)
set(handles.imagen2,'Visible','On');
set(hObject,'Enable','Off');
axes(handles.imagen2);
imagen=imread(handles.MyImage);
P1 = get(handles.P1,'Value');
P2 = get(handles.P2,'Value');
P3 = get(handles.P3,'Value');
P4 = get(handles.P4,'Value');
P5 = get(handles.P5,'Value');
P6 = get(handles.P6,'Value');
d = get(handles.ajuste,'Value');
if (P1==1) %conteo de objetos
    imagen=rgb2gray(imagen);
    imagen=medfilt2(imagen);
    imagen=im2bw(imagen,d);
    imagen=edge(imagen,'sobel');%canny
    
    if(get(handles.dilateENA,'Value')==1)
        vd=str2double(get(handles.dilate,'String'));
        sd=strel('square',vd);
        imagen=imdilate(imagen,sd);
    end
    
    if(get(handles.fillENA,'Value')==1)
        imagen=imfill(imagen,'holes');
    end
    
    if (get(handles.erodeENA,'Value')==1)
        ve=str2double(get(handles.erode,'String'));
        se=strel('square',ve);
        imagen=imerode(imagen,se);
    end
    
    if(get(handles.binar,'Value')==1)
        imagen=not(imagen);
    end
    
    imagen=bwlabel(imagen,8);
    n=max(max(imagen));
    imshow(imagen);
    title(strcat('Número de objetos: ',num2str(n)))
end
if (P2==1) %detección de bordes
    imagen=rgb2gray(imagen);
    %filter=[1 2*d 1;0 0 0;-1 -2*d -1];
    %imagen=filter2(filter,imagen);
    imagen=edge(imagen,'canny');
    imshow(imagen);
end
if (P3==1) %binarización
    imagen=im2bw(imagen,d);
    imshow(imagen);
end
if (P4==1) %sal y pimienta
    imagen=imnoise(imagen,'salt & pepper',d);
    imshow(imagen);
end
if (P5==1) %filtro mediana
    imagen=rgb2gray(imagen);
    imagen=medfilt2(imagen);
    imshow(imagen);
end
if (P6==1) %detección de rostros
    if (d<(1/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','FrontalFaceCART');
    elseif (d<(2/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','FrontalFaceLBP');
    elseif (d<(3/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','Nose');
    elseif (d<(4/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','EyePairBig');
    elseif (d<(5/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','EyePairSmall');
    elseif (d<(6/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','UpperBody');
    elseif (d<(7/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','LeftEye');
    elseif (d<(7/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','RightEye');
    elseif (d<(8/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','LeftEyeCART');
    elseif (d<(9/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','RightEyeCART');
    elseif (d<(10/12))
        detector=vision.CascadeObjectDetector('ClassificationModel','ProfileFace');
    else
        detector=vision.CascadeObjectDetector('ClassificationModel','Mouth');
    end
    bbox = step(detector,imagen);
    n=length(bbox);
    imagen = insertObjectAnnotation(imagen,'rectangle',bbox,'Rostro');
    imshow(imagen);
    title(strcat('Número de rostros: ',num2str(n)))
end
set(hObject,'Enable','On');
imwrite(imagen,handles.MyImageP);

% --- Proceso de cargar imagen
function cargarIM_Callback(hObject, eventdata, handles)
set(hObject,'BackgroundColor',[1,0,0]);
[filename pathname]=uigetfile({'*.png';'*.jpg';'*.bmp'},'Buscar archivo');
while (filename==0)
    [filename pathname]=uigetfile({'*.png';'*.jpg';'*.bmp'},'Buscar archivo');
end
set(hObject,'BackgroundColor',[0,0,1]);
set(handles.imagen1,'Visible','On');
handles.MyImage = strcat(pathname, filename);
axes(handles.imagen1);
imshow(handles.MyImage);
title('Imagen de entrada');
proceso=('proceso.png');
set(handles.actualizar,'Visible','On');
handles.MyImageP = strcat(pathname, proceso);
imagen=imread(handles.MyImage);
imwrite(imagen,handles.MyImageP);
guidata(hObject,handles);

% --- Lista de filtros
function P1_Callback(hObject, eventdata, handles)
set(hObject,'BackgroundColor',[0.2, 0.65, 0.78]); 
set(handles.P2,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P3,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P4,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P5,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P6,'BackgroundColor',[0.94, 0.94, 0.94]); 
function P2_Callback(hObject, eventdata, handles)
set(handles.P1,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(hObject,'BackgroundColor',[0.2, 0.65, 0.78]); 
set(handles.P3,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P4,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P5,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P6,'BackgroundColor',[0.94, 0.94, 0.94]); 
function P3_Callback(hObject, eventdata, handles)
set(handles.P1,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P2,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(hObject,'BackgroundColor',[0.2, 0.65, 0.78]); 
set(handles.P4,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P5,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P6,'BackgroundColor',[0.94, 0.94, 0.94]); 
function P4_Callback(hObject, eventdata, handles)
set(handles.P1,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P2,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P3,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(hObject,'BackgroundColor',[0.2, 0.65, 0.78]); 
set(handles.P5,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P6,'BackgroundColor',[0.94, 0.94, 0.94]); 
function P5_Callback(hObject, eventdata, handles)
set(handles.P1,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P2,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P3,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P4,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(hObject,'BackgroundColor',[0.2, 0.65, 0.78]); 
set(handles.P6,'BackgroundColor',[0.94, 0.94, 0.94]); 
function P6_Callback(hObject, eventdata, handles)
set(handles.P1,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P2,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P3,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P4,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(handles.P5,'BackgroundColor',[0.94, 0.94, 0.94]); 
set(hObject,'BackgroundColor',[0.2, 0.65, 0.78]);

% --- Ajuste con barra(slider)
function ajuste_Callback(hObject, eventdata, handles)
valor = num2str(get(hObject,'Value'));
set(handles.edit,'String',valor);

% --- Creación del slider
function ajuste_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% Ajuste con caja de texto
function edit_Callback(hObject, eventdata, handles)
texto=str2double(get(hObject,'string'));
if (texto>=0 && texto<=1)
    set(handles.ajuste,'Value',texto)
end

% --- Creación caja de texto
function edit_CreateFcn(hObject, eventdata, handles)
set(hObject,'String','0.5');
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function binar_Callback(hObject, eventdata, handles)

function dilate_Callback(hObject, eventdata, handles)

function dilate_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function erode_Callback(hObject, eventdata, handles)

function erode_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dilateENA_Callback(hObject, eventdata, handles)

function erodeENA_Callback(hObject, eventdata, handles)

function fillENA_Callback(hObject, eventdata, handles)
