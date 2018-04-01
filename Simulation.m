function varargout = Simulation(varargin)
% SIMULATION MATLAB code for Simulation.fig
%      SIMULATION, by itself, creates a new SIMULATION or raises the existing
%      singleton*.
%
%      H = SIMULATION returns the handle to a new SIMULATION or the handle to
%      the existing singleton*.
%
%      SIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULATION.M with the given input arguments.
%
%      SIMULATION('Property','Value',...) creates a new SIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Simulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Simulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Simulation

% Last Modified by GUIDE v2.5 31-Mar-2018 18:34:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Simulation_OpeningFcn, ...
                   'gui_OutputFcn',  @Simulation_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Simulation is made visible.
function Simulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.

global fs
global M
global c
global d
global y
global x
global h1

fs = 20000;
M = 20;
c = 343;
d = 0.5;
y = 0;
x = 0;
t = 1:length(x);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Simulation (see VARARGIN)


% Choose default command line output for Simulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1)
plot(t/fs,x)
xlabel(handles.axes1,'Time(s)')
ylabel(handles.axes1,'Amplitude(V)')
title(handles.axes1,'Waveform of combined sources')

axes(handles.axes2)
plot(t/fs,x)
xlabel(handles.axes2,'Time(s)')
ylabel(handles.axes2,'Amplitude(V)')
title(handles.axes2,'Waveform of steered signal')

axes(handles.axes3)
theta = 0:pi/180:pi;
rho = zeros(1,length(theta));
h1 = polar(theta,rho);
title('Steering Direction')



% UIWAIT makes Simulation wait for user response (see UIRESUME)
% uiwait(handles.thresholdTuner);


% --- Outputs from this function are returned to the command line.
function varargout = Simulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in RecordCurrentSound.
function RecordCurrentSound_Callback(hObject, eventdata, handles)
% hObject    handle to RecordCurrentSound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M
global y
global fs
global c
global d
global thetaIn
global time
global x
global h2

y = addRec(M,y,fs,c,d,thetaIn,time);
x = sum(y,1);
t = 1:length(x);
guidata(hObject, handles);
plot(handles.axes1,t/fs,x)
xlabel(handles.axes1,'Time(s)')
ylabel(handles.axes1,'Amplitude(V)')
title(handles.axes1,'Waveform of combined sources')

% theta = -2*pi:pi/180:2*pi;
% rho = heaviside(theta-(thetaIn-5)*pi/180)-heaviside(theta-(thetaIn+5)*pi/180);
% hold on
% axes(handles.axes3)
% h2 = polar(theta,rho,'--');
% hold off


% --- Executes on button press in PlaySteer.
function PlaySteer_Callback(hObject, eventdata, handles)
% hObject    handle to PlaySteer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M
global fs
global y
global c
global d
global steerTheta
global z
z = DAS(M,fs,y,c,d,steerTheta);
t = 1:length(z);
sound(z,fs)
plot(handles.axes2,t/fs,z)
xlabel(handles.axes2,'Time(s)')
ylabel(handles.axes2,'Amplitude(V)')
title(handles.axes2,'Waveform of steered signal')



function inputAngle_Callback(hObject, eventdata, handles)
% hObject    handle to inputAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputAngle as text
%        str2double(get(hObject,'String')) returns contents of inputAngle as a double
global thetaIn
thetaIn = abs(round(str2double(get(hObject,'String'))));



% --- Executes during object creation, after setting all properties.
function inputAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function signalDuration_Callback(hObject, eventdata, handles)
% hObject    handle to signalDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of signalDuration as text
%        str2double(get(hObject,'String')) returns contents of signalDuration as a double
global time
time = abs(round(str2double(get(hObject,'String'))));


% --- Executes during object creation, after setting all properties.
function signalDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signalDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y
global x
global h1
t = 0;
x = 0;
y = 0;
clc
'Signals reset'
plot(handles.axes1,t,x)
xlabel(handles.axes1,'Time(s)')
ylabel(handles.axes1,'Amplitude(V)')
title(handles.axes1,'Waveform of combined sources')

plot(handles.axes2,t,x)
xlabel(handles.axes2,'Time(s)')
ylabel(handles.axes2,'Amplitude(V)')
title(handles.axes2,'Waveform of steered signal')

axes(handles.axes3)
theta = 0:pi/180:pi;
rho = zeros(1,length(theta));
h1 = polar(theta,rho);
title('Steering Direction')




function steerAngle_Callback(hObject, eventdata, handles)
% hObject    handle to steerAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global steerTheta
global h1
steerTheta = abs(round(str2double(get(hObject,'String'))));

axes(handles.axes3)
theta = 0:pi/180:2*pi;
rho = zeros(1,length(theta));
rho(steerTheta+1) = 1;
delete(h1);
hold on
h1 = polar(theta,rho);
set(h1, 'Color', 'Blue','LineWidth',2)
title('Steering Direction')
hold off

% Hints: get(hObject,'String') returns contents of steerAngle as text
%        str2double(get(hObject,'String')) returns contents of steerAngle as a double


% --- Executes during object creation, after setting all properties.
function steerAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to steerAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in playAllSrcs.
function playAllSrcs_Callback(hObject, eventdata, handles)
% hObject    handle to playAllSrcs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x
global fs
sound(x,fs)


% --- Executes during object creation, after setting all properties.
function OutputWind_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputWind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes on button press in Detector.
function Detector_Callback(hObject, eventdata, handles)
% hObject    handle to Detector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y
global M
global fs
global d
global c
global threshold
global time
global h1
global h2

clc
energyAngles = energyDetect(M, y, fs, c, d, time);
axes(handles.axes3)
theta = 0:pi/180:pi;
rho = zeros(1,length(theta));
h1 = polar(theta,rho);
title('Steering Direction')
for i = 0:(length(energyAngles)-1)
   if (energyAngles(i+1) > threshold*1e+03)
    theta = -2*pi:pi/180:2*pi;
    rho = heaviside(theta-(5*i-5)*pi/180)-heaviside(theta-(5*i+5)*pi/180);
    hold on
    h2 = polar(theta,rho,'-.');
    hold off
   end
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global threshold
threshold = get(hObject,'Value')


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
