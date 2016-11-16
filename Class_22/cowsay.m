function [ ] = cowsay(inputText, maxWidth, picture)
%COWSAY the matlab implementation of the original unix COWSAY
%   You can call cowsay in three different forms:
%       cowsay(inputText) - assume maxWidth is 40
%       cowsay(inputText, maxWidth) - assume picture is "cow"
%       cowsay(inputText, maxWidth, picture) - full argument calling
%
%   COWSAY(inputText, maxWidth, picture) generates an ASCII picture of a cow
%   saying something provided by the user. It accept one argument and two
%   optional arguments:
%       inputText - The text to make the cow saying
%       maxWidth - (optional) the maximum text column to display
%       picture - (optional) the picture to display instead of cow
%
%   Currently the program can only print "cow" or "dragon" as its picture.
%
%   This script depends on draw_text_balloon and draw_cow. Printing of pictures
%   are handled in draw_cow(picture).

    % Default arguments
    if (nargin < 2)
        maxWidth = 40; % maxWidth defaults to 40
    end
    if (nargin < 3)
        picture = 'cow'; % picture defaults to cow
    end

    if (ischar(inputText) && ischar(picture))
        draw_text_balloon(inputText, maxWidth);
        draw_cow(picture);
    else
        fprintf(2, 'Input arguments should be strings. Aborting. \n');
    end

end
