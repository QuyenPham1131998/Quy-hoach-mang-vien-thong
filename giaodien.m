function varargout = giaodien(varargin)
% giaodien MATLAB code for giaodien.fig

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @giaodien_OpeningFcn, ...
                   'gui_OutputFcn',  @giaodien_OutputFcn, ...
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
% --- Executes just before giaodien is made visible.
function giaodien_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;


guidata(hObject, handles);


 
% --- Outputs from this function are returned to the command line.
function varargout = giaodien_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function editx_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editx_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edity_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edity_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editsonut_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editsonut_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editW_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editW_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editRPARM_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function editRPARM_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editC_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editC_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editalpha_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editalpha_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editumin_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editumin_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%Khoi tao cac nut ngau nhien


x = get(handles.editx, 'String');
y = get(handles.edity, 'String');
Sonut = get(handles.editsonut, 'String');
W = get(handles.editW, 'String');
RPARM = get(handles.editRPARM, 'String');
C = get(handles.editC, 'String');
Alpha = get(handles.editalpha, 'String');
Umin = get(handles.editumin, 'String');

Node = randi(str2double(x),str2double(Sonut),2); %Tao mot ma tran co kich thuoc [So nut x 2]
x_Node=Node(:,1);   %Lay cot dau tien la gia tri x
y_Node=Node(:,2);   %Lay cot dau tien la gia tri y

%axis([0 str2double(x) 0 str2double(y)]);  %Gioi han truc X, Y
xlabel('x');ylabel('y');
hold on;grid on;
for i=1:length(Node)
    draw(i)=scatter(x_Node(i),y_Node(i),'*k');  %Ve cac nut ngau nhien
    Show_Index(i)=text(x_Node(i)-10,y_Node(i)-20,num2str(i));   %Danh so thu tu cho cac nut
end
waitforbuttonpress;


Traffic = zeros(length(Node));    %Khai bao bien Luu Luong - Traffic
for i=1:length(Node)-2
    Traffic(i,i+2)=1;
    Traffic(i+2,i)=1;
end
for i=1:length(Node)-10
    Traffic(i,i+10)=2;
    Traffic(i+10,i)=2;
end
for i=1:length(Node)-8
    Traffic(i,i+8)=3;
    Traffic(i+8,i)=3;
end

Traffic(7,13)=15; Traffic(13,7)=Traffic(7,13);
Traffic(24,69)=6; Traffic(69,24)=Traffic(24,69);
Traffic(20,48)=26; Traffic(48,20)=Traffic(20,48);
Traffic(35,55)=10; Traffic(55,35)=Traffic(35,55);
A = sum (Traffic);

Node_Weight=ones(1,length(Node));

for i = 1:length(Node)
     Node_Weight(i) = A(i);
end
Threshold_Weight= str2double(W);RPARM= str2double(RPARM);Capacity= str2double(C);
%Tinh Cost
Cost = zeros(length(Node));
for i=1:length(Node)
    for j=1:length(Node)
        Cost(j,i)=0.5*sqrt((x_Node(j)-x_Node(i))^2+(y_Node(j)-y_Node(i))^2);
    end
end
%Tim cac nut backbone thoa man tieu chuan trong so
Backbone_Node=[];
Normalized_Weight=zeros(1,length(Node));    %Khoi tao trong so chuan hoa (Normalized Weight)
for i=1:length(Node)
    Normalized_Weight(i) = Node_Weight(i)/Capacity;
    if Normalized_Weight(i)>Threshold_Weight
        Backbone_Node=[Backbone_Node i];
    end
end
delete(draw(Backbone_Node));    %Chuan bi ve nut Backbone
for i=1:numel(Backbone_Node)
    draw(Backbone_Node(i))=scatter(x_Node(Backbone_Node(i)),y_Node(Backbone_Node(i)),'sr','filled');
end
waitforbuttonpress;
%Tim cac nut truy nhap cho nut cac backbone
Max_Cost=max(max(Cost));    %Tinh Max Cost
Radius = Max_Cost*RPARM;      %Tinh ban kinh duong tron
access_node_for_1st_backbone=[];    %Khoi tao cac nut truy nhap cho nut Backbone thu nhat
Condition1=Backbone_Node;   %Dieu kien xet
for i=1:length(Node)
    if (i~=Condition1)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node(1)))^2+(y_Node(i)-y_Node(Backbone_Node(1)))^2))<=Radius)
        access_node_for_1st_backbone=[access_node_for_1st_backbone i];  %Them nut i vao tap hop cac nut truy nhap
        scatter(x_Node(access_node_for_1st_backbone),y_Node(access_node_for_1st_backbone),'*k');
        node_index(i)=Backbone_Node(1);     %Ghi lai xem nut truy nhap thuoc backbone nao
    end
