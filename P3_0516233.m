% Name:³¯¬M¿² ID:0516233
function [CC,imL]=P3_0516233(im)
im=imread('prog3.bmp');
%an array of zeros of the same size as im
imL=zeros(size(im));
nCC=0;
Q=[];
for p=1:numel(im)
    if(im(p)>0 && imL(p)==0)
        nCC=nCC+1;
        %initialize a queue Q with p 
        Q=[Q p];
        while(~isempty(Q))
            q=Q(end);
            Q(end)=[];
            if(im(q)>0 && imL(q)==0)
                imL(q)=nCC;
                [row column]=size(imL);
                %push the left pixel of q into Q
                if(q<row)
                    Q=[Q q+numel(imL)-row];
                else
                    Q=[Q q-row];
                end
                %push the right pixel of q into Q
                if(q>numel(imL)-row)
                    Q=[Q q-numel(imL)+row];
                else
                    Q=[Q q+row];
                end
                 %push the above pixel of q into Q
                 if(mod(q,row)==1)
                     Q=[Q q+row-1];
                 else
                     Q=[Q q-1];
                 end
                 %push the below pixel of q into Q
                 if(mod(q,row)==0)
                     Q=[Q q-row+1];
                 else
                     Q=[Q q+1];
                 end
            end
        end
    end
end

for i=1:nCC
    CC(i).count=numel(find(imL==i));
    CC(i).index=find(imL==i);
    CC(i).xmin=size(imL,2);CC(i).xmax=0;CC(i).ymin=size(imL,1);CC(i).ymax=0;
    for n=1:CC(i).count
        row=mod(CC(i).index(n),size(imL,1));
        column=floor(CC(i).index(n)/size(imL,1))+1;
        if(column<CC(i).xmin)
            CC(i).xmin=column;
        end
        if(column>CC(i).xmax)
            CC(i).xmax=column;
        end
        if(row<CC(i).ymin)
            CC(i).ymin=row;
        end
        if(row>CC(i).ymax)
            CC(i).ymax=row;
        end        
    end
%display a color image such that each component is shown in a different color
imagesc(imL);
end
    