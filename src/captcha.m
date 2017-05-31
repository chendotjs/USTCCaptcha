function varargout = captcha(varargin)
% CAPTCHA MATLAB code for captcha.fig
%      CAPTCHA, by itself, creates a new CAPTCHA or raises the existing
%      singleton*.
%
%      H = CAPTCHA returns the handle to a new CAPTCHA or the handle to
%      the existing singleton*.
%
%      CAPTCHA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAPTCHA.M with the given input arguments.
%
%      CAPTCHA('Property','Value',...) creates a new CAPTCHA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before captcha_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to captcha_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help captcha

% Last Modified by GUIDE v2.5 31-May-2017 09:25:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @captcha_OpeningFcn, ...
                   'gui_OutputFcn',  @captcha_OutputFcn, ...
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


% --- Executes just before captcha is made visible.
function captcha_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to captcha (see VARARGIN)

% Choose default command line output for captcha
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes captcha wait for user response (see UIRESUME)
% uiwait(handles.figure_captcha);


% --- Outputs from this function are returned to the command line.
function varargout = captcha_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function m_file_Callback(hObject, eventdata, handles)
% hObject    handle to m_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
    {'*.bmp;*.jpg;*.png;*.jpeg','Image Files (*.bmp, *.jpg, *.png,*.jpeg)'; ...
    '*.*',                'All Files (*.*)'}, ...
    'Pick an image');
if isequal(filename,0) || isequal(pathname,0),
    return;
end


axes(handles.axes_src); % 用axes命令设定当前操作的坐标轴是axes_src
fpath=[pathname filename];  % 将文件名和目录名组合成一个完整的路径
img_src=imread(fpath);
imshow(img_src);  % 用imread读入图片，并用imshow在axes_src上显示

% 显示文件名
set(handles.text_srcname, 'String', filename);

% 初始化checkbox
set(handles.checkbox1, 'Value', 0);
set(handles.checkbox2, 'Value', 0);
set(handles.checkbox3, 'Value', 0);
set(handles.checkbox4, 'Value', 0);

N = 25;
k = 4;
[Centroids, cooridx, IbSet] = seg_picture(fpath, k, N);
setappdata(handles.figure_captcha, 'IbSet', IbSet);
setappdata(handles.figure_captcha, 'N', N);
setappdata(handles.figure_captcha, 'k', k);
setappdata(handles.figure_captcha, 'answer', filename(1:4));
% --------------------------------------------------------------------
function m_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure_captcha);

% --- Executes on button press in predict_button.
function predict_button_Callback(hObject, eventdata, handles)
% hObject    handle to predict_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IbSet = getappdata(handles.figure_captcha, 'IbSet'); % 取得打开图片的数据
N = getappdata(handles.figure_captcha, 'N');
k = getappdata(handles.figure_captcha, 'k');
answer = getappdata(handles.figure_captcha, 'answer');

%  显示单个二值图片，这段写的太丑了
load trainData_knn.mat
KNEAREST = 5;
Mdl = fitcknn(knnChars, knnLabels, 'NumNeighbors', KNEAREST);

correctCnt = 0;

axes(handles.axes_1); % 用axes命令设定当前操作的坐标轴是axes_src
Ib = extractIb(IbSet, N, 1);
imshow(Ib);
label = knn_predict(Mdl, Ib);
set(handles.text_1, 'String', label);
if label == answer(1)
  set(handles.checkbox1, 'Value', 1);
  correctCnt = correctCnt + 1;
end

axes(handles.axes_2); % 用axes命令设定当前操作的坐标轴是axes_src
Ib = extractIb(IbSet, N, 2);
imshow(Ib);
label = knn_predict(Mdl, Ib);
set(handles.text_2, 'String', label);
if label == answer(2)
  set(handles.checkbox2, 'Value', 1);
  correctCnt = correctCnt + 1;
end

axes(handles.axes_3); % 用axes命令设定当前操作的坐标轴是axes_src
Ib = extractIb(IbSet, N, 3);
imshow(Ib);
label = knn_predict(Mdl, Ib);
set(handles.text_3, 'String', label);
if label == answer(3)
  set(handles.checkbox3, 'Value', 1);
  correctCnt = correctCnt + 1;
end

axes(handles.axes_4); % 用axes命令设定当前操作的坐标轴是axes_src
Ib = extractIb(IbSet, N, 4);
imshow(Ib);
label = knn_predict(Mdl, Ib);
set(handles.text_4, 'String', label);
if label == answer(4)
  set(handles.checkbox4, 'Value', 1);
  correctCnt = correctCnt + 1;
end

set(handles.text_rate, 'String', sprintf('%2.2f%%', correctCnt / 4 * 100) );


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
