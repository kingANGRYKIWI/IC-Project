function [x,y_r, y_d] = ReadTimeData(filename)
%-- 4/28/2025 10:47 AM --%
t= readmatrix(filename);


x=t(:,1);

y_r=t(:,2);
y_d=t(:,3);
%plot(x,y)
end