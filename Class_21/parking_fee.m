function totalFee = parking_fee( parkingHours )
%PARKING_FEE compute the total parking fee after parking_fee
%   PARKING_FEE(parkingHours) computes the total parking fee after parking,
%   given the total parking hour.
%
%   Input is taken by variable parkingHours as an floating point number,
%   the total parking hours.

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   None
% Date:         8 November 2016

    ceilParkingHours = ceil(parkingHours); % Round up the number
    fullDays = floor(ceilParkingHours / 24); % Full 24 hour day

    % if ticket is not lost
    if (parkingHours >= 0)
        % Parking hours for the last day
        lastDayHours = mod(ceilParkingHours, 24);

        % Last day hour, from 0 to 2
        hours0to2 = min(lastDayHours, 2);
        lastDayHours = lastDayHours - hours0to2;

        % Last day hour, from 2 to 4
        hours2to4 = min(lastDayHours, 2);
        lastDayHours = lastDayHours - hours2to4;

        % Last day hour, >4
        additionalHours = lastDayHours;

        % Computing for the last day first
        totalFee = 0;
        if (hours0to2 > 0)
            totalFee = totalFee + 4;
        end
        if (hours2to4 > 0)
            totalFee = totalFee + 3;
        end
        totalFee = totalFee + additionalHours * 1;

        % Adjust for maximum charge
        if totalFee > 24
            totalFee = 24;
        end

        % Add all full day charges
        totalFee = totalFee + fullDays * 24;
    else
        totalFee = 36; % lost ticket charge
    end
end
