% Name:³¯¬M¿² ID:0516233

% Create a series of numbers
x = 3:100;  y = sin(.05*x + .002*x.^2) .* (1 - x.*x/20000); 

% Use find fuction to find the local maximums and local minimums
% max and min are separately the indices of the local maximums and local minimums
% p and q separately have the x values and the y values of the local maximums and local minimums
max=find(sin(.05*x + .002*x.^2) .* (1 - x.*x/20000) >= sin(.05*(x-1) + .002*(x-1).^2) .* (1 - (x-1).*(x-1)/20000) & sin(.05*x + .002*x.^2) .* (1 - x.*x/20000) >= sin(.05*(x+1) + .002*(x+1).^2) .* (1 - (x+1).*(x+1)/20000));
p=[x(max);y(max)];
min=find(sin(.05*x + .002*x.^2) .* (1 - x.*x/20000) <= sin(.05*(x-1) + .002*(x-1).^2) .* (1 - (x-1).*(x-1)/20000) & sin(.05*x + .002*x.^2) .* (1 - x.*x/20000) <= sin(.05*(x+1) + .002*(x+1).^2) .* (1 - (x+1).*(x+1)/20000));
q=[x(min);y(min)];

% Find the lists of monotonically increasing and monotonically decreasing segments
% tmp exclude the two end-points of the whole series of numbers
tmp=[p(1,:) q(1,:)];
tmp=sort(tmp);
% inc are the monotonically increasing segments
% dec are the monotonically decreasing segments
if(p(1,1)<q(1,1) & p(1,end)<q(1,end))
    inc=[x(1) tmp x(end)];
    dec=[tmp];
elseif(p(1,1)<q(1,1) & p(1,end)>q(1,end))
    inc=[x(1) tmp];
    dec=[tmp x(end)];
elseif(p(1,1)>q(1,1) & p(1,end)<q(1,end))
    inc=[tmp x(end)];
    dec=[x(1) tmp];
else
    inc=[tmp];
    dec=[x(1) tmp x(end)];
end

% List the local maximums and local minimums in (x,y) pairs using fprintf function
fprintf('Local maximums:\n');
fprintf(' (%d, %.2f)\n',p);
fprintf('Local minimums:\n');
fprintf(' (%d, %.2f)\n',q);
% Print out the lists of monotonically increasing and monotonically decreasing segments
fprintf('Monotonically increasing segments:\n');
fprintf('%3d - %3d\n',inc);
fprintf('Monotonically decreasing segments:\n');
fprintf('%3d - %3d\n',dec);

% Plot the (x,y) points of the whole series of numbers
plot(x,y,'b.-');
hold on
% Mark the local maximums and local minimums with additional plots
plot(tmp,sin(.05*tmp + .002*tmp.^2) .* (1 - tmp.*tmp/20000),'rs');
hold off