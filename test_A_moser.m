L=reshape(A(2,:),6,5);
img=mat2gray(L);
figure
imshow(img,'InitialMagnification','fit')

%%
t=A*s;
plot_first_arrival_time(t)