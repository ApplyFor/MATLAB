classdef BigInt
    properties
        digits=0;
    end
    
    methods
        function obj=BigInt(n)
            if nargin==0
                obj.digits=0;
            elseif nargin==1 && ischar(n)
                n=n-'0';
                for i=1:numel(n)
                    if n(i)<1 || n(i)>9
                        error('Input error!');
                    end
                end
                obj.digits=n;
            elseif nargin==1 && iscellstr(n)
                obj(size(n,1),size(n,2))=BigInt; %pre-allocation
                for i=1:numel(n)
                    n{i}=n{i}-'0';
                    for j=1:numel(n{i})
                        if n{i}(j)<1 || n{i}(j)>9
                            error('Input error!');
                        end
                    end
                    obj(i).digits=n{i};
                end
            elseif nargin==1 && isa(n,'double')
                obj(size(n,1),size(n,2))=BigInt;
                tmp={};
                for i=1:numel(n)
                    if(n(i)<0)
                        error('Input error!');
                    end
                    tmp{i}=num2str(n(i));
                    tmp{i}=tmp{i}-'0';
                    obj(i).digits=tmp{i};
                end
            else
                error('Input error!');
            end
        end
        
        function  int=make_int(n)
            sum=zeros(size(n,1),size(n,2));
            for i=1:numel(n)
                time=1;
                for j=numel(n(i).digits):-1:1
                    tmp=n(i).digits(j)*time;
                    sum(i)=sum(i)+tmp;
                    time=time*10;
                end
            end
            int=sum;
        end
        function disp(n)
            int=make_int(n);
            for y=1:size(n,2)
                for x=1:size(n,1)
                    fprintf('(%d,%d)\t%d\n',x,y,int(x,y));
                end
            end
        end

        function n=plus(a,b)
            if isa(a,'BigInt') && ~isa(b,'BigInt')
                n=a;
                for i=1:numel(n)
                    n(i).digits(end)=n(i).digits(end)+b;
                end
            elseif ~isa(a,'BigInt') && isa(b,'BigInt')
                n=b;
                for i=1:numel(n)
                    n(i).digits(end)=n(i).digits(end)+a;
                end
            else
                if numel(a)==1
                    n=b;
                    for i=1:numel(n)
                        n(i).digits(end)=n(i).digits(end)+make_int(a);
                    end
                elseif numel(b)==1
                    n=a;
                    for i=1:numel(n)
                        n(i).digits(end)=n(i).digits(end)+make_int(b);
                    end
                else
                    n=make_int(a)+make_int(b);
                    n=BigInt(n);
                end
            end
            
            for i=1:numel(n)
                carry=0;
                for j=numel(n(i).digits):-1:1
                    n(i).digits(j)=n(i).digits(j)+carry;
                    carry=floor(n(i).digits(j)/10);
                    n(i).digits(j)=mod(n(i).digits(j),10);
                end
                while carry
                digit=mod(carry,10);
                n(i).digits=[digit n(i).digits];
                carry=carry-digit;
                carry=carry/10;
                end
            end
        end
        function n=times(a,b)
            if ~isempty(find((size(a)~=size(b))==1,1)) || ~isa(a,'BigInt') || ~isa(b,'BigInt')
                error('Input error!');
            end
            n=BigInt(zeros(size(a)));
            for i=1:numel(n)
                n(i).digits=conv(a(i).digits,b(i).digits);
            end
            
            for i=1:numel(n)
                carry=0;
                for j=numel(n(i).digits):-1:1
                    n(i).digits(j)=n(i).digits(j)+carry;
                    carry=floor(n(i).digits(j)/10);
                    n(i).digits(j)=mod(n(i).digits(j),10);
                end
                while carry
                digit=mod(carry,10);
                n(i).digits=[digit n(i).digits];
                carry=carry-digit;
                carry=carry/10;
                end
            end
        end
        function n=mtimes(a,b)
            if isa(a,'BigInt') && ~isa(b,'BigInt')
                n=make_int(a)*b;
            elseif  ~isa(a,'BigInt') && isa(b,'BigInt')
                n=a*make_int(b);
            else
                n=make_int(a)*make_int(b);
            end
            n=BigInt(n);
            
            for i=1:numel(n)
                carry=0;
                for j=numel(n(i).digits):-1:1
                    n(i).digits(j)=n(i).digits(j)+carry;
                    carry=floor(n(i).digits(j)/10);
                    n(i).digits(j)=mod(n(i).digits(j),10);
                end
                while carry
                digit=mod(carry,10);
                n(i).digits=[digit n(i).digits];
                carry=carry-digit;
                carry=carry/10;
                end
            end
        end
        function bool=eq(a,b)
            bool=0;
            if numel(a)==numel(b)
                for i=1:numel(a)
                    if numel(a(i).digits)==numel(b(i).digits)
                        for j=1:numel(a(i).digits)
                            if a(i).digits(j)~=b(i).digits(j)
                                break;
                            end
                            if j==numel(a(numel(a)).digits)
                                bool=1;
                            end
                        end
                    end
                end
            end
            bool=logical(bool);
        end
    end
    
end
