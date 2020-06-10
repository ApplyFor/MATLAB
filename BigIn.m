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
            elseif nargin==1 && isscalar(n)
                if(n<0)
                    error('Input error!');
                n=num2str(n);
                n=n-'0';
                obj.digits=n;
            else
                error('Input error!');
            end
        end
        
        function  s=make_str(n)
            tmp=0;
            time=1;
            for i=numel(n.digits):-1:1
                tmp=tmp+n.digits(i)*time;
                time=time*10;
            end
            s=num2str(tmp);
        end
        function disp(n)
            disp(make_str(n));
        end
        function n=plus(a,b)
            n=BigInt;
            if isa(a,'BigInt') && ~isa(b,'BigInt')
                tmp=BigInt(b);
                na=numel(a.digits);
                nb=numel(tmp.digits);
                if na<max(na,nb)
                    for i=1:nb-na
                        a.digits=[0 a.digits];
                    end
                else
                    for i=1:na-nb
                        tmp.digits=[0 tmp.digits];
                    end
                end
                n.digits=a.digits+tmp.digits;
            elseif ~isa(a,'BigInt') && isa(b,'BigInt')
                tmp=BigInt(a);
                na=numel(tmp.digits);
                nb=numel(b.digits);
                if na<max(na,nb)
                    for i=1:nb-na
                        tmp.digits=[0 tmp.digits];
                    end
                else
                    for i=1:na-nb
                        b.digits=[0 b.digits];
                    end
                end
                n.digits=tmp.digits+b.digits;
            else
                na=numel(a.digits);
                nb=numel(b.digits);
                if na<max(na,nb)
                    for i=1:nb-na
                        a.digits=[0 a.digits];
                    end
                else
                    for i=1:na-nb
                        b.digits=[0 b.digits];
                    end
                end
                n.digits=a.digits+b.digits;
            end
            carry=0;
            for i=numel(n.digits):-1:1
                n.digits(i)=n.digits(i)+carry;
                carry=floor(n.digits(i)/10);
                n.digits(i)=mod(n.digits(i),10);
            end
            while carry
                digit=mod(carry,10);
                n.digits=[digit n.digits];
                carry=carry-digit;
                carry=carry/10;
            end
        end
        function n=times(a,b)
            n=BigInt;
            if isa(a,'BigInt') && ~isa(b,'BigInt')
                n.digits=a.digits*b;
            elseif ~isa(a,'BigInt') && isa(b,'BigInt')
                n.digits=a*b.digits;
            else
                n.digits=conv(a.digits,b.digits);
            end
            carry=0;
            for i=numel(n.digits):-1:1
                n.digits(i)=n.digits(i)+carry;
                carry=floor(n.digits(i)/10);
                n.digits(i)=mod(n.digits(i),10);
            end
            while carry
                digit=mod(carry,10);
                n.digits=[digit n.digits];
                carry=carry-digit;
                carry=carry/10;
            end
        end
        function bool=eq(a,b)
            bool=0;
            if numel(a.digits)==numel(b.digits)
                for i=1:numel(a.digits)
                    if a.digits(i)~=b.digits(i)
                        break;
                    end
                    if i==numel(a.digits)
                        bool=1;
                    end
                end
            end
            bool=logical(bool);
        end
    end
    
end
