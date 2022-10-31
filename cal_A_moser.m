function [A]= cal_A_moser(xmin,ymin,dx,dy,nx,ny,s)
% close all
% clc
% clear


% xmin = 0;
% xmax = 10;
% ymin = 0;
% ymax = 20;
% nx=10;
% ny=20;
mn=nx*ny;
% s=ones(mn,1)/2500;
% dx=1;
% dy=1;

innum=5; 
[p,e,pnum,enum]=cal_tile(dx,dy,innum);

%% 遍历网格，计算所有节点的位置，边,权重l/v
ps=zeros(2,pnum*mn);
stws=zeros(3,enum*mn);
mesh_id=0;
for i=1:nx
    for j=1:ny

        ps(:,mesh_id*pnum+(1:pnum))=p+[xmin+dx*(i-1);ymin+dy*(j-1)];
        stws(:,mesh_id*enum+(1:enum))=[e(1:2,:)+[pnum*mesh_id;pnum*mesh_id];...
            e(3,:)*s(mesh_id+1,1)];

        mesh_id=mesh_id+1;
    end
end
%% 处理重复节点
ps_num=size(ps,2);
stws12=stws(1:2,:);
for m=1:ps_num
    for n=m+1:ps_num
        if isequal(ps(:,m),ps(:,n))
            stws12(stws12==n)=m;
        end
    end
end
stws=[stws12;stws(3,:)];



%% 图
% figure(6)
G=graph(stws(1,:),stws(2,:),stws(3,:));
spno=pnum-ceil(innum/2)+1:pnum:pnum*ny;
rpno=pnum*ny*(nx-1)+innum+ceil(innum/2):pnum:pnum*mn;
spnum=length(spno);
rpnum=length(rpno);
% 计算A
A=zeros(spnum*rpnum, mn);

nray=0;
for i=1:spnum
    for j=1:rpnum
        nray=nray+1;
        [P,d]=shortestpath(G,spno(i),rpno(j));
        L=zeros(ny,nx);
        for ip=1:length(P)-1
            pa=ps(:,P(ip));
            pb=ps(:,P(ip+1));
            len=norm(pa-pb);
            mid=(pa+pb)/2;
            mesh_sub=ceil(mid-[xmin;ymin]./[dx;dy]);
            L(mesh_sub(2),mesh_sub(1))=len;
        end
          
%         figure(4)
%         hold on
%         [x,y]=meshgrid(0:nx,0:ny);
%         pcolor(x,y,padarray(L,[1 1],"replicate","post"))
%         colorbar
%         path=ps(:,P);
%         plot(path(1,:),path(2,:),'r','LineWidth',2)
%         hold off
% %         drawnow
% %         pause(.1)
% 
%         img=frame2im(getframe(gcf));
%         [I,Map]=rgb2ind(img,256);
%         if nray==1
%             imwrite(I,Map,'moser-rays.gif','gif','LoopCount',inf,'DelayTime',.1)
%         else
%             imwrite(I,Map,'moser-rays.gif','gif','WriteMode','append','DelayTime',.1)
%         end
 
        %         L=flipud(L);
        A(nray,:)=L(:);
    end
end



% plot(G)
% 
% figure(5)
% % plot(p(1,:),p(2,:),'r-*','LineWidth',1)
% axis equal
% hold on
% for i=1:size(stws,2)
%     pab=ps(:,stws(1:2,i));
% 
%     plot(pab(1,:),pab(2,:),'k');
%     %     len=stws(3,i);
% end
% 
% path=ps(:,P);
% plot(path(1,:),path(2,:),'r','LineWidth',2)

% hold off

end




function [p,e,pnum,enum]=cal_tile(dx,dy,innum)

ddx=dx/innum;
ddy=dy/innum;

Rx=ddx/2:ddx:dx-ddx/2;
Ry=ddy/2:ddy:dy-ddy/2;
o=zeros(1,innum);
b=[Rx;o];
r=[o+dx;Ry];
t=[fliplr(Rx);o+dy];
l=[o;fliplr(Ry)];

p=[b,r,t,l]; % 内插点
pnum=4*innum; % 内插点数量
e=zeros(3, pnum*(pnum-1)/2);
enum=0;
for i=1:pnum
    for j=i+1:pnum
        enum=enum+1;
        l=norm(p(:,i)-p(:,j));
        e(:,enum)=[i;j;l];
    end
end
end







