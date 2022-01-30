
show(map);
hold on
set(gca,'ytick',linspace(0,100,25))
set(gca,'xtick',linspace(0,100,25))

pts = [0;0;0];
button = 1;
while sum(button) <=3   % read ginputs until a mouse right-button occurs
    [x,y,button] = ginput(3); 
    pts = [pts,[x';y';[pi,pi,pi]]];
    
end

pts(:,1) = [];
pts(:,end) = [];

close all
show(map)
hold on
scatter(pts(1,:),pts(2,:), '*')