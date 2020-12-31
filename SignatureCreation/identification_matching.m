function [tab_idx] = identification_matching(u, segment_total, Elements_dup)
    tab_norm = [];
    tab_idx = [];

    for i = 1:7*u:length(segment_total)
        [norm, idx] = get_number(Elements_dup,segment_total(i:i+7*u-1));
        tab_idx = [tab_idx idx];
        tab_norm = [tab_norm norm];
    end
end