%LIQUID_VOLUME calculate the liquid volume in a cylinderical tank

while true

    while true
        r = str2double(input('Radius of the sphere ==> ', 's'));
        if isnan(r) || ~isreal(r)
            fprintf('Please Input a Real Number! Try Again! \n');
        elseif r <= 0
            fprintf('Please Input a Positive Number! Try Again! \n')
        else
            break;
        end
    end

    while true
        H = str2double(input('Height of the tank ==> ', 's'));
        if isnan(H) || ~isreal(H)
            fprintf('Please Input a Real Number! Try Again! \n');
        elseif H <= 0
            fprintf('Please Input a Positive Number! Try Again! \n')
        else
            break;
        end
    end

    if H - 2 * r < 0
        fprintf('That''s Not Really A Cylindrical Tank!!! Try Again! \n');
    else
        break;
    end
end

while true
    h = str2double(input('Height of the water (Enter -1 to stop) ==> ', 's'));
    if isnan(h) || ~isreal(h)
        fprintf('Please Input a Real Number! Try Again! \n');
    end

    if h < 0
        fprintf('Bye.\n');
        break;
    elseif h > H
        fprintf('You Want the Water to Overflow?? Try Again!!\n')
        continue;
    end

    % CASE 1: h is less than r
    if h <= r
        volume = 1 / 3 * pi * h ^ 2 * (3 * r - h);

    % CASE 2: h is greater than r but less than H - r
    elseif h <= H - r
        volume = 2 / 3 * pi * r ^ 3 + pi * r ^ 2 * (h - r);

    % CASE 3: h is greater than H - r but less than H
    else
        volume = pi * r ^ 2 * (H - 2 * r) + 4 / 3 * pi * r ^ 3 - 1 / 3 * pi * (H - h) ^ 2 * (3 * r - H + h);
    end

    fprintf('Volume of the liquid: %.2f\n', volume);
end
