switch model_v
    case 'A' % 匀质高低速
        rectangle("Position",[4 6 2 2],"LineWidth",2,"EdgeColor",'r');
        rectangle("Position",[4 11 2 2],"LineWidth",2,"EdgeColor",'r');
    case 'B' % 'High&Low Velocity'
        % 层状介质单个高速异常体模型
        rectangle("Position",[4 9 2 2],"LineWidth",2,"EdgeColor",'r'); 
        % 'Layer - High Velocity'
    case 'C' % 层状介质双高速异常体模型
         
        rectangle("Position",[7 7 2 2],"LineWidth",2,"EdgeColor",'r');
        rectangle("Position",[4 11 2 2],"LineWidth",2,"EdgeColor",'r');
    case 'D' % 层状介质双低速异常体模型
        
        rectangle("Position",[7 7 2 2],"LineWidth",2,"EdgeColor",'r');
        rectangle("Position",[4 11 2 2],"LineWidth",2,"EdgeColor",'r');
        %         v=v+2500;
        %         v(1:5,:)=2000;
        %         v(16:20,:)=1500;
        %         v(8:9,5:6)=1500;
        %         v(12:13,7:8)=1500;

    case 'E' % 匀质L形高速
         
        plot([3 7 7 5 5 3 3],[7 7 9 9 13 13 7],'LineWidth',2,'Color','r');
    case 'F' % 匀质L形低速
         
        plot([3 7 7 5 5 3 3],[7 7 9 9 13 13 7],'LineWidth',2,'Color','r');
    case 'G' % 4层
         
    case 'H' % 王
         
        plot([1 9 9 6 6 8 8 6 6 9 9 1 1 4 4 2 2 4 4 1 1], ...
            [5 5 7 7 10 10 12 12 14 14 16 16 14 14 12 12 10 10 7 7 5],'LineWidth',2,'Color','r');
end