end
for i=1:numel(access_node_for_1st_backbone)
    plot([x_Node(Backbone_Node(1)),x_Node(access_node_for_1st_backbone(i))],[y_Node(Backbone_Node(1)),y_Node(access_node_for_1st_backbone(i))],'k');
end
access_node_for_2nd_backbone=[];
Condition1=[Condition1 access_node_for_1st_backbone];
for i=1:length(Node)
    if (i~=Condition1)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node(2)))^2+(y_Node(i)-y_Node(Backbone_Node(2)))^2))<= Radius)
        access_node_for_2nd_backbone=[access_node_for_2nd_backbone i];
        scatter(x_Node(access_node_for_2nd_backbone),y_Node(access_node_for_2nd_backbone),'*k');
        node_index(i)=Backbone_Node(2);
    end
end
for i=1:numel(access_node_for_2nd_backbone)
    plot([x_Node(Backbone_Node(2)),x_Node(access_node_for_2nd_backbone(i))],[y_Node(Backbone_Node(2)),y_Node(access_node_for_2nd_backbone(i))],'k');
end
% waitforbuttonpress;
access_node_for_3rd_backbone=[];
Condition1=[Condition1 access_node_for_2nd_backbone];
for i=1:length(Node)
    if (i~=Condition1)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node(3)))^2+(y_Node(i)-y_Node(Backbone_Node(3)))^2))<=Radius)
        access_node_for_3rd_backbone=[access_node_for_3rd_backbone i];
        scatter(x_Node(access_node_for_3rd_backbone),y_Node(access_node_for_3rd_backbone),'*k');
        node_index(i)=Backbone_Node(3);
    end
end
for i=1:numel(access_node_for_3rd_backbone)
    plot([x_Node(Backbone_Node(3)),x_Node(access_node_for_3rd_backbone(i))],[y_Node(Backbone_Node(3)),y_Node(access_node_for_3rd_backbone(i))],'k');
end
%waitforbuttonpress;
access_node_for_4th_backbone=[];
Condition1=[Condition1 access_node_for_3rd_backbone];
for i=1:length(Node)
    if (i~=Condition1)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node(4)))^2+(y_Node(i)-y_Node(Backbone_Node(4)))^2))<=Radius)
        access_node_for_4th_backbone=[access_node_for_4th_backbone i];
        scatter(x_Node(access_node_for_4th_backbone),y_Node(access_node_for_4th_backbone),'*k');
        node_index(i)=Backbone_Node(4);
    end
end
for i=1:numel(access_node_for_4th_backbone)
    plot([x_Node(Backbone_Node(4)),x_Node(access_node_for_4th_backbone(i))],[y_Node(Backbone_Node(4)),y_Node(access_node_for_4th_backbone(i))],'k');
end
%waitforbuttonpress;
access_node_for_5th_backbone=[];
Condition1=[Condition1 access_node_for_4th_backbone];
for i=1:length(Node)
    if (i~=Condition1)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node(5)))^2+(y_Node(i)-y_Node(Backbone_Node(5)))^2))<=Radius)
        access_node_for_5th_backbone=[access_node_for_5th_backbone i];
        scatter(x_Node(access_node_for_5th_backbone),y_Node(access_node_for_5th_backbone),'*k');
        node_index(i)=Backbone_Node(5);
    end
end
for i=1:numel(access_node_for_5th_backbone)
    plot([x_Node(Backbone_Node(5)),x_Node(access_node_for_5th_backbone(i))],[y_Node(Backbone_Node(5)),y_Node(access_node_for_5th_backbone(i))],'k');
end
%waitforbuttonpress;
access_node_for_6th_backbone=[];
Condition1=[Condition1 access_node_for_5th_backbone];
for i=1:length(Node)
    if (i~=Condition1)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node(6)))^2+(y_Node(i)-y_Node(Backbone_Node(6)))^2))<=Radius)
        access_node_for_6th_backbone=[access_node_for_6th_backbone i];
        scatter(x_Node(access_node_for_6th_backbone),y_Node(access_node_for_6th_backbone),'*k');
        node_index(i)=Backbone_Node(6);
    end
