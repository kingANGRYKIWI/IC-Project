function [x,y] = ReadPowerData(filename)
%-- 4/28/2025 10:47 AM --%
t= readmatrix(filename);


x=t(:,1);
y=t(:,3)-t(:,2);
%plot(x,y)
end