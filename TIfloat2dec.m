%% 4字节十六进制TI浮点数转换十进制
clear all;
close all;
clc;
%% 十六进制字符转化为二进制(031D86C5—>9.845403,F80B0570->0.004243,80000000->0)
% 二进制共32位：31-24位为指数位e，23位为符号位s，22-0位为分数区f
% 转换公式：0<e<128 x=((-2)^s + f)*2^e
%          128<e<256 x=((-2)^s + f)*2^(e-256)
% s,e为十进制数字，f为二进制所转化而得的纯小数

n='031D86C5';
n10=hex2dec(n); %十六进制转十进制
n20=dec2bin(n10); %十进制转二进制，是否可以显示成32位的二进制？
len=length(n20);
%补齐前面未显示的0
if len==32
    n2=n20;
else
    free=32-len;
    n2(free+1:32)=n20(1:len);
    n2(1:free)='0';
end
a=n2(1:8);
b=n2(9);
n2(1)=b;
n2(2:9)=a;
str=dec2hex(bin2dec(n2))
% typecast(uint32(hex2dec(str)),'single');

% %指数区
% ee=n2(1:8); e=bin2dec(ee); 
% %符号区
% s=str2num(n2(9)); 
% %分数区
% ff=n2(10:32); f=bin2dec(ff)/2^23; 
% %套用公式化为十进制
% if e<128
%     x=vpa(((-2)^s + f)*2^e);
% elseif e > 128
%     x=vpa(((-2)^s + f)*2^(e-256));
% else
%     x=0;
% end
% x