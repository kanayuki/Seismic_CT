function save2gif(ims,path,delay)
%% 生成GIF
 
if nargin==2
    delay=.1;
end

[I,Map]=rgb2ind(ims{1},256);
imwrite(I,Map,path,'gif','LoopCount',inf,'DelayTime',delay)

for i=2:length(ims) 
    [I,Map]=rgb2ind(ims{i},256);
    imwrite(I,Map,path,'gif','WriteMode','append','DelayTime',delay)
 
end