end
for i=1:numel(access_node_for_6th_backbone)
    plot([x_Node(Backbone_Node(6)),x_Node(access_node_for_6th_backbone(i))],[y_Node(Backbone_Node(6)),y_Node(access_node_for_6th_backbone(i))],'k');
end
% waitforbuttonpress;
Condition1=[Condition1 access_node_for_6th_backbone];
%--------------------------------------------------------------------------
%Tim cac nut backbone con lai
%Xac dinh Center of Gravity - CG(trung tam cua trong luc)
x_center_of_gravity=sum(Node_Weight(:).*x_Node(:))/sum(Node_Weight);
y_center_of_gravity=sum(Node_Weight(:).*y_Node(:))/sum(Node_Weight);
Distance_To_CG=zeros(1,length(Node));
for i=1:length(Node)
    Distance_To_CG(i)=sqrt((x_Node(i)-x_center_of_gravity)^2+(y_Node(i)-y_center_of_gravity)^2);
end
Max_Distance_To_CG=max(Distance_To_CG);
Max_W=max(Node_Weight);
%Tinh toan Merit
Merit=zeros(1,length(Node));
for i=1:length(Node)
    Merit(i)=0.5*(Max_Distance_To_CG-Distance_To_CG(i))/Max_Distance_To_CG+0.5*(Node_Weight(i)/Max_W);
end
Merit(Condition1)=0;
Access_Node=[];
while find(Merit~=0)~=0
    [Merit_index, index]=max(Merit);
    Merit(index)=0;
    Backbone_Node=[Backbone_Node index];    %Them nut Backbone moi vao tap hop cac nut Backbone
    delete(draw(index));
    draw(index)=scatter(x_Node(index),y_Node(index),'sr','filled');
    for i=1:length(Node)
        if (Merit(i)~=0)&&(0.5*(sqrt((x_Node(i)-x_Node(index))^2+(y_Node(i)-y_Node(index))^2))<=Radius)
            Access_Node=[Access_Node i];    %Them nut truy nhap vao tap hop cac nut truy nhap tuong ung voi nut backbone
        end
    end
    for j=1:numel(Access_Node)
        h(j)=plot([x_Node(index),x_Node(Access_Node(j))],[y_Node(index),y_Node(Access_Node(j))],'k');   %Ve lien ket tu nut backbone den cac nut truy nhap
        node_index(Access_Node(j))=index;
    end
    Merit(Access_Node)=0;Merit_index=[];
    index=[];Access_Node=[];
    %waitforbuttonpress;
end
%disp(['Cac nut backbone la: ',num2str(Backbone_Node),'.'])
text1_to_display = cellstr(num2str(Backbone_Node));
set(handles.textnodebb, 'String', text1_to_display);
%--------------------------------------------------------------------------

