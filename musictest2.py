import re
import os
import hashlib


def get_freq(tone, octave, sharp=False, flat=False, tuning=440):
    sequence = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    tone = str.upper(tone)
    a = 2 ** (1/12)

    diff = sequence.index(tone) - 9 + len(sequence) * (octave - 4)
    if sharp:
        diff += 1
    if flat:
        diff -= 1

    return tuning * (a ** diff)

def conv_song(song, bpm=60, default_length=4, octave=5, sharps='', flats=''):
    notes = str.split(song)
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

        # print(conf)
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

    return tone_list

def compile_song(tones):
    script = 'beep '
    tones = filter(lambda line: not line.startswith('#'), tones.split('\n'))

    for freq, length, delay in conv_song(' '.join(tones)):
        script += '-f %f -l %f ' % (freq, length)
        if delay:
            script += '-D %f ' % delay
        script += '-n '

    return script[:-3]

def compile_test(tones):
    tones = filter(lambda line: not line.startswith('#'), tones.split('\n'))
    script = ''
    for freq, length, delay in conv_song(' '.join(tones)):
        script += 'play -n synth %f sin %f\n' % (length, freq)
        if delay:
            script += 'sleep %f\n' % (delay / 1000)
    return script
# Wings of Piano
# song = [
#     '[cfg] b=84 ',
#     '|24| e+1 C b a g | a g e a2 g e a | a g e a2 g e a',
#     '|27| a g e a2 g e a | a g e a2 g e d | c2 g g2 g g2',
#     '|30| g2 a g2 a2. | E2 a g2 a2. | . f g a b C a g',
#     '|33| . a g e a2 g e | e a g e a2 g e | . ',
# ]

# Flight of the bumblebee
# song = [
#     'b=160 o=3 l=16',
#     '|1| e+ d+# d+ c+# d+ c+# c+ B | c+ B B~ A G# G F# F | E D# D C# D C# C b',
#     '|4| C b b~ a g# g f# f | e d# d c# d c# c B- | e d# d c# d c# c B-',
#     '|7| e d# d c# c f e d# | e d# d c# c c# d d# | e '
# ]

# tones = conv_song(' '.join(song))
# song = None
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

# if song:
#     os.system(compile_song(song))


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
                script.write(compile_song(' '.join([a.rstrip('\n') for a in text])))
        text.close()
os.system('chmod +x music/*.sh')

# ev3.Sound.tone(tones).wait()
