function [pv]=padv(v)
pv=[v(1,:);v;v(end,:)];
pv=[pv(:,1),pv,pv(:,end)];
end