Alpha = str2double(Alpha);     %Nhap alpha
% moment = sum(Cost(:,:).* P');
moment=Node_Weight*Cost;
[moment_Center_Backbone_Node,k]= min(moment(Backbone_Node));
Center_Backbone_Node=find(moment==moment_Center_Backbone_Node);
delete(draw(Center_Backbone_Node));
draw(Center_Backbone_Node)=scatter(x_Node(Center_Backbone_Node),y_Node(Center_Backbone_Node),'ms','filled');
%disp(['Nut backbone trung tam la: ',num2str(Center_Backbone_Node)])
text2_to_display = cellstr(num2str(Center_Backbone_Node));
set(handles.textbbcenter, 'String', text2_to_display);

xlswrite('Traffic',Traffic);
xlswrite('NodeWeight',Node_Weight);
waitforbuttonpress;
tb=zeros(numel(Backbone_Node)); 

%+------------------------------------------------------------------------+
%|                                Cau 2                                   |
%+------------------------------------------------------------------------+
%Dua tren thuat toan Prim - Dijkstra
Label = inf(1,length(Node));  %Khoi tao nhan (Label)
Sub_Label = inf(1,length(Node));
Label(Center_Backbone_Node)=0; %Nhan nut trung tam
Sub_Label(Center_Backbone_Node)=0;
Connected_Backbone_Node = Center_Backbone_Node;   
Condition2 = Center_Backbone_Node; %dieu kien
Predecessor=Center_Backbone_Node;   %Khoi tao nut tien nhiem (Predecessor)
hop=zeros(1,numel(Backbone_Node));  %Khoi tao buoc nhay (hop)
while numel(Connected_Backbone_Node)~=numel(Backbone_Node)
    for i=1:numel(Backbone_Node)
        if Backbone_Node(i)~= Condition2
            Sub_Label(Backbone_Node(i))= Alpha*Cost(Backbone_Node(i),Predecessor)+Sub_Label(Predecessor); %Nhan Prim - Dijkstra
            Label(Backbone_Node(i))=Sub_Label(Backbone_Node(i));
            hop(i)=hop(find(Backbone_Node == Predecessor))+1;
        end
    end
    next_backbone_node=find(Sub_Label==min(Sub_Label(Sub_Label~=0)));
    Sub_Label(next_backbone_node)=0;
    Condition2=[Condition2,next_backbone_node];
    Connected_Backbone_Node=[Connected_Backbone_Node, next_backbone_node]; %Ket noi cac nut backbone
    Draw_Backbone_Tree(Predecessor) = plot([x_Node(Predecessor),x_Node(next_backbone_node)],[y_Node(Predecessor),y_Node(next_backbone_node)],'r');%ve
    
    for j=1:numel(Backbone_Node)
        if (Backbone_Node(j)~=Condition2)&(Cost(Backbone_Node(j),next_backbone_node) < Sub_Label(Backbone_Node(j)))
            Predecessor=next_backbone_node;
            Sub_Label(Backbone_Node(j))=Sub_Label(Backbone_Node(j))+Sub_Label(Predecessor);
            Label(Backbone_Node(j))=Label(Backbone_Node(j))+Label(Predecessor);
            Draw_Backbone_Tree(Backbone_Node(j))=plot([x_Node(Predecessor),x_Node(Backbone_Node(j))],[y_Node(Predecessor),y_Node(Backbone_Node(j))],'r');
            hop(j)=hop(find(Backbone_Node==Predecessor))+1;
        end
    end
    next_backbone_node=[];
end
waitforbuttonpress;
for i=1:numel(Backbone_Node)
    for j=1:numel(Backbone_Node)
        sum_hop(j,i)=hop(j)+hop(i);
    end
end
umin=str2double(Umin);
for i=1:numel(Backbone_Node)
    node_index(Backbone_Node(i))= Backbone_Node(i);
end
for i=1:length(Node)
    for j=1:length(Node)
        if node_index(j)==node_index(i)
            Traffic(j,i)=0;Traffic(i,j)=0;
        elseif i==j
            Traffic(j,i)=0;Traffic(i,j)=0;
        else
            Traffic(node_index(j),node_index(i))=Traffic(node_index(j),node_index(i))+Traffic(j,i);
            Traffic(node_index(i),node_index(j))=Traffic(node_index(j),node_index(i));
            Traffic(j,i)=0;Traffic(i,j)=0;
        end 
    end
end
home=zeros(numel(Backbone_Node));
for i=1:numel(Backbone_Node)
   for j=1:numel(Backbone_Node)
       if sum_hop(j,i)==2
           home(j,i)=Center_Backbone_Node;
       elseif sum_hop(j,i)>2
           if Cost(Backbone_Node(i),Center_Backbone_Node)+Cost(Center_Backbone_Node,Backbone_Node(j))<Cost(Backbone_Node(i),Predecessor)+Cost(Predecessor,Backbone_Node(j))
                home(j,i)=Center_Backbone_Node;
           else home(j,i)=Predecessor;
           end
       end
   end
end

waitforbuttonpress;
n=zeros(numel(Backbone_Node));Utilization2=zeros(numel(Backbone_Node));%do su dung
connection2 =zeros(numel(Backbone_Node)); %Ket noi 
tb=zeros(numel(Backbone_Node)); 

for i=1:numel(Backbone_Node)
    for j=1:numel(Backbone_Node)
        
        n(j,i)=ceil(Traffic(Backbone_Node(j),Backbone_Node(i))/Capacity);
        Utilization2(j,i)= Traffic(Backbone_Node(j),Backbone_Node(i))/(n(j,i)*Capacity);
        
        if Backbone_Node(i)~=Center_Backbone_Node&Backbone_Node(j)~=Center_Backbone_Node&Backbone_Node(i)~=home&Backbone_Node(j)~=home
            if Utilization2(j,i)>umin
                draw_addition_connection2(j,i)= plot([x_Node(Backbone_Node(i)),x_Node(Backbone_Node(j))],[y_Node(Backbone_Node(i)),y_Node(Backbone_Node(j))],'b');
                connection2(j,i)=connection2(j,i)+n(i,j);
                connection2(i,j)=connection2(j,i);
            else
%                 Backbone_Node(find(Backbone_Node==home(i,j)));
                Traffic(Backbone_Node(j),Backbone_Node(find(Backbone_Node==home(j,i))))=Traffic(Backbone_Node(j),Backbone_Node(find(Backbone_Node==home(j,i))))+Traffic(Backbone_Node(j),Backbone_Node(i));
                Traffic(Backbone_Node(find(Backbone_Node==home(j,i))),Backbone_Node(i))=Traffic(Backbone_Node(find(Backbone_Node==home(j,i))),Backbone_Node(i))+Traffic(Backbone_Node(j),Backbone_Node(i));
                Traffic(Backbone_Node(i),Backbone_Node(find(Backbone_Node==home(i,j))))=Traffic(Backbone_Node(i),Backbone_Node(find(Backbone_Node==home(i,j))))+Traffic(Backbone_Node(i),Backbone_Node(j));
                Traffic(Backbone_Node(find(Backbone_Node==home(i,j))),Backbone_Node(j))=Traffic(Backbone_Node(find(Backbone_Node==home(i,j))),Backbone_Node(j))+Traffic(Backbone_Node(i),Backbone_Node(j));
            end           
        end
        
    end
end
for i=1:numel(Backbone_Node)
    for j=1:numel(Backbone_Node)
        tb(j,i)=Traffic(Backbone_Node(j),Backbone_Node(i));
    end
end
xlswrite('Luuluongbackbone',tb);
text3_to_display = cellstr(num2str(connection2));
% xlswrite('connection2',connection2);     %Xuat bien connection (so luong ket noi) ra file .xls
set(handles.textsolienket2, 'String', text3_to_display);
xlswrite('Utilization2',Utilization2);   %Xuat bien Utilization (do su dung) ra file .xls
saveas(gcf,'Cau 2.png');

waitforbuttonpress;
% +------------------------------------------------------------------------+
% |                                Cau 3                                   |
% +------------------------------------------------------------------------+
delete(draw_addition_connection2);
waitforbuttonpress;
Traffic = zeros(length(Node));    %Khai bao bien Luu Luong - Traffic
for i=1:length(Node)-2
    Traffic(i,i+2)=1;
    Traffic(i+2,i)=1;
end
for i=1:length(Node)-10
    Traffic(i,i+10)=2;
    Traffic(i+10,i)=2;
end
for i=1:length(Node)-8
    Traffic(i,i+8)=3;
    Traffic(i+8,i)=3;
end
Traffic(7,13)=15; Traffic(13,7)=Traffic(7,13);
Traffic(24,69)=6; Traffic(69,24)=Traffic(24,69);
Traffic(20,48)=26; Traffic(48,20)=Traffic(20,48);
Traffic(35,55)=10; Traffic(55,35)=Traffic(35,55);
Traffic(3,14)=Traffic(3,14)+5;Traffic(14,3)=Traffic(3,14);
Traffic(15,30)=Traffic(15,30)+3;Traffic(30,15)=Traffic(15,30);
Traffic(13,70)=Traffic(13,70)+10;Traffic(70,13)=Traffic(13,70);
Traffic(40,78)=Traffic(40,78)+4;Traffic(78,40)=Traffic(40,78);
A = sum (Traffic);
Node_Weight3=ones(1,length(Node));

for i = 1:length(Node)
     Node_Weight3(i) = A(i);
end

%Threshold_Weight= str2double(W);
%RPARM= str2double(RPARM);
%Capacity= str2double(C);
% Tinh Cost
Cost = zeros(length(Node));
for i=1:length(Node)
    for j=1:length(Node)
        Cost(j,i)=0.5*sqrt((x_Node(j)-x_Node(i))^2+(y_Node(j)-y_Node(i))^2);
    end
end
%Tim cac nut backbone thoa man tieu chuan trong so
Backbone_Node3=[];
Normalized_Weight=zeros(1,length(Node));    %Khoi tao trong so chuan hoa (Normalized Weight)
for i=1:length(Node)
    Normalized_Weight(i) = Node_Weight3(i)/Capacity;
    if Normalized_Weight(i)>Threshold_Weight
        Backbone_Node3=[Backbone_Node3 i];
    end
end

%Tim cac nut truy nhap cho nut cac backbone
Max_Cost=max(max(Cost));    %Tinh Max Cost
%Radius = Max_Cost*RPARM;      %Tinh ban kinh duong tron
access_node_for_1st_backbone=[];    %Khoi tao cac nut truy nhap cho nut Backbone thu nhat
Condition3=Backbone_Node3;   %Dieu kien xet
for i=1:length(Node)
    if (i~=Condition3)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node3(1)))^2+(y_Node(i)-y_Node(Backbone_Node3(1)))^2))<=Radius)
        access_node_for_1st_backbone=[access_node_for_1st_backbone i];  %Them nut i vao tap hop cac nut truy nhap
       
        node_index3(i)=Backbone_Node3(1);     %Ghi lai xem nut truy nhap thuoc backbone nao
    end
