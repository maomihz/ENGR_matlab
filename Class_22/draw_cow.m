function [ ] = draw_cow(picture)
%DRAW_COW draw a cow
%   DRAW_COW() draws a cow, and it will only draw a cow no matter what.
%   The function takes no arguments and produce no outputs.
%   It only draws a cow, nothing special, really.

    % check to draw a dragon
    if (strcmp(picture, 'dragon'))
        fprintf('      \\                    / \\  //\\\n');
        fprintf('       \\    |\\___/|      /   \\//  \\\\\n');
        fprintf('            /0  0  \\__  /    //  | \\ \\  \n');
        fprintf('           /     /  \\/_/    //   |  \\  \\  \n');
        fprintf('           @_^_@''/   \\/_   //    |   \\   \\ \n');
        fprintf('           //_^_/     \\/_ //     |    \\    \\\n');
        fprintf('        ( //) |        \\///      |     \\     \\\n');
        fprintf('      ( / /) _|_ /   )  //       |      \\     _\\\n');
        fprintf('    ( // /) ''/,_ _ _/  ( ; -.    |    _ _\\.-~        .-~~~^-.\n');
        fprintf('  (( / / )) ,-{        _      `-.|.-~-.           .~         `.\n');
        fprintf(' (( // / ))  ''/\\      /                 ~-. _ .-~      .-~^-.  \\\n');
        fprintf(' (( /// ))      `.   {            }                   /      \\  \\\n');
        fprintf('  (( / ))     .----~-.\\        \\-''                 .~         \\  `. \\^-.\n');
        fprintf('             ///.----..>        \\             _ -~             `.  ^-`  ^-_\n');
        fprintf('               ///-._ _ _ _ _ _ _}^ - - - - ~                     ~-- ,.-~\n');
        fprintf('                                                                  /.-~\n');

    else % Draw a cow by default
        fprintf('        \\   ^__^             \n');
        fprintf('         \\  (oo)\\_______     \n');
        fprintf('            (__)\\       )\\/\\ \n');
        fprintf('                ||----w |    \n');
        fprintf('                ||     ||    \n');
    end
end
