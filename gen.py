import re
import os
import hashlib

def get_freq(tone, octave, sharp=False, flat=False, tuning=440):
    ''' Get the frequency of specific tone'''
    sequence = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    tone = str.upper(tone)
    a = 2 ** (1/12)

    diff = sequence.index(tone) - 9 + len(sequence) * (octave - 4)
    if sharp:
        diff += 1
    if flat:
        diff -= 1

    return tuning * (a ** diff)

# Convert the song to an array
def conv_song(song, bpm=60, default_length=4, octave=5, sharps='', flats=''):
    notes = song.split()
    regex = r'([a-gA-G=]|\.)([-+]*)([#!\~]?)([\d\.]+)?'

    conf = {
        'bpm': bpm,
        'octave': octave,
        'length': default_length,
        'sharps': str.upper(sharps),
        'flats': str.upper(flats),
        'shorten': 100,
    }

    tone_list = []

    for i in notes:
        # 1: note (single letter) or .(pause)
        # 2: +- octave indiator
        # 3: #sharp indicator
        # 4: length indicator (can end with . to denote prolong)

        variable_assignment = re.compile(r'([olbs])=(\d+)').match(i)
        if variable_assignment:
            variable = str.lower(variable_assignment.group(1))
            value = int(variable_assignment.group(2))
            if variable == 'o':
                conf['octave'] = value
            elif variable == 'b':
                conf['bpm'] = value
            elif variable == 'l':
                conf['length'] = value
            elif variable == 's':
                conf['shorten'] = value
            # print (variable, value)
            continue

        change_sharps = re.compile(r'\[([a-gA-G]+)\]').match(i)
        if change_sharps:
            conf['sharps'] = str.upper(change_sharps.group(1))
            conf['flats'] = []
            continue

        change_flats = re.compile(r'\[~([a-gA-G]+)\]').match(i)
        if change_flats:
            conf['flats'] = str.upper(change_flats.group(1))
            conf['sharps'] = []
            continue

        note = re.compile(regex).match(i)

        # Must have first group
        if not note or not note.group(1):
            continue

        prolong = False
        octave = conf['octave']
        sharp = False
        flat = False
        delay = 0

        tone = note.group(1)
        if tone.isupper():
            octave += 1
        tone = str.upper(tone)
        if tone in conf['sharps']:
            sharp = True
        elif tone in conf['flats']:
            flat = True

        if note.group(2):
            octave += 2 * note.group(2).count('+')
            octave -= 2 * note.group(2).count('-')

        if note.group(3):
            symbol = note.group(3)
            if symbol == '!':
                sharp = False
                flat = False
            if symbol == '~':
                sharp = False
                flat = True
            if symbol == '#':
                sharp = True
                flat = False

        note_length = conf['length']
        if note.group(4):
            l = note.group(4)
            if note.group(4).endswith('.'):
                prolong = True
                l = l[:-1]
            if l:
                note_length = float(l)
        actual_length = 1 / note_length * 60 / conf['bpm'] * 1000 * 4
        delay = actual_length * (1 - conf['shorten'] / 100)
        actual_length *= conf['shorten'] / 100


        if prolong:
            actual_length *= 1.5
            delay *= 1.5

        if tone == '.':
            if tone_list:
                tone_list[-1][2] += actual_length + delay
        elif tone == '=':
            if tone_list:
                tone_list[-1][1] += actual_length + delay

        else:
            freq = get_freq(tone, octave, sharp, flat)
            tone_list.append([freq, actual_length, delay])

    return [tuple(t) for t in tone_list]

def compile_script(tones):
    script = 'beep '
    tones = filter(lambda line: not line.startswith('#'), tones.split('\n'))

    for freq, length, delay in conv_song(tones):
        script += '-f %f -l %f ' % (freq, length)
        if delay:
            script += '-D %f ' % delay
        script += '-n '

    return script[:-3]

def compile_sox(tones):
    tones = ' '.join(filter(lambda line: not line.startswith('#'), tones.split('\n')))

    script = '>/tmp/song.dat\n'
    for freq, length, delay in conv_song(tones):
        script += 'sox -n -p synth %f tri %f >>/tmp/song.dat\n' % (length / 1000, freq)
        if delay:
            script += 'sox -n -p trim 0.0 %f >>/tmp/song.dat\n' % (delay / 1000)
    script += 'play /tmp/song.dat\n'
    return script
song = None
# Wings of Piano
# song = [
#     '[cfg] b=84 ',
#     '|24| e+1 C b a g | a g e a2 g e a | a g e a2 g e a',
#     '|27| a g e a2 g e a | a g e a2 g e d | c2 g g2 g g2',
#     '|30| g2 a g2 a2. | E2 a g2 a2. | . f g a b C a g',
#     '|33| . a g e a2 g e | e a g e a2 g e | . ',
# ]

