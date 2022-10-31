%% Plot Velocity

% pv_title='Velocity';
% pv_v=2500*ones(ny,nx);

 
[mesh_x,mesh_y]=meshgrid([xmin, xmin+dx/2:dx:xmax-dx/2, xmax], ...
    [ymin, ymin+dy/2:dy:ymax-dy/2, ymax]);

contourf(mesh_x,mesh_y,padv(pv_v),100,'LineStyle','none');

c=colorbar;
c.Label.String='Velocity (m/s)';
colormap('jet');
 
title(pv_title,'FontWeight','bold');
xlabel('x (m)');
ylabel('y (m)');
axis equal
set(gca,'Clim',vlim)
set(gca,'FontSize',12,'FontName','Times New Roman');
set(gca,"YDir","reverse")

hold on;
% rectangle("Position",[4 6 2 2],"LineWidth",2,"EdgeColor",'r')
% rectangle("Position",[4 11 2 2],"LineWidth",2,"EdgeColor",'r')

plot_frame
hold off;

