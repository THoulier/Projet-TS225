function [p1_new,p2_new] = swap(p1,p2)
    p1_new = p1;
    p2_new = p2;
    
    if (p1(1,1) > p2(1,1))
       p2_new = p1;
       p1_new = p2;
    end

end