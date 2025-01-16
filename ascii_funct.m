clc
clear
close all
%input the name of the image here
x = imread('uofu.png');
a = size(x,1);
b = size(x,2);
c = size(x,3);
p=0.9;
%resizing for image compression to fit on line
while a > 80
    p = p+.1;
x = imresize(x,(1/p));
a = size(x,1);
b = size(x,2);
end

%greyscale
xg = rgb2gray(x);

%create empty 
xn = zeros(a,b);
xa = string(xn);

%create index of colors
for i = 1:a
    for j = 1:b 
        %2 = white 1 = gray 0 = black
        if xg(i,j) >= 200 
            xn(i,j) = 2;
        elseif xg(i,j) > 100 && xg(i,j) < 200
            xn(i,j) = 1;
        else 
            xn(i,j) = 0;
        end
    end
end
%create potential paths
for i = 1:a
    for j = 1:b 
        %pathing only occurs within frame
        if i < a && j < b && i>1 && j>1
            %horizontal paths
            if xn(i,j) == xn(i,j+1) && xn(i,j) ==0
                    xa(i,j:j+1) = '-'; 
            %vertical paths
            elseif xn(i,j) == xn(i+1,j) && xn(i,j) ==0
                    xa(i,j) = '|';
                    xa(i+1,j) = '|';
            %downward right diagonal
            elseif xn(i,j) == xn(i+1,j+1) && xn(i,j) ==0
                    xa(i,j) = '\\';
                    xa(i+1,j+1) = '\\';          
            % downward left diagonal
            elseif xn(i,j) == xn(i+1, j -1) && xn(i,j) ==0
                xa(i,j) = '/';
                xa(i+1, j-1) = '/';
            %else color white
            else
                xa(i,j) = ' ';
            end
        end
    end
end
%creating empty border
xa(1,1:b) =' ';
xa(a,1:b) = ' ';
xa(1:a,1) = ' ';
xa(1:a,b) = ' ';



%print it i guess
for i = 1:size(xa,1)
    for j = 1:size(xa,2)
        fprintf(xa(i,j));
        if j == b
            fprintf('\n');
        end
    end
end

        
