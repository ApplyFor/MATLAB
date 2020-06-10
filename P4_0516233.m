%Name:³¯¬M¿² ID:0516233

function varargout = P4_0516233(varargin)
% P4_0516233 MATLAB code for P4_0516233.fig
%      P4_0516233, by itself, creates a new P4_0516233 or raises the existing
%      singleton*.
%
%      H = P4_0516233 returns the handle to a new P4_0516233 or the handle to
%      the existing singleton*.
%
%      P4_0516233('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P4_0516233.M with the given input arguments.
%
%      P4_0516233('Property','Value',...) creates a new P4_0516233 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before P4_0516233_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P4_0516233_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P4_0516233

% Last Modified by GUIDE v2.5 25-May-2017 21:14:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P4_0516233_OpeningFcn, ...
                   'gui_OutputFcn',  @P4_0516233_OutputFcn, ...
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


% --- Executes just before P4_0516233 is made visible.
function P4_0516233_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P4_0516233 (see VARARGIN)

%initialize
handles.image=[];%image
handles.r=[];%imref2d object
handles.zoom=1;%zoom factor
handles.x1=1;%the leftest x-coordinate
handles.x2=2;%the rightest x-coordinate
handles.y1=1;%the leftest y-coordinate
handles.y2=2;%the rightest y-coordinate
handles.length=1;%length
handles.width=1;%width

% Choose default command line output for P4_0516233
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes P4_0516233 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = P4_0516233_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get default command line output from handles structure
varargout{1} = handles.output;

% set the axes for image display as the current axes before calling imshow
axes(handles.axes1)
% set the Unit property of the figure and the axes to Pixels to know the correct size of the axes
set(gcf,'Units','pixels');

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%get the position of slider
pos=get(hObject,'Value');
%caculate the difference between the previous position and the current position
dif=pos-handles.x1;
%select the viewed portion of the image
handles.x1=pos;
handles.x2=handles.x2+dif;
axis([handles.x1 handles.x2 handles.y1 handles.y2]);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%get the position of slider
pos=get(hObject,'Value');
%get the max range of slider
max=get(hObject,'Max');
%select the viewed portion of the image
handles.y1=max-pos+1;
handles.y2=max-pos+handles.width/handles.zoom;
axis([handles.x1 handles.x2 handles.y1 handles.y2]);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%adjust the zoom factor and set an upper bound of the zooming factor(16)
if(handles.zoom<16)
    handles.zoom=handles.zoom*2;
end
set(handles.text1,'string',['Zoom: ' num2str(handles.zoom) 'x']);
%the image is larger than the axes size in every dimension,enable both slider bar
if(handles.zoom==2)
    set(handles.slider1,'Enable','on');
    set(handles.slider2,'Enable','on');
end

%initialize the viewed portion of the image
handles.x1=1;
handles.x2=handles.length/handles.zoom;
handles.y1=1;
handles.y2=handles.width/handles.zoom;
axis([0 handles.x2 0 handles.y2]);

%set the sliders' Value and Max properties
set(handles.slider1,'Value',1);
set(handles.slider2,'Value',1);
set(handles.slider1,'Max',handles.length-handles.x2+1);
set(handles.slider2,'Max',handles.width-handles.y2+1);
set(handles.slider2,'Value',handles.width-handles.y2+1);

guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%adjust the zoom factor and set an lower bound of the zooming factor(1)
if(handles.zoom>1)
    handles.zoom=handles.zoom/2;
end
set(handles.text1,'string',['Zoom: ' num2str(handles.zoom) 'x']);

%initialize the viewed portion of the image
handles.x1=1;
handles.x2=handles.length/handles.zoom;
handles.y1=1;
handles.y2=handles.width/handles.zoom;

if(handles.zoom==1)
    %the input image is equal to the axes size in every dimension,disable both slider bars
    set(handles.slider1,'Enable','off');
    set(handles.slider2,'Enable','off');
    %initialize their Value and Max properties
    set(handles.slider1,'Value',1);
    set(handles.slider2,'Value',1);
    set(handles.slider1,'Max',2);
    set(handles.slider2,'Max',2);
    set(handles.slider2,'Value',2);
else
    %set their Value and Max properties
    set(handles.slider1,'Value',1);
    set(handles.slider2,'Value',1);
    set(handles.slider1,'Max',handles.length-handles.x2+1);
    set(handles.slider2,'Max',handles.width-handles.y2+1);
    set(handles.slider2,'Value',handles.width-handles.y2+1);
end
%initialize the viewed portion of the image
axis([0 handles.x2 0 handles.y2]);

guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% load the image
image=imgetfile;
handles.image=imread(image);
handles.r=imref2d(size(handles.image));

%set the zoom factor to one
handles.zoom=1;
set(handles.text1,'string',['Zoom: ' num2str(handles.zoom) 'x']);
%the input image is equal to the axes size in every dimension,disable both slider bars
set(handles.slider1,'Enable','off');
set(handles.slider2,'Enable','off');
%initialize their Value and Max properties
set(handles.slider1,'Value',1);
set(handles.slider2,'Value',1);
set(handles.slider1,'Max',2);
set(handles.slider2,'Max',2);
set(handles.slider2,'Value',2);

handles.length=handles.r.ImageExtentInWorldX;
handles.width=handles.r.ImageExtentInWorldY;

%view
imshow(handles.image,handles.r);
guidata(hObject, handles);
