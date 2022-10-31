%% LSQR0 (原算法)
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
E_LSQR0=zeros(max_iter,1);
X_LSQR0=zeros(mn,1);

for iter=1:max_iter
    A=cal_A_moser(xmin,ymin,dx,dy,nx,ny,s);

    tc=A*s;
    deltat=t-tc;
    %     e=norm(deltat);
    %     e=mean(deltat.^2);
    e=rms(deltat);
    fprintf('第%d次迭代，Error：%f \n',iter,e);
    E_LSQR0(iter,1)=e; 
  
    deltas = sxm_lsqr(mn,A,deltat,mn,10);
    s=s+deltas; 
    s=max(s,1/vlim(2));
    s=min(s,1/vlim(1));
    X_LSQR0(:,iter)=s;
     
    figure(3)
    pv_v=s2v(s);
    pv_title=sprintf('LSQR0 - (%d)',iter);
    plot_velocity
    ims{iter}=frame2im(getframe(gcf));

end
v_lsqr0=s2v(X_LSQR0(:,end));

%% Save Result
save("Data\Inversion_Results.mat","X_LSQR0","E_LSQR0","v_lsqr0","v",'-append');

%% 生成GIF
save2gif(ims,'Image\LSQR0_Inversion_Velocity.gif',.2)
 
%% 可视化
x=1:length(t);
plot_first_arrival_time(x,t,'r-x',x,tc,'b-o');

figure(4)
semilogy(E_LSQR0,'r-x')
title 'LSQR0'



%% Sub Function

function [x1]=sxm_lsqr(n,A,b,damp,itnlim)
x1 = zeros(n,1);
B  = A'*A + damp*eye(n);
b1 = A'*b;

r = b1 - B*x1;
p = r;
for itn = 1:itnlim
    alfa = r'*r/(p'*(B*p));
    x1    = x1 + alfa*p;
    rhoold = r'*r;
    r    = r - alfa*B*p;
    rhonew = r'*r;
    beta = rhonew/rhoold;
    p    = r + beta*p;
end
end


