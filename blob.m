function [ J ,report,count] = blob( I,b )
%BLOB Summary of this function goes here
%   Detailed explanation goes here

J=zeros(size(I));
Iindex = 1;
Jindex = 1;
count=0;
region = {};
for i=1:size(I,1)
    for j=1:size(I,2)
        temp=0;
        if(I(i,j) == 1 )
        for k=-floor(b/2):floor(b/2)
            for l=-floor(b/2):floor(b/2)
                if(i+k < 1)
                     Iindex = 1;
                elseif(i+k > size(I,1))
                     Iindex = size(I,1);
                else
                    Iindex = i+k;
                end
                if(j+l < 1)
                    Jindex = 1;
                elseif(j+l > size(I,2))
                    Jindex = size(I,2);
                else
                     Jindex = j+l;
                end
                if(temp == 0 && J(Iindex,Jindex)>0)
                    temp = J(Iindex,Jindex);
                elseif(J(Iindex,Jindex)>0 && J(Iindex,Jindex)~= temp)                 
                   for q=1:size(region,2)
                        if(~isempty(find(region{q}==temp, 1)))
                            aa = q;
                            break;
                        end
                    end
                    
                    for q=1:size(region,2)
                        if(~isempty(find(region{q}==J(Iindex,Jindex),1)))
                            bb = q;
                            break;
                        end
                    end 
                    if(aa~=bb)
                        region{aa} = union(region{aa},region{bb});
                        region{bb} = [];
                    end
                end
            end
        end
        if(temp > 0)
            J(i,j) = temp;
        else
            count = count + 1;
            region{end + 1} = count;
            J(i,j)=count;
        end
        end
    end
end



for i=1:size(I,1)
    for j=1:size(I,2)
        if(J(i,j)>0)
            for q=1:size(region,2)
                if(~isempty(find(region{q}==J(i,j), 1)))
                    J(i,j) = q;
                    break;
                end
            end
        end
    end
end


regions = unique(J);
regions = regions(2:end);
if(isempty(regions))
    report = [];
    count = 0;
    return;
end
XYS = zeros(size(regions,1),5);
report=zeros(size(regions,1),4);
for reg=1:size(regions,1)
    for i=1:size(I,1)
        for j=1:size(I,2)
            if(J(i,j) == regions(reg) )
                XYS(reg,1) = XYS(reg,1) + i;
                XYS(reg,2) = XYS(reg,2) + j;
                XYS(reg,3) = XYS(reg,3) + 1;
            end
        end
    end
    XYS(reg,4) = floor(XYS(reg,1) / XYS(reg,3));
    XYS(reg,5) = floor(XYS(reg,2) / XYS(reg,3));
    if( XYS(reg,3)>15)
        report(reg,1)=reg;
        report(reg,2)=XYS(reg,3);
        report(reg,3)=XYS(reg,4);
        report(reg,4)=XYS(reg,5);
    end
end



for reg=1:size(regions,1)
    J (XYS(reg,4),XYS(reg,5)) = regions(end) + 10;
end

report=report(report(:,2)>15,:);
count = nnz((XYS(:,3) > 15));

end

