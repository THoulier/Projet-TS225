function [img_gray] = get_img_gray(img)
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);

    img_gray = (R+G+B)/3;
end