end

access_node_for_2nd_backbone=[];
Condition3=[Condition3 access_node_for_1st_backbone];
for i=1:length(Node)
    if (i~=Condition3)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node3(2)))^2+(y_Node(i)-y_Node(Backbone_Node3(2)))^2))<= Radius)
        access_node_for_2nd_backbone=[access_node_for_2nd_backbone i];
        %scatter(x_Node(access_node_for_2nd_backbone),y_Node(access_node_for_2nd_backbone),'*k');
        node_index3(i)=Backbone_Node3(2);
    end
end


access_node_for_3rd_backbone=[];
Condition3=[Condition3 access_node_for_2nd_backbone];
for i=1:length(Node)
    if (i~=Condition3)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node3(3)))^2+(y_Node(i)-y_Node(Backbone_Node3(3)))^2))<=Radius)
        access_node_for_3rd_backbone=[access_node_for_3rd_backbone i];
        node_index3(i)=Backbone_Node3(3);
    end
end


access_node_for_4th_backbone=[];
Condition3=[Condition3 access_node_for_3rd_backbone];
for i=1:length(Node)
    if (i~=Condition3)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node3(4)))^2+(y_Node(i)-y_Node(Backbone_Node3(4)))^2))<=Radius)
        access_node_for_4th_backbone=[access_node_for_4th_backbone i];
        node_index3(i)=Backbone_Node3(4);
    end
