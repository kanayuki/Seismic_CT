init
set_model

load('Data\Inversion_Results.mat');

vs={v,v_sirt,v_lsqr,v_gn,v_gn0,v_lsqr0};
label_arr={'Model','SIRT','LSQR','GN','GN0','LSQR0'};

figure(9)

for i=1:6
    subplot(2,3,i)
    
    pv_v=vs{i};
    pv_title=label_arr{i};
    plot_velocity
     
end

