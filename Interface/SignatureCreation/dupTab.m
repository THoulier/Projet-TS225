function [ElementDup] = dupTab(Element,u)

ElementDup = [];
for i = 1:length(Element)
    Element_dup = [];
    for j = 1:7
        for k = 1:u
            Element_dup = [Element_dup Element(i,j)];
        end
    end
    ElementDup = [ElementDup ; Element_dup];
end