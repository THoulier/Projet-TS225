function [min, idx] = get_number(table_ref, segment_compared)
    min = norm(table_ref(1,:)-segment_compared);
    idx = 1;
    
    for i = 2 : size(table_ref,1)
        res = norm(table_ref(i,:)-segment_compared);
        if (res < min)
            min = res;
            idx = i;
        end
    end
end
