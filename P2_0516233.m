function P2_0516233
 N = 200;
 A = [10 8; -15 30]; d = [5 -10];
 X = randn(N,2) * A + repmat(d, N, 1);
 fn(X);
return;

function fn(X)
 m=mean(X); %compute the mean vector
 c=cov(X); %compute the covariance matrix
 N=size(X,1);
 p=zeros(N/2+1,N/2+1); %initialize p
 range=-N/2:2:N/2;
 r=-1*range;
 a=1;
 b=1;
 for jj = range
     for ii = range
         x=[ii,jj]-m; %create a dense 2-D grid of points
         p(a,b)=1/(sqrt((2*pi)^2*det(c)))*exp(-1/2*(x-m)*inv(c)*(x-m).'); %use the equation to compute p(x)
         b=b+1;
     end
     a=a+1;
     b=1;
 end
 axis([range(1) range(end) range(1) range(end)])
 hold on
 imagesc(range,range,p) %plot p(x) using contour
 colormap summer
 contour(range,range,p,5,'k') %plot p(x) using pseudo-color plots
 scatter(X(:,1),X(:,2),'dk','MarkerFaceColor','k') %show the original sample points
 hold off
return;
