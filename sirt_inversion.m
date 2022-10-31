%% SIRT
forward

 
%%
% figure
% pv_title='High&Low Velocity';
% pv_v=v;
% plot_velocity

%% test
% figure
% pv_title='High&Low Velocity';
% pv_v=s2v(pinv(A)*t);
% plot_velocity

%% INVERSION
max_iter=10;
ims=cell(1,max_iter);

s=ones(mn,1)/2500;
E_SIRT=zeros(max_iter,1);
X_SIRT=zeros(mn,1);

for iter=1:max_iter
    A=cal_A_moser(xmin,ymin,dx,dy,nx,ny,s);

    tc=A*s;
    deltat=t-tc;
    %     e=norm(deltat);
    %     e=mean(deltat.^2);
    e=rms(deltat);
    fprintf('第%d次迭代，Error：%f \n',iter,e);
    E_SIRT(iter,1)=e; 

    deltas=zeros(mn,1);
    for j=1:mn
        Nj=length(A(A(:,j)>0));
        c=sum(A(:,j).*deltat./sum(A.^2,2),1);
        deltas(j,1)=c/Nj;

    end
    
    s=s+deltas;
    s=max(s,1/vlim(2));
    s=min(s,1/vlim(1));
    X_SIRT(:,iter)=s;
     
    figure(3)
    pv_v=s2v(s);
    pv_title=sprintf('SIRT - (%d)',iter);
    plot_velocity
    ims{iter}=frame2im(getframe(gcf));

end
v_sirt=s2v(X_SIRT(:,end));

% save result
save("Data\Inversion_Results.mat","X_SIRT","E_SIRT","v_sirt","v",'-append');

%% 生成GIF
save2gif(ims,'Image\SIRT_Inversion_Velocity.gif',.2)

%% 可视化
x=1:length(t);
plot_first_arrival_time(x,t,'r-x',x,tc,'b-o');
 

figure(4)
semilogy(E_SIRT,'r-x')
title 'SIRT'



