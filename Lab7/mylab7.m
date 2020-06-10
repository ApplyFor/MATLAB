function [word, count] = mylab7(fn)
fid=fopen(fn,'rt');

str=fgetl(fid);
while(~feof(fid))
    tmp=fgetl(fid);
    str=[str tmp];
    str=strrep(str,',',' ');
    str=strrep(str,'.',' ');
end
str=lower(str);
data = strsplit(str);

word={};
n=0;
count=[];
for i=1:length(data)-1
    time=strcmp(word, data{i});
    time=sum(time(:)==1);
    if time==0
        n=n+1;
        word{n}=data{i};
        time=strcmp(data{i}, data);
        time=sum(time(:)==1);
        count=[count time];
    end
end

if nargout==0
    for i=1:n
        fprintf('%s', word{i});
        [~, len]=size(word{i});
        space=13-len;
        for j=1:space
            fprintf(' ');
        end
        fprintf('%d\n', count(i));
    end
else
end

fclose(fid);
end

