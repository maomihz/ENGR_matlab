%SING_OLD_MACDONALD sing the "Old MacDonald Had a Farm" song
%   SING_OLD_MACDONALD sings the "Old MacDonald Had a Farm" song with
%   5 different animals.
%
%   The script depends on old_macdonald(animal, sound) to sing.

if exist('old_macdonald','file')
    old_macdonald('dog','woof');
    fprintf('\n');
    old_macdonald('cat','meow');
    fprintf('\n');
    old_macdonald('bird','tweet');
    fprintf('\n');
    old_macdonald('mouse','squeek');
    fprintf('\n');
    old_macdonald('cow','moo');
    fprintf('\n');
else
    fprintf(2, 'Moo-moo! I don''t know how to sing. \n');
    fprintf(2, 'Please teach me by writing function in old_macdonald.m!\n');
end
