function varargout = mylab11(varargin)
% MYLAB11 MATLAB code for mylab11.fig
%      MYLAB11, by itself, creates a new MYLAB11 or raises the existing
%      singleton*.
%
%      H = MYLAB11 returns the handle to a new MYLAB11 or the handle to
%      the existing singleton*.
%
%      MYLAB11('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYLAB11.M with the given input arguments.
%
%      MYLAB11('Property','Value',...) creates a new MYLAB11 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mylab11_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mylab11_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mylab11

% Last Modified by GUIDE v2.5 20-May-2017 03:05:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mylab11_OpeningFcn, ...
                   'gui_OutputFcn',  @mylab11_OutputFcn, ...
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


% --- Executes just before mylab11 is made visible.
function mylab11_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mylab11 (see VARARGIN)
handles.r=0.1;
handles.w=0.5;
handles.color='k';
handles.option=1;
handles.string='';

% Choose default command line output for mylab11
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mylab11 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mylab11_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
axes(handles.axes1)
hold on
axis equal;
axis([0 1 0 1]);
set(gcf', 'unit', 'pixels');
x=-1;
y=-1;
while(1)
    k = waitforbuttonpress;
    flag1=x;
    flag2=y;
    handles = guidata(hObject);
    t=get(gca,'CurrentPoint');
    x=t(1,1);%(2,1)
    y=t(1,2);%(2,2)
    if(flag1==x && flag2==y)
        continue
    end
    switch(handles.option)
        case 1
            plot(x+handles.r*cosd(0:360),y+handles.r*sind(0:360),'Color',handles.color,'LineWidth',handles.w);
        case 2
            xs=[x-handles.r x+handles.r x+handles.r x-handles.r x-handles.r];
            ys=[y-handles.r y-handles.r y+handles.r y+handles.r y-handles.r];
            plot(xs,ys,'Color',handles.color,'LineWidth',handles.w);
        case 3
            if(handles.w<=1)
                text(x,y,handles.string,'FontSize',8*handles.r,'Color',handles.color,'Clipping','on');
            else
                text(x,y,handles.string,'FontSize',8*handles.r,'FontWeight','bold','Color',handles.color,'Clipping','on');
            end
    end
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.r=get(hObject,'Value');
set(handles.text1,'string',['r = ' num2str(handles.r)]);
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.color=uisetcolor;
set(handles.text3,'BackgroundColor',handles.color);
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.w=handles.w*1.1;
set(handles.text4,'string',['Width = ' num2str(handles.w)]);
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.w=handles.w*0.9;
set(handles.text4,'string',['Width = ' num2str(handles.w)]);
guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
handles.string=get(hObject,'String');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
if(get(hObject,'Value'))
    handles.option=1;
end
guidata(hObject, handles);


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
if(get(hObject,'Value'))
    handles.option=2;
end
guidata(hObject, handles);


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
if(get(hObject,'Value'))
    handles.option=3;
end
guidata(hObject, handles);
