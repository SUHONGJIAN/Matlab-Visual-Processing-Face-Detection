cd '...'
for i=1:3
    switch(i)
        case 1
            s = 'image_0011.jpg';
        case 2
            s = 'image_0031.jpg';
        case 3
            s = 'image_0061.jpg';
    end
    I=imread(s);
    I1=rgb2hsv(I);
    h=I1(:,:,1);
    s=I1(:,:,2);
    v=I1(:,:,3);
    id1 = s > 0.23 & s < 0.68 & h > 0 & h < 50;
    id2 = h>2/360 & h<30/360 & s>9/100 & s<62/100 & v>43/100 &v <99/100;
    
    se1 = strel('disk',8);
    se2 = strel('disk',30);
    f1 = imopen(id2,se1);
    f2 = imclose(f1,se2);
    [L,num]=bwlabel(f2);
    STATS = regionprops(L,'BoundingBox');
    
    figure,
    subplot(3,2,1),imshow(I),title('ԭͼ��');
    subplot(3,2,2),imshow(id1);title('hsv����ԭ������룩');
    subplot(3,2,3),imshow(id2);title('hsv�������Ƴ�����룩');
    subplot(3,2,4),imshow(f1);title('��ѧ��̬���������㣩');
    subplot(3,2,5),imshow(f2);title('��ѧ��̬���������㣩');
    subplot(3,2,6),imshow(I);title('ԭͼ���ɫ���');
    rectangle('Position',STATS(1).BoundingBox,'EdgeColor','r');
end