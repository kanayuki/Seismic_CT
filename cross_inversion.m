%% 交叉迭代反演

max_iter=1000;
    
tic;
x0=ones(200,1)*(1/2500);
[X_CROSS_1,E_CROSS_1] = gn(A'*A,A'*t,x0,50,1.25);
fprintf('CROSS_1 迭代%d次用时%f\n',50,toc);

x0=X_CROSS_1(:,end);
tic
% [X_CROSS_2, E_CROSS_2, iter, flag] = sor(A'*A, x0, A'*t, w, s_iter, tol);
[X_CROSS_2, E_CROSS_2] = gn(A'*A,A'*t,x0,50,.1314e-2);
fprintf('CROSS_2 迭代%d次用时%f\n',100,toc);

x0=X_CROSS_2(:,end);
tic
[X_CROSS_3, E_CROSS_3] = gn(A'*A,A'*t,x0,900,.1314e-5);
fprintf('CROSS_3 迭代%d次用时%f\n',900,toc);

X_CROSS=[X_CROSS_1, X_CROSS_2, X_CROSS_3];
E_CROSS=[E_CROSS_1; E_CROSS_2; E_CROSS_3];

% error_pk
 
 
%% 可视化
v_cross=X_CROSS(:,end);
v_cross=s2v(v_cross);

figure
pv_title='CROSS Inversion Imaging';
pv_v=v_cross;
plot_velocity

saveas(gcf,'Image/CROSS Inversion-velocity.png');

ax_cross_v=gca;



