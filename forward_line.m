%% Forward (Straight Line)
init
model_v='A';
get_model

%% 计算系数矩阵A
A=cal_A(Rays,xmin,xmax,ymin,ymax,nx,ny);


%% 计算初至走时
t=A*(1./v(:));


%% 可视化
figure
pv_title='High&Low Velocity';
pv_v=v;
plot_velocity
saveas(gcf,'Image/Forward (Straight Line) - Velocity.png');
 
plot_first_arrival_time(t,'r-x');
saveas(gcf,'Image/First Arrival Time.png');