# Flight of the bumblebee
# song = '''
# b=160 o=3 l=16
# |1| e+ d+# d+ c+# d+ c+# c+ B | c+ B B~ A G# G F# F | E D# D C# D C# C b
# |4| C b b~ a g# g f# f | e d# d c# d c# c B- | e d# d c# d c# c B-
# |7| e d# d c# c f e d# | e d# d c# c c# d d# | e
# '''

# tones = conv_song(' '.join(song))
# song = '''
# b=138 o=4 [f]
# |1| F8 G8 b8 F8 =8 G. | F8 G8 b8 G8 =8 F a8 | E8 F8 a8 E8 =8 F a8 | D2 C2
# |5| F8 G8 b8 F8 =8 G. | G8 F8 b8 G8 =8 F a8 | E8 F8 a8 E8 =8 F a8 | D2 C#. e
# |9| b b b b8 b8 | b8 a8 g8 g8 = g8 g8 | a8 a. =8 g8 f8 e8 | =2. =8 e8
# |13| b8 b8 b8 b8 = D8 D8 | b8 b. = g8 g8 | a8 b. =8 a8 g8 a8 | g1
# |17| . b8 b D E8 | =8 D b D D8 | =8 D C8 b8 C C8 | =8 b8 b2.
# |21| . a8 b8 a8 g a8 | = a8 b8 a g | = e2. | =1
# |25| . a8 a D D8 | = a8 a E. | E E8 D8 E8 E D8 | E8 F G F.
# |29| F a8 a D D8 | = a8 a E E8 | =1 | =2. d8 e8
# |33| =8 f g8 =2 | =2 .8 E8 F8 G8 | =2 =8 D8 B8 A8 | =2. G8 F8
# |37| E8 E8 E E8 F G8 | =2 =8 E8 F8 G8 | =2 =8 D8 B8 A8
# |40| =2 =8 G8 A8 B8 | =8 B c+8 B A8 G8 | A8 G8 =2.
# |43| D. b. a | =2 g g | D. b. g | =2. g g
# |47| f. d. d | =2. .8 g | C C8 b8 C8 b8 C8 C8 | b8 g8 .8 g8 C8 g8 C8 b8
# |51| =2. g | a2 a8 g8 f8 g8 | =8 b8 b8 b8 b8 b b8 | = g2 g
# |55| D D8 C8 =8 b. | a2. g8 g8 | b b8 b D E8 | = D2 D
# |59| G G8 F8 =8 E E8 | = a C# E | D a8 a D D8 | =8 a a D E8 | = D8 E8 =8 D E8
# |64| =8 F G. A | D a8 a D D8 | =8 a D a8 E | =2 =8 F G8
# |68| =1 | =2 .8 E8 F8 G8 | =2 =8 D8 D8 A8 | =2 .8 G8 E8 E8
# |72| =8 E8 E8 E F G8 | =8 A8 G .8 E8 F8 G8 | =2 =8 D8 B8 A8 | =2. G8 B8
# |76| =8 B8 c+8. B8 A8 | A8 G. =2 | D. b. a | =2. g | D. b. g
# |81| =2. g8 g8 | f. d. d | = f! b~ D | [] l=8 C F G F B~ A G F | D# F G E F G a# b
# |86| C F G F B~ A G F | D# F G E F G a# b l=4 | C C8 b C D~8 | =8 E F G B~8
# |90| B8 A8 G F G8 | =1 | . C8 b C D8 | =8 E F G B~8 | =8 A G F B~8
# |95| B8 A8 G8 A8 G2 | . D C# D E8 | =8 F# G A c+~8 | =8 B A G A8
# |99| =1 | [f] . b8 b b b8 | = g8 g8 =. g8 | a g8 a b C8 | =1
# |104| =2 .8 C8 C8 C8 | b2 .8 d8 d8 a8 | =2 =8 g8 e8 e8 | =8 e8 e8 e8 e8 f g8
# |108| =8 a8 G .8 e8 f8 g8 | =2 =8 d8 b8 b8 | a2. g8 b8 | b8 b C8 b a8 g8 | a8 g. =2
# |113| D. b. a | =2 g g | D. b. C8 b8 | =8 a8 g2. | =2. g8 g8 | f. g. D
# |119| =1 | =2. .8 g8 | C C8 b8 C8 b8 C8 C8 | b8 g. =2 | =1
# '''

# song = '''
# o=4 b=60 [f]
# C32 D32 E8. c+8 B8 E | D8 G8 C32 b32 a g8 f b8 b16 | C8 D16 E8.
# '''

