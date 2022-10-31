function [] = plot_first_arrival_time(varargin)
% 初至走时图
figure

plot(varargin{:});

title('First Arrival Time','FontWeight','bold');
xlabel('Ray Identifier');
ylabel('Time (s)');
% axis([-2 size(t,1)+2 0 1.1*max(t)]);
set(gca,'FontSize',12,'FontName','Times New Roman');
grid on

