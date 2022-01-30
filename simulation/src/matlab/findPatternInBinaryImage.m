function locations = findPatternInBinaryImage(A_file, B_file)
    if isstring(A_file)
        A = load(A_file).map;
    else
        A = A_file;
    end

    if isstring(A_file)
        B = load(B_file).chargingStationBinaryTemplate;
    else
        B = B_file;
    end
    
    A = double(A); B = double(B);

    szA = size(A);
    szB = size(B);
    szS = szA - szB + 1;
    tfx = zeros(szS);

    for r = 1:szS(1)
        for c = 1:szS(2)
            tfx(r,c) = sum(sum((A(r:r+szB(1)-1,c:c+szB(2)-1) - B).^2));
        end
    end
   tfx = tfx < 100;

    loc = find(tfx==1);

    locations = zeros(length(loc),2);
    nx = 1;
    for n = 1:length(loc)
        asd = loc(n);
        a = idivide(int32(asd), int32(szS(1)));
        b = asd - a*szS(1);
        p = [a+szB(1)/2 szA(2)-b-szB(2)/2];

        dupl = false;
        for nn = 1:length(locations(:,1))
            d = double(p) - double(locations(nn,:));
            if norm(d) < 3.0
                dupl = true;
                break;
            end
        end

        if dupl == false
            locations(nx,:) = p;
            nx = nx +1;
        end
    end
    
    locations(nx:end, :) = [];
    figure;
    disp('plotting')
    colormap('hot');
    imagesc(tfx);
    colorbar

end

