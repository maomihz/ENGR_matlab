function [ ] = old_macdonald (animal, sound)
%OLD_MACDONALD sing the "Old MacDonald Had a Farm" song
%   OLD_MACDONALD(animal,sound) sings "Old MacDonald Had a Farm" song when
%   the name of animal and its sound is given. Name of animal and sound are
%   stored in variable animal, sound as string.

    fprintf('Old MacDonald had a farm, E-I-E-I-O!\n');
    fprintf('And on that farm he had a %s, E-I-E-I-O!\n', animal);
    fprintf('With a %1$s-%1$s here, and %1$s-%1$s there.\n', sound);
    fprintf('Here a %1$s, there a %1$s, everywhere a %1$s-%1$s.\n', sound)
    fprintf('Old Macdonald had a farm, E-I-E-I-O!\n');
end
