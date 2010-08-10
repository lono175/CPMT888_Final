function newImg = DrawTransColor(img, range, color)
    newImg = img;
    for y = range(1):range(2)
        for x = range(3):range(4)
            oriColor = reshape(newImg(y, x, :), [1 3])
            newImg(y, x, :) = 0.5*oriColor + 0.5*color;
        end
    end
end
