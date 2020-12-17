function [abscisses_discretises] = get_abs_disc(subdi, seg_sub)
    S = size(seg_sub);
    abscisses_discretises = round(seg_sub(2,1)):(round(seg_sub(S(1),1))-round(seg_sub(2,1)))/(subdi):round(seg_sub(S(1),1))-(round(seg_sub(S(1),1))-round(seg_sub(2,1)))/(subdi);

end
