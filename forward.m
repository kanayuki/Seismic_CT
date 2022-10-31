%% Forward (Moser)
init
set_model
 
s=1./v(:);
A=cal_A_moser(xmin,ymin,dx,dy,nx,ny,s);

t=A*s;
 
%% 可视化
% figure
% pv_title='High&Low Velocity';
% pv_v=v;
% plot_velocity
% saveas(gcf,'Image/Forward - Velocity.png');
%  
% plot_first_arrival_time(t,'r-x');
% saveas(gcf,'Image/First Arrival Time.png');