# song = '''
# o=4 b=130 [cfg] l=8
# # |1| A-8 e e e e8 | c8 g g g g8 | d8 a a a a8 | e8 b b b. | . a8 a8 a8 e8 g8 a8
# # |6| . a8 a8 a8 e8 b8 a8 | . a8 a8 a8 e8 a8 b8 | = E8 D C a | . C8 C8 C8 a8 b8 E8 | . E8 E8 E8 g8 a8 b8
# # |11| . a8 a8 a8 e8 b8 C8 | D C8 b E8 D8 C8 | l=8 .4 A A A G E D | . A A A A G E E
# # |15| . A A A A G E A | = G A B d+ c+ B A | . A G A E A G16 A16 E | . A G A E A G16 A16 e+
# # |19| b F B F c+ F A F | . b E G A B c+ d+ | . A A A16 A16 = G E A | . G G A16 e+16 = d+ c+ B
# # |23| . A G A16 E16 = G A B | d+4 c+4 B4 A4 | . A A A16 A16 = G E A | . G G A16 e+16 = d+ c+ B
# # |27| . A G A16 B16 = d+ c+ A | l=4 A-8 e e e8 a8 e8 | c8 g g g8 E8 C8 | d8 a a a8 E8 a8 | e8 b A8 G2
# # |32| l=8 .4 a a a e g a | .4 a a a e b a | .4 a a a e a b | =4 E D4 C4 a | .4 C C C a b E
# # |37| .4 E E E g a b | .4 a a a e b C | D4 C b4 E D C | .4 A A A G E D | .4 A A A G E E
# # |42| .4 A A A G E A | = G A B d+ c+ B c+ | E16 E16 A G A16 E16 =16 E16 A G A
# # |45| E16 E16 A G A16 e+16 =16 e+16 A G A | l=16 e a b E A B e+ B A E b a e a b E
# # |47| c! c e# g C! C E G c! e! g! b~ C! E! G! B~ l=8 | [~abde] .8 A A A16 A16 = G E A
# # |49| .8 G G A16 e+16 = d+ c+ B | .8 A G A16 E16 = G A B | l=16 d+ E A d+ c+ E A c+ B E G B A C E A l=8
# # |52| l=8 .8 A A A16 A16 = G E A | .8 G G A16 e+16 = d+ c+ B | .8 A G A16 B16 = d+ c+ A
# # |55| l=8 B! e f# a b2 | [cfg] .8 A G A16 E16 = A G A16 E | o=5 .8 A G A16 E16 = A G A16 E o=4
# # |58| .8 A G A16 E16 = A G A16 E | o=5 .8 A G A16 E16 = c+ B c+ o=4 | [be] . B A B16 F16 = B A B
# # |61| . B A B16 f+16 = e+ d+ c+ | .8 B A B16 F16 = B c+ B | e+4 d+4 c+4 B4
# '''
song = '''
o=4 b=145 [f]
B8. A8 G16. E16. D16. E16. G16. E8 D16. | b16. a16. b8 e8 a e D16 | [e] =2 .8 A8 G8 A8
[e] D A8 G. A8 c+8 | = A8 G. A8 D8 | =1
|7| .2 .8 A8 G8 A8 | D A8 G. A8 c+8 | = A8 G. C8 D8
|10| =1 | =2. . | [f] .8 B- c g f8
|13| =8 g a8 g8 f g8 | =8 e2 .8 . | .1 |
|16| .8 B- c g f8 | =8 g a8 g8 f g8 | =. B16 d+16 e+8 d+8 B8 A8
|19| B8 A8 G8 F8 [e] .8 A8 G8 A8 | D A8 G. A8 c+8 | c+ A8 G. A8 D8
|22| =8 F E C D8 | D8 a C g a8 | =2. .8 d8
|25| =. f e C8 | =2. a | b D E F
|28| F a g a8 d8 | =8 a g a C8 | = a g a
|31| d
'''

if song:
    os.system(compile_sox(song))
else:
    folder = 'music'
    files = os.listdir(folder)

    for f in files:
        (shortname, ext) = os.path.splitext(f)
        if ext == '.txt':
            text = open(os.path.join(folder, f), 'r')
            hash = hashlib.md5(text.read().encode('utf-8')).hexdigest()

            need_write = False
            if not os.path.exists(os.path.join(folder, shortname + '.sh')):
                need_write = True
            else:
                with open(os.path.join(folder, shortname + '.sh'), 'r') as script:
                    script.readline()
                    scripthash = script.readline().rstrip('\n')
                    if scripthash != '#'+hash:
                        need_write = True

            if need_write:
                print('b'+f)
                with open(os.path.join(folder, shortname + '.sh'), 'w') as script:
                    text.seek(0)
                    script.write('#!/usr/bin/env bash\n')
                    script.write('#'+hash+'\n')
                    script.write(compile_sox(text.read()))
            text.close()
    os.system('chmod +x music/*.sh')
