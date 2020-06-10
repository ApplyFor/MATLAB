function mylab9
figure;
hold on;
axis equal;
axis([0 1 0 1]);

r=0.1;
w=0.5;
color='k';

while(1)
    set(gcf', 'unit', 'pixels');
    k = waitforbuttonpress;
    switch k
        case 1
            t = get(gcf, 'CurrentCharacter');
            switch t
                case {'1','2','3','4','5','6','7','8','9'}
                    w=0.5*(t-'0');
                case { 'r', 'b', 'k', 'w', 'y', 'c', 'm', 'g'}
                    color=t;
                case '+'
                    r=r*1.1;
                case '-'
                    r=r*0.9;
                case 'X'
                    cla;
                case 'q'
                    close;
                    break;
                otherwise
            end
        case 0
            t= get(gca,'CurrentPoint');
            x=t(1,1);%(2,1)
            y=t(1,2);%(2,2)
            plot(x+r*cosd(0:360),y+r*sind(0:360),'Color',color,'LineWidth',w);
        otherwise
    end
    string=sprintf('color=%c width=%f radius=%f',color,w,r);
    title(string);
end

end


