function [signature_binaire] = binarisation(signature, seuil)
    signature_binaire(signature > seuil) = 1;
    signature_binaire(signature <= seuil) = 0;
end