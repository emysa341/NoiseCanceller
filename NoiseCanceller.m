function varargout = NoiseCanceller(varargin)

% Begin initialization code (www.crunchmodo.com)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NoiseCanceller_OpeningFcn, ...
                   'gui_OutputFcn',  @NoiseCanceller_OutputFcn, ...
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


% --- Executes just before NoiseCanceller is made visible.
function NoiseCanceller_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = NoiseCanceller_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
fs=11025;
n=200000;
handles.signal1= wavrecord(n,fs,'double')
msgbox('Recorded','Status');
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
fs1=11025;
n=200000;
handles.noise1= wavrecord(n,fs1,'double')
msgbox('Recorded','Status');
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
nfilt=fir1(11,0.4); % Eleventh order lowpass filter
fnoise=filter(nfilt,1,handles.noise1); % Correlated noise data
handles.d=handles.signal1+fnoise;
guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
mu = 0.0001;          % Set the step size for algorithm updating.
ha = adaptfilt.sd(42,mu)
[handles.y,handles.e] = filter(ha,handles.signal1,handles.d);
guidata(hObject, handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
figure
plot(handles.signal1);
title('Signal')

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
figure
plot(handles.noise1);
title('Noise')

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
figure
plot(handles.d);
title('Mixed Signal')

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
figure
plot(handles.y);
title('Filtered Signal')

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
wavplay(handles.signal1);
guidata(hObject, handles);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
wavplay(handles.noise1);
guidata(hObject, handles);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
wavplay(handles.d)

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
wavplay(10.*handles.y)
% --- Executes on button press in pushbutton13.

function pushbutton13_Callback(hObject, eventdata, handles)
figure
subplot(2,2,1)
plot(handles.signal1);
title('Signal')
subplot(2,2,2)
plot(handles.noise1);
title('Noise')
subplot(2,2,3)
plot(handles.d);
title('Mixed Signal')
subplot(2,2,4)
plot(2.5.*handles.y);
title('Filtered Signal')

