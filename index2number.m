function [new_segment, list_classes] = index2number(segment)
    for i = 1:length(segment)
        if (segment(i) > 9 && segment(i) < 20)
            new_segment(1,i) = segment(i) - 10;
            list_classes(i) = "B";
        elseif (segment(i) > 19 && segment(i) < 30)
            new_segment(1,i) = segment(i) - 20;
            list_classes(i) = "C";
        else
            new_segment(1,i) = segment(i);
            list_classes(i) = "A";
    end

end