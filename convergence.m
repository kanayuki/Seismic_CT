%% Convergence
clear,clc 
load('Data\Inversion_Results.mat');
 
x=1:10;
y=[E_SIRT, E_LSQR, E_GN, E_LSQR0, E_GN0];
 
figure
semilogy(x,y,'-')
legend('SIRT','LSQR','GN','LSQR0','GN0')

title('Convergence Curve')
xlabel('Iteration');
ylabel('Error');

set(gca,'FontSize',12,'FontName','Times New Roman');

