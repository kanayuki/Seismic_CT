%% 初始化环境
clear
clc
close all


%% 初始化射线
[sy,ry]=ndgrid(.5:1:19.5);
Rays(:,2)=sy(:);
Rays(:,3)=10;
Rays(:,4)=ry(:);


%% 初始化网格参数
xmin=0;
xmax=10;
ymin=0;
ymax=20;
nx=10;
ny=20;
mn=nx*ny;

dx=(xmax-xmin)/nx;
dy=(ymax-ymin)/ny;


%% 初始化速度
vlim=[1000,4000];
% v=get_model('A');


%% 初始化绘图



%% 工具函数

% 慢度向量转速度矩阵
s2v=@(s) reshape(1./s,ny,nx);

% 速度矩阵转慢度向量
v2s=@(v) 1./v(:);

% padv=@(v) padarray(v,[1 1],"replicate");

 