end

access_node_for_5th_backbone=[];
Condition3=[Condition3 access_node_for_4th_backbone];
for i=1:length(Node)
    if (i~=Condition3)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node3(5)))^2+(y_Node(i)-y_Node(Backbone_Node3(5)))^2))<=Radius)
        access_node_for_5th_backbone=[access_node_for_5th_backbone i];
        node_index3(i)=Backbone_Node3(5);
    end
end

access_node_for_6th_backbone=[];
Condition3=[Condition3 access_node_for_5th_backbone];
for i=1:length(Node)
    if (i~=Condition3)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node3(6)))^2+(y_Node(i)-y_Node(Backbone_Node3(6)))^2))<=Radius)
        access_node_for_6th_backbone=[access_node_for_6th_backbone i];
        node_index3(i)=Backbone_Node3(6);
    end
end

Condition3=[Condition3 access_node_for_6th_backbone];
access_node_for_7th_backbone=[];
for i=1:length(Node)
    if (i~=Condition3)&(0.5*(sqrt((x_Node(i)-x_Node(Backbone_Node3(7)))^2+(y_Node(i)-y_Node(Backbone_Node3(7)))^2))<=Radius)
        access_node_for_7th_backbone=[access_node_for_7th_backbone i];
        node_index3(i)=Backbone_Node3(7);
    end
end
Condition3=[Condition3 access_node_for_7th_backbone];
%--------------------------------------------------------------------------

x_center_of_gravity1=sum(Node_Weight3(:).*x_Node(:))/sum(Node_Weight3);
y_center_of_gravity1=sum(Node_Weight3(:).*y_Node(:))/sum(Node_Weight3);
Distance_To_CG=zeros(1,length(Node));
for i=1:length(Node)
    Distance_To_CG(i)=sqrt((x_Node(i)-x_center_of_gravity1)^2+(y_Node(i)-y_center_of_gravity1)^2);
