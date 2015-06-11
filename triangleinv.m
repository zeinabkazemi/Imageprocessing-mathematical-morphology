function [ x ] = triangleinv( in )
%TRIANGLE Summary of this function goes here
%   Detailed explanation goes here
p(1:128)=(0:127)/(128*128);
p(129:256)=(-(128:255)+255)/(128*128);

temp = 0;
x = 255;
for i=1:256
    temp=temp+p(i);
    if(temp> in)
        x=i-1;
        break;
    end
end
end

