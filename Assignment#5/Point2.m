%Name:³¯¬M¿² ID:0516233

classdef Point2
    properties
        x=0;
        y=0;
    end
    
    methods
        function obj=Point2(p,q)
            if nargin==0
                obj.x=0;
                obj.y=0;
            elseif nargin==1
                if size(p,1)~=2 || ~ismatrix(p)%It isn't a two-row numeric array
                    error('Input error!');
                end
                obj(1,size(p,2))=Point2; %initialize
                for i=1:size(p,2)
                    obj(1,i).x=p(1,i);
                    obj(1,i).y=p(2,i);
                end
            elseif nargin==2
                if ~isempty(find((size(p)~=size(q))==1,1)) || ~ismatrix(p) || ~ismatrix(q) %They aren't numeric arrays of identical size
                    error('Input error!');
                end
                obj(size(p,1),size(p,2))=Point2; %initialize
                for i=1:numel(p)
                    obj(i).x=p(i);
                    obj(i).y=q(i);
                end
            end
        end
        function v = norm(p)
            v=zeros(size(p)); %initialize
            for i=1:size(p,1)
                for j=1:size(p,2)
                    v(i,j)=sqrt(p(i,j).x^2+p(i,j).y^2);
                end
            end
        end
        function disp(p)
            for i=1:size(p,1)
                for j=1:size(p,2)
                    fprintf('(%g,%g)',p(i,j).x,p(i,j).y);
                    if j~=size(p,2) %Whether it is the last Point2 object
                        fprintf('\t');
                    else
                        fprintf('\n');
                    end
                end
            end
        end
        function v=plus(p,q)
            if isa(p,'Point2') && isa(q,'Point2')
                if ~isempty(find((size(p)~=size(q))==1,1)) %They aren't object arrays of identical size
                    if numel(p)==1 %One input is an object array, and the other input is a scalar object
                        v=q;
                        for i=1:numel(q)
                            v(i).x=p.x+q(i).x;
                            v(i).y=p.y+q(i).y;
                        end
                    elseif numel(q)==1 %One input is an object array, and the other input is a scalar object
                        v=p;
                        for i=1:numel(p)
                            v(i).x=p(i).x+q.x;
                            v(i).y=p(i).y+q.y;
                        end
                    else
                        error('Input error!');
                    end
                else %Both inputs are object arrays of the same dimension
                    v(size(p,1),size(p,2))=Point2;
                    for i=1:numel(q)
                            v(i).x=p(i).x+q(i).x;
                            v(i).y=p(i).y+q(i).y;
                    end
                end
            else
                error('Input error!');
            end
        end
        function v=minus(p,q)
            if isa(p,'Point2') && isa(q,'Point2')
                if ~isempty(find((size(p)~=size(q))==1,1)) %They aren't object arrays of identical size
                    if numel(p)==1 %One input is an object array, and the other input is a scalar object
                        v=q;
                        for i=1:numel(q)
                            v(i).x=p.x-q(i).x;
                            v(i).y=p.y-q(i).y;
                        end
                    elseif numel(q)==1 %One input is an object array, and the other input is a scalar object
                        v=p;
                        for i=1:numel(p)
                            v(i).x=p(i).x-q.x;
                            v(i).y=p(i).y-q.y;
                        end
                    else
                        error('Input error!');
                    end
                else %Both inputs are object arrays of the same dimension
                    v(size(p,1),size(p,2))=Point2;
                    for i=1:numel(q)
                            v(i).x=p(i).x-q(i).x;
                            v(i).y=p(i).y-q(i).y;
                    end
                end
            else
                error('Input error!');
            end
        end
        function bool=eq(p,q) 
            bool=0;
            if isempty(find((size(p)~=size(q))==1,1)) %Both inputs are object arrays of the same dimension
                for i=1:numel(p)
                    if p(i).x~=q(i).x || p(i).y~=q(i).y
                        break;
                    end
                    if i==numel(p)
                        bool=1;
                    end
                end
            else %One input is an object array, and the other input is a scalar object
                if numel(p)==1
                    for i=1:numel(q)
                        if p.x~=q(i).x || p.y~=q(i).y
                            break;
                        end
                        if i==numel(q)
                            bool=1;
                        end
                    end
                elseif numel(q)==1
                    for i=1:numel(p)
                        if p(i).x~=q.x || p(i).y~=q.y
                            break;
                        end
                        if i==numel(p)
                            bool=1;
                        end
                    end                        
                end
            end
            bool=logical(bool);
        end
        function s=sum(p,dim)
            switch dim
                case 1
                    s(1,size(p,2))=Point2; %initialize
                    for i=1:size(p,2)
                        for j=1:size(p,1)
                            s(1,i).x=s(1,i).x+p(j,i).x;
                            s(1,i).y=s(1,i).y+p(j,i).y;
                        end
                    end
                case 2
                    s(size(p,1),1)=Point2; %initialize
                    for i=1:size(p,1)
                        for j=1:size(p,2)
                            s(i,1).x=s(i,1).x+p(i,j).x;
                            s(i,1).y=s(i,1).y+p(i,j).y;
                        end
                    end
                otherwise
                    error('Input error!');
            end
        end
        function m=mean(p,dim)
            switch dim
                case 1
                    num=size(p,1); %the quantity of row(s)
                    m=sum(p,1);
                    for i=1:numel(m)
                        m(i).x=m(i).x/num;
                        m(i).y=m(i).y/num;
                    end
                case 2
                    num=size(p,2); %the quantity of column(s)
                    m=sum(p,2);
                    for i=1:numel(m)
                        m(i).x=m(i).x/num;
                        m(i).y=m(i).y/num;
                    end
                otherwise
                    error('Input error!');
            end
        end
     end
end
