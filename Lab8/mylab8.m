function A = mylab8(fn,sort_mode)
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

n=0;
word={};
len={};
count={};
for i=1:length(data)-1
    time=strcmp(word, data{i});
    time=sum(time(:)==1);
    if time==0
        n=n+1;
        word{n}=data{i};
        time=strcmp(data{i}, data);
        time=sum(time(:)==1);
		len{n}=length(data{i});
        count{n}=time;
    end
end

A=struct('word',word,'len',len,'count',count);

switch sort_mode
case 'word'
	[~, k] = sort({A.word});
	A = A(k);
case 'length'
	[~, k] = sort([A.len]);
	A = A(k);
case 'count'
	[~, k] = sort([A.count]);
	A = A(k);
otherwise
end
fclose(fid);
end

