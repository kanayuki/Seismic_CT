%% GN0 (原算法)

forward
  

%% INVERSION
max_iter=10;
ims=cell(1,max_iter);

s=ones(mn,1)/2500;
E_GN0=zeros(max_iter,1);
X_GN0=zeros(mn,1);

for iter=1:max_iter
    A=cal_A_moser(xmin,ymin,dx,dy,nx,ny,s);

    tc=A*s;
    deltat=t-tc;
    %     e=norm(deltat);
    %     e=mean(deltat.^2);
    e=rms(deltat);
    fprintf('第%d次迭代，Error：%f \n',iter,e);
    E_GN0(iter,1)=e;

    
    G = full(A'*A)+ 1*eye(mn);
    d = full(A')*deltat;
    deltas = G\d; 

    s=s+deltas;
    s=max(s,1/vlim(2));
    s=min(s,1/vlim(1));
    X_GN0(:,iter)=s;
 
    % plot
    figure(3)
    pv_v=s2v(s);
    pv_title=sprintf('GN0 - (%d)',iter);
    plot_velocity
    ims{iter}=frame2im(getframe(gcf));


end

v_gn0=s2v(X_GN0(:,end));

%% Save Result
save("Data\Inversion_Results.mat","X_GN0","E_GN0","v_gn0","v",'-append');

%% 生成GIF
save2gif(ims,'Image\GN0_Inversion_Velocity.gif',.2)


%% 可视化
x=1:length(t);
plot_first_arrival_time(x,t,'r-x',x,tc,'b-o');

figure(4)
semilogy(E_GN0,'r-x')
title 'GN0'
 


%%
function [X,E]=gn(A,b,x0,max_iter,u)

X=zeros(size(A,2),max_iter);
E=zeros(max_iter,1);

J=A;
% H=(J'*J+u*eye(mn));
H=(J*J+u*eye(mn));
 
for i=1:max_iter
    e=A*x0-b;
%     delta_x=-pinv(H)*(J'*e);
%     delta_x=-H\(J'*e);
    delta_x=-H\(J*e);
    x0=x0+delta_x;

    X(:,i)=x0;

    E(i)=norm(A*x0-b);
end
   
end


