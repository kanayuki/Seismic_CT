%% GN
forward
  

%% INVERSION
max_iter=10;
ims=cell(1,max_iter);

s=ones(mn,1)/2500;
E_GN=zeros(max_iter,1);
X_GN=zeros(mn,1);
 
for iter=1:max_iter
    A=cal_A_moser(xmin,ymin,dx,dy,nx,ny,s);

    tc=A*s;
    deltat=t-tc;
    %     e=norm(deltat);
    %     e=mean(deltat.^2);
    e=rms(deltat);
    fprintf('第%d次迭代，Error：%f \n',iter,e);
    E_GN(iter,1)=e;

    J=A'*A;
    H=J*J+(.618e-1)*eye(mn);
    deltas=pinv(H)*J*A'*deltat;
   
    s=s+deltas;
    s=max(s,1/vlim(2));
    s=min(s,1/vlim(1));
    X_GN(:,iter)=s;
 
    % plot
    figure(3)
    pv_v=s2v(s);
    pv_title=sprintf('GN - (%d)',iter);
    plot_velocity
    ims{iter}=frame2im(getframe(gcf));


end
v_gn=s2v(X_GN(:,end));

%% Save Result
save("Data\Inversion_Results.mat","X_GN","E_GN","v_gn","v",'-append');

%% 生成GIF
save2gif(ims,'Image\GN_Inversion_Velocity.gif',.2)


%% 可视化
x=1:length(t);
plot_first_arrival_time(x,t,'r-x',x,tc,'b-o');

figure(4)
semilogy(E_GN,'r-x')
title 'GN'
 



