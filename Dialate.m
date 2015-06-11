function [ J ] = Dialate( I,b)
%ERODE Summary of this function goes here
%   Detailed explanation goes here

J=zeros(size(I));
Iindex = 1;
Jindex = 1;
for i=1:size(I,1)
    for j=1:size(I,2)
        temp = false;
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
                
                temp = temp || I(Iindex,Jindex);
            end
        end
        J(i,j) = temp;
    end
end

end

