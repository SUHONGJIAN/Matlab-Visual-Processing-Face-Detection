cd '...'
for i =1:3
    switch(i)
        case 1
            s = 'img_1.jpg';
        case 2
            s = 'img_75.jpg';
        case 3
            s = 'img_587.jpg';
    end
    I=imread(s);
    Y=imread(s);
    I=imresize(I,0.1);
    I1=rgb2ycbcr(I);
    I1=double(I1); 
    cb=I1(:,:,2);
    cr=I1(:,:,3);
    mu=[117.44 157.56]';
    sig=[299.46 12.14;12.14 160.13];
    p=drawGaussian(mu,sig,cb(:),cr(:));
    p=reshape(p,size(cb));
    p1 = p > 0.7;
    p2=imresize(p1,10);
    
    se1 = strel('disk',15);
    f1 = imclose(p2,se1);
    [L,num]=bwlabel(f1);
    STATS = regionprops(L,'BoundingBox');
    
    figure,
    subplot(3,2,1),imshow(I),title('��С10�����ԭͼ��');
    subplot(3,2,2),imshow(p),title('YCbCr����(����)');
    subplot(3,2,3),imshow(p1);title('��һ����ֵ����');
    subplot(3,2,4),imshow(p2);title('�Ŵ�10����Ĵ���ͼ��')
    subplot(3,2,5),imshow(f1);title('��ѧ��̬���������㣩');
    subplot(3,2,6),imshow(Y);title('ԭͼ���ɫ���');
    for j = 1:num
       rectangle('Position',STATS(j).BoundingBox,'EdgeColor','r'); 
    end
end
