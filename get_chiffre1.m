function [chiffre1] = get_chiffre1(list_classes)

BDD_chiffre1 = ["A" "A" "A" "A" "A" "A"; "A" "A" "B" "A" "B" "B"; "A" "A" "B" "B" "A" "B"; "A" "A" "B" "B" "B" "A"; "A" "B" "A" "A" "B" "B"; "A" "B" "B" "A" "A" "B"; "A" "B" "B" "B" "A" "A"; "A" "B" "A" "B" "A" "B"; "A" "B" "A" "B" "B" "A"; "A" "B" "B" "A" "B" "A"];
chiffre1 = -1;
for i = 0:9
    if (list_classes == BDD_chiffre1(i+1,:))
        chiffre1 = i;
    end
end

end