function [ElementType] = BDD_ElementType(type)
    ElementA = [1 1 1 0 0 1 0 ; 1 1 0 0 1 1 0 ; 1 1 0 1 1 0 0 ; 1 0 0 0 0 1 0 ; 1 0 1 1 1 0 0 ; 1 0 0 1 1 1 0 ; 1 0 1 0 0 0 0 ; 1 0 0 0 1 0 0 ; 1 0 0 1 0 0 0 ; 1 1 1 0 1 0 0];
    ElementB = [1 0 1 1 0 0 0 ; 1 0 0 1 1 0 0 ; 1 1 0 0 1 0 0 ; 1 0 1 1 1 1 0 ; 1 1 0 0 0 1 0 ; 1 0 0 0 1 1 0 ; 1 1 1 1 0 1 0 ; 1 1 0 1 1 1 0 ; 1 1 1 0 1 1 0 ; 1 1 0 1 0 0 0];
    ElementC = [0 0 0 1 1 0 1 ; 0 0 1 1 0 0 1 ; 0 0 1 0 0 1 1 ; 0 1 1 1 1 0 1 ; 0 1 0 0 0 1 1 ; 0 1 1 0 0 0 1 ; 0 1 0 1 1 1 1 ; 0 1 1 1 0 1 1 ; 0 1 1 0 1 1 1 ; 0 0 0 1 0 1 1];
    
    if (1 == strcmp(type,"A"))
        ElementType = ElementA;
    elseif (1 == strcmp(type,"B"))
        ElementType = ElementB;
    else
        ElementType = ElementC;
    end
    
end