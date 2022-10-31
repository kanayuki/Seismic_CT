init
model_v='A';

dat=readmatrix("Data\高速实测.dat");
Rays=dat(:,1:4);
A=cal_A(Rays,0,10,0,20,10,20);

t=dat(:,5);

 
 
%% 可视化
[X_LSQR,E_LSQR] = lsqr(A,t,1000);
v_lsqr=X_LSQR(:,end);
v_lsqr=s2v(v_lsqr);

figure
pv_title='LSQR Inversion Imaging';
pv_v=v_lsqr;
plot_velocity
 
 
%% INVERSION
max_iter=30;
ims=cell(1,max_iter);

s=ones(mn,1)/2500;
E_LSQR=zeros(max_iter,1);
X_LSQR=zeros(mn,1);

for iter=1:max_iter
    A=cal_A_moser(xmin,ymin,dx,dy,nx,ny,s);

    tc=A*s;
    deltat=t-tc;
    %     e=norm(deltat);
    e=rms(deltat.^2);
    fprintf('第%d次迭代，Error：%f \n',iter,e);
    E_LSQR(iter,1)=e; 
  
    deltas = lsqr(A,deltat,10);
    s=s+deltas(:,end);
    s=max(s,1/vlim(2));
    s=min(s,1/vlim(1));
    X_LSQR(:,iter)=s;
     
    figure(3)
    pv_v=s2v(s);
    pv_title=sprintf('LSQR - (%d)',iter);
    plot_velocity
    ims{iter}=frame2im(getframe(gcf));

end
v_lsqr=s2v(X_LSQR(:,end));

%% Save Result
save("Data\Inversion_Results.mat","X_LSQR","E_LSQR","v_lsqr","v",'-append');

%% 生成GIF
save2gif(ims,'Image\LSQR_Inversion_Velocity.gif',.2)
 
%% 可视化
x=1:length(t);
plot_first_arrival_time(x,t,'r-x',x,tc,'b-o');

figure(4)
semilogy(E_LSQR,'r-x')
title 'LSQR'




%% 
function [X,rho ] = lsqr(A,b,k)
 
[m,n] = size(A); 

X = zeros(n,k);
 
eta = zeros(k,1); rho = eta;
c2 = -1; s2 = 0; xnorm = 0; z = 0;
 
v = zeros(n,1); x = v; beta = norm(b);

u = b/beta;
r = A'*u; alpha = norm(r);
v = r/alpha;

phi_bar = beta; 
rho_bar = alpha; w = v;

 
for i=2:k+1
    p = A*v - alpha*u;
    beta = norm(p); u = p/beta;

    r = A'*u - beta*v;
    alpha = norm(r); v = r/alpha;
 
    rrho = norm([rho_bar,beta]); 
    c1 = rho_bar/rrho;
    s1 = beta/rrho; 
    theta = s1*alpha; 
    rho_bar = -c1*alpha;
    phi = c1*phi_bar; 
    phi_bar = s1*phi_bar;
 
    delta = s2*rrho; 
    gamma_bar = -c2*rrho; 
    rhs = phi - delta*z;
    z_bar = rhs/gamma_bar; 
    eta(i-1) = norm([xnorm,z_bar]);
    gamma = norm([gamma_bar,theta]);
    c2 = gamma_bar/gamma; 
    s2 = theta/gamma;
    z = rhs/gamma; 
    xnorm = norm([xnorm,z]);
    rho(i-1) = abs(phi_bar);
 
    x = x + (phi/rrho)*w;
    w = v - (theta/rrho)*w;
    X(:,i-1) = x;

end

end