end
Max_Distance_To_CG=max(Distance_To_CG);
Max_W=max(Node_Weight3);
%Tinh toan Merit
Merit=zeros(1,length(Node));
for i=1:length(Node)
    Merit(i)=0.5*(Max_Distance_To_CG-Distance_To_CG(i))/Max_Distance_To_CG+0.5*(Node_Weight3(i)/Max_W);
end
Merit(Condition3)=0;
Access_Node=[];

while find(Merit~=0)~=0
    [Merit_index, index1]=max(Merit);
   
    Merit(index1)=0;
    Backbone_Node3=[Backbone_Node3 index1];    %Them nut Backbone moi vao tap hop cac nut Backbone

    for i=1:length(Node)
        if (Merit(i)~=0)&&(0.5*(sqrt((x_Node(i)-x_Node(index1))^2+(y_Node(i)-y_Node(index1))^2))<=Radius)
            Access_Node=[Access_Node i];    %Them nut truy nhap vao tap hop cac nut truy nhap tuong ung voi nut backbone
        end
    end
    for j=1:numel(Access_Node)
        node_index3(Access_Node(j))=index1;
    end
    Merit(Access_Node)=0;Merit_index=[];
    index1=[];
    Access_Node=[];

end

Alpha = str2double(Alpha);     %Nhap alpha
moment=Node_Weight3*Cost;
[moment_Center_Backbone_Node3,k]= min(moment(Backbone_Node3));
Center_Backbone_Node3=find(moment==moment_Center_Backbone_Node3);

xlswrite('Traffic3',Traffic);
xlswrite('NodeWeight3',Node_Weight3);
waitforbuttonpress;

Label = inf(1,length(Node));  %Khoi tao nhan (Label)
Sub_Label = inf(1,length(Node));
Label(Center_Backbone_Node3)=0; %Nhan nut trung tam
Sub_Label(Center_Backbone_Node3)=0;
Connected_Backbone_Node3 = Center_Backbone_Node3;   
Condition4 = Center_Backbone_Node3; %dieu kien
Predecessor=Center_Backbone_Node3;   %Khoi tao nut tien nhiem (Predecessor)
hop=zeros(1,numel(Backbone_Node3));  %Khoi tao buoc nhay (hop)
Alpha=0.3;
while numel(Connected_Backbone_Node3)~=numel(Backbone_Node3)
    for i=1:numel(Backbone_Node3)
        if Backbone_Node3(i)~= Condition4
            Sub_Label(Backbone_Node3(i))= Alpha*Cost(Backbone_Node3(i),Predecessor)+Sub_Label(Predecessor); %Nhan Prim - Dijkstra
            Label(Backbone_Node3(i))=Sub_Label(Backbone_Node3(i));
            hop(i)=hop(find(Backbone_Node3 == Predecessor))+1;
        end
    end
    
    next_Backbone_Node3=find(Sub_Label==min(Sub_Label(Sub_Label~=0)))
    Sub_Label(next_Backbone_Node3)=0;
    Condition4=[Condition4,next_Backbone_Node3];
    Connected_Backbone_Node3=[Connected_Backbone_Node3, next_Backbone_Node3]; %Ket noi cac nut backbone
    for j=1:numel(Backbone_Node3)
        
        if (Backbone_Node3(j)~=Condition4)&(Cost(Backbone_Node3(j),next_Backbone_Node3) < Sub_Label(Backbone_Node3(j)))
            
            Predecessor=next_Backbone_Node3;
            Sub_Label(Backbone_Node3(j))=Sub_Label(Backbone_Node3(j))+Sub_Label(Predecessor);
            Label(Backbone_Node3(j))=Label(Backbone_Node3(j))+Label(Predecessor);
            hop(j)=hop(find(Backbone_Node3==Predecessor))+1;
        end
    end
    next_Backbone_Node3=[];
end

for i=1:numel(Backbone_Node3)
    for j=1:numel(Backbone_Node3)
        sum_hop(j,i)=hop(j)+hop(i);
    end
end
umin=str2double(Umin);
for i=1:numel(Backbone_Node3)
    node_index3(Backbone_Node3(i))= Backbone_Node3(i);
