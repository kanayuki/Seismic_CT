% 测试使用LSQR反演

% init
tic;
[X_LSQR,E_LSQR] = lsqr(Rays,tCal,1000);
% [X_LSQR,E_LSQR] = lsqr(A,t,1000);
fprintf('LSQR 迭代%d次用时%f\n',1000,toc);

% save result
save("Data\Inversion_Results.mat","X_LSQR","E_LSQR");
 
%% 可视化
v_lsqr=X_LSQR(:,end);
v_lsqr=s2v(v_lsqr);

figure
pv_title='LSQR Inversion Imaging';
pv_v=v_lsqr;
plot_velocity

saveas(gcf,'Image/LSQR Inversion-velocity.png');

ax_lsqr_v=gca;
