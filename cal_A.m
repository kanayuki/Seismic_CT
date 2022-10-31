function [A] = cal_A(Rays,xmin,xmax,ymin,ymax,nx,ny)
% clear
% Rays=readmatrix("垂直孤石2.dat");
% [xmin,xmax,ymin,ymax,nx,ny]=deal(0,10,0,20,10,20);

nray = size(Rays,1);
% 系数矩阵A
A=zeros(nray, nx*ny);

% 初始化网格
dx = (xmax-xmin)/nx;
dy = (ymax-ymin)/ny;
[x, y] = meshgrid(xmin:dx:xmax-dx, ymin:dy:ymax-dx);


for i=1:nray

    s = Rays(i,1:2);
    r = Rays(i,3:4);
    
    L = arrayfun(@(x,y) cal_length(x,y,dx,dy,s,r), x, y);
    A(i,:) = L(:);
    
end


% 计算结束
end


function l=cal_length(x,y,dx,dy,s,r)
    
    l=0;

    % 左右边lr，上下边tb
    if s(2)==r(2) && s(2)>y && s(2)<y+dy
        l=dx;
    else
        cp1=[];
        v=s-r;
        ly=v(2)/v(1)*(x-s(1))+s(2);
        if ly>=y && ly<=y+dy
            cp1=[x ly];
        end

        ry=v(2)/v(1)*(x+dx-s(1))+s(2);
        if ry>=y && ry<=y+dy
            cp=[x+dx ry];
            if isempty(cp1)
                cp1=cp;
            elseif ~isequal(cp,cp1)
                l=norm(cp-cp1);
                return
            end
        end

        bx=v(1)/v(2)*(y-s(2))+s(1);
        if bx>=x && bx<=x+dx
            cp=[bx y];
            if isempty(cp1)
                cp1=cp;
            elseif ~isequal(cp,cp1)
                l=norm(cp-cp1);
                return
            end
        end

        tx=v(1)/v(2)*(y+dy-s(2))+s(1);
        if tx>=x && tx<=x+dx
            cp=[tx y+dy];
            if isempty(cp1)
                % cp1=cp;
                return
            elseif ~isequal(cp,cp1)
                l=norm(cp-cp1);
                return
            end
        end

    end
  
end