end
for i=1:length(Node)
    for j=1:length(Node)
        if node_index3(j)==node_index3(i)
            Traffic(j,i)=0;Traffic(i,j)=0;
        elseif i==j
            Traffic(j,i)=0;Traffic(i,j)=0;
        else
            Traffic(node_index3(j),node_index3(i))=Traffic(node_index3(j),node_index3(i))+Traffic(j,i);
            Traffic(node_index3(i),node_index3(j))=Traffic(node_index3(j),node_index3(i));
            Traffic(j,i)=0;Traffic(i,j)=0;
        end 
    end
end
home=zeros(numel(Backbone_Node3));
for i=1:numel(Backbone_Node3)
   for j=1:numel(Backbone_Node3)
       if sum_hop(j,i)==2
           home(j,i)=Center_Backbone_Node3;
       elseif sum_hop(j,i)>2
           if Cost(Backbone_Node3(i),Center_Backbone_Node3)+Cost(Center_Backbone_Node3,Backbone_Node3(j))<Cost(Backbone_Node3(i),Predecessor)+Cost(Predecessor,Backbone_Node3(j))
                home(j,i)=Center_Backbone_Node3;
           else home(j,i)=Predecessor;
           end
       end
   end
end
2
n=zeros(numel(Backbone_Node3));Utilization4=zeros(numel(Backbone_Node3));%do du dung
connection4 =zeros(numel(Backbone_Node3)); %Ket noi 
tb=zeros(numel(Backbone_Node3)); 

for i=1:numel(Backbone_Node3)
    for j=1:numel(Backbone_Node3)
        n(j,i)=ceil(Traffic(Backbone_Node3(j),Backbone_Node3(i))/Capacity);
        Utilization4(j,i)= Traffic(Backbone_Node3(j),Backbone_Node3(i))/(n(j,i)*Capacity);
        if Backbone_Node3(i)~=Center_Backbone_Node3&Backbone_Node3(j)~=Center_Backbone_Node3&Backbone_Node3(i)~=home&Backbone_Node3(j)~=home
        
            if Utilization4(j,i)>umin
%                 draw_addition_connection4(j,i)= plot([x_Node(Backbone_Node3(i)),x_Node(Backbone_Node3(j))],[y_Node(Backbone_Node3(i)),y_Node(Backbone_Node3(j))],'b');
                connection4(j,i)=connection4(j,i)+n(j,i);
                connection4(i,j)=connection4(j,i);
            else
                Traffic(Backbone_Node3(j),find(Backbone_Node3==home(j,i)))=Traffic(Backbone_Node3(j),find(Backbone_Node3==home(j,i)))+Traffic(Backbone_Node3(j),Backbone_Node3(i));
                Traffic(find(Backbone_Node3==home(j,i)),Backbone_Node3(i))=Traffic(find(Backbone_Node3==home(j,i)),Backbone_Node3(i))+Traffic(Backbone_Node3(j),Backbone_Node3(i));
                Traffic(Backbone_Node3(i),find(Backbone_Node3==home(i,j)))=Traffic(Backbone_Node3(i),find(Backbone_Node3==home(i,j)))+Traffic(Backbone_Node3(i),Backbone_Node3(j));
                Traffic(find(Backbone_Node3==home(i,j)),Backbone_Node3(j))=Traffic(find(Backbone_Node3==home(i,j)),Backbone_Node3(j))+Traffic(Backbone_Node3(i),Backbone_Node3(j));
                %draw_addition_connection4(j,i)= plot([x_Node(Backbone_Node3(i)),x_Node(Backbone_Node3(j))],[y_Node(Backbone_Node3(i)),y_Node(Backbone_Node3(j))],'b');
                %connection4(j,i)=connection4(j,i)+1;
                %connection4(i,j)=connection4(j,i);
            end
        end
        tb(j,i)=Traffic(Backbone_Node3(j),Backbone_Node3(i));
    end
end
3
xlswrite('Traffic_Backbone3',tb); 
text4_to_display = cellstr(num2str(connection4));
% xlswrite('connection4',connection4);     %Xuat bien connection (so luong ket noi) ra file .xls
set(handles.textsolienket3, 'String', text4_to_display);
xlswrite('Utilization4',Utilization4);   %Xuat bien Utilization (do su dung) ra file .xls
%saveas(gcf,'Cau 2.png');
4

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

