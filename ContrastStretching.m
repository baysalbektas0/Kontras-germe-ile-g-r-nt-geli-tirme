clc ; close all ; clear all;
I=double(rgb2gray(imread('Adsýz.tif')));
makalesonuc=(rgb2gray(imread('sonuc.png')));


[w,h]=size(I);
y=[];rangeofimage=[];I2=[];
a = max(I(:)); b = min(I(:));
AL= mean2(I); SR=0.5 ; adpconstract=[];% germe oraný
for i=1:1:w
    for j=1:1:h
        if (I(i,j) >= b) && (I(i,j)<= AL)
            adpconstract(i,j) = (SR/(AL-b))*(I(i,j)-b);
        else (I(i,j)> AL) && (I(i,j)<= a)
            adpconstract(i,j)= SR+(((1-SR)/(a-AL))*(I(i,j)-AL));
        end
        
        rangeofimage(i,j)=3*(adpconstract(i,j)^2)-2*(adpconstract(i,j)^3);
    end
end

for i=1:1:w
    for j=1:1:h
        if (I(i,j)>=b)&&(I(i,j)<=a)
            I2(i,j)= rangeofimage(i,j);
        else  I(i,j)>=a
            I2(i,j)=1;
        end
    end
end
c=max(I2(:)); d=min(I2(:)); [w1,h1]=size(I2);
for i=1:1:w1
    for j=1:1:h-7
        I2(i,j)=d+(c-d)*I2(i,j);
    end
end
figure;imshow(uint8(I)); title('orjinal imge');
figure;imshow(uint8(I2*255));title('uygulanan yöntem sonucu');
figure;imshow(makalesonuc); title('makale sonucu');
figure;subplot(2,2,1);imshow(uint8(I2*255));title('uygulanan yöntem sonucu');subplot(2,2,2); imhist(uint8(I2*255));...
    subplot(2,2,3);imshow(makalesonuc);title('makale sonucu');subplot(2,2,4); imhist(makalesonuc);