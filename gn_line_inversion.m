%% 测试使用Gauss-Newton Iterative Inversion Imaging
 

% A'*A*x=A'*t
a=A'*A;
b=A'*t;
u=.1314e-5;

x0=ones(200,1)*(1/2500);
% x0=pinv(A)*t;
% x0=X_LSQR(:,30);
max_iter=1000;

tic;

% [X_GN,E_GN]=gn(A,t,x0,max_iter,u);
[X_GN,E_GN]=gn(a,b,x0,max_iter,u);

fprintf('GN 迭代%d次用时%f\n',max_iter,toc);

save('Data/Gauss-Newton_Inversion_Result',"X_GN","E_GN")
 

%% 可视化
% 高斯消去法
% v_n=A\t;
% v_n=a\b;
% 伪逆
% v_n=pinv(A)*t;
% v_n=pinv(a)*b;

v_gn=X_GN(:,end);
v_gn=s2v(v_gn);

figure
pv_title='Newton Inversion Imaging';
pv_v=v_gn;
plot_velocity

saveas(gcf,'Image/Newton Inversion-velocity.png');

ax_newton_v=gca;
