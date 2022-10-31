%% Quantization
init
set_model

load('Data\Inversion_Results.mat');
 
im_a=mat2gray(flipud(v),vlim);
label_arr={'SIRT','LSQR','GN','GN0','LSQR0'};
im_bs={v_sirt,v_lsqr,v_gn,v_gn0,v_lsqr0};
num=length(im_bs);
RMSE=zeros();
CORR=zeros();
SSIM=zeros();
for i=1:num
    im_b=mat2gray(flipud(im_bs{i}),vlim);
    im_bs{1,i}=im_b;
    im_err = double(im_a)-double(im_b);
    % 计算 RMSE CORR 和 SSIM
%     RMSE(1,i)=sqrt(mean(im_err(:).^2));
    RMSE(1,i)=rms(im_err(:));
    CORR(1,i)=corr2(im_a,im_b);
    SSIM(1,i)=ssim(im_a,im_b);

    %     str=sprintf('RMSE: %0.3f, CORR: %0.3f, SSIM: %0.3f',RMSE,CORR,SSIM);
    %     disp(str);
end



%% 保存
% imwrite(im_out,'im_out(quality = 5).tif');
save('Data/RMSE&CORR&SSIM.mat','RMSE','CORR','SSIM');

%% 显示结果
figure
% div=ones(ny,1);
% % imshow([im_a,div,im_b,div,im_err],'InitialMagnification','fit')
% % montage({im_a,im_b,im_err})
% montage([im_a,div,im_b,div,im_err])

title 'Quantization PK'
set(gca,'FontSize',12,'FontName','Times New Roman');

% tiledlayout(1,5,'TileSpacing','compact','Padding','compact')
% nexttile
 
subplot(1,num+1,1)
imshow(im_a,'InitialMagnification','fit')
str=sprintf('模型参考 %s', model_v);
title(str)


for i=1:num
    subplot(1,num+1,i+1)
    imshow(im_bs{i},'InitialMagnification','fit')
    str=sprintf('%s \nRMSE: %0.3f \nCORR: %0.3f \nSSIM: %0.3f', ...
        label_arr{i},RMSE(i),CORR(i),SSIM(i));
    title( str)
end




