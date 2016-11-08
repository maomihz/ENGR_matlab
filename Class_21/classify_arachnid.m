function answer = classify_arachnid ()
%CLASSIFY_ARACHNID identify type of arachnids
%   CLASSIFY_ARACHNID identifys type of arachnids by asking user questions
%   When it ask enough questions function will return correct answer.
%   Inputs are taken by prompting user. The user need to type "y" or "n".

% By submitting this assignment, I agree to the following:
%  “Aggies do not lie, cheat, or steal, or tolerate those who do”
%  “I have not given or received any unauthorized aid on this assignment”
%
% Name: 		XUCHENG GUO
% Section:      541
% Team:         None
% Assignment:   None
% Date:         8 November 2016


if (input('Has a tail or a stinger? (y or n) ==> ', 's') == 'y') % Question 1
    if (input('Tail is straight like a needle? (y or n) ==> ', 's') == 'y') % Question 2
        answer = 'Uropygi (whipscorpions)';
    else
        answer = 'Scorpiones (scorpiones)';
    end
else
    if (input('Has Claws? (y or n) ==> ', 's') == 'y') % Question 3
        if (input('Is less than 5mm long and is flat? (y or n) ==> ', 's') == 'y') % Question 4
            answer = 'Pseudoscorpiones';
        else
            answer = 'Amblypygi (whipscorpions)';
        end
    else
        if (input('Has thin, stilt-like legs with high knees and a low body? (y or n) ==> ', 's') == 'y') % Question 5
            answer = 'Opiliones (harvestmen)';
        else
            if (input('Body is oval-shaped and lacks a waist? (y or n) ==> ', 's') == 'y') % Question 6
                answer = 'Acari (ticks and mites)';
            else
                if (input('Has 7 segments on each leg and the first pair are not longer than the rest? (y or n) ==> ', 's') == 'y') % Question 7
                    answer = 'Araneae (spiders)';
                else
                    answer = 'Solifugae (windscorpions)';
                end
            end
        end
    end
end
