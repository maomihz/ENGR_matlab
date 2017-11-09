import re
import random

songs = [
    ('D2 G2 G1 A1 G1 F#1 E2 E2 E2 A2 A1 B1 A1 G1 F#2 D2 D2 B2 B1 c1 B1 A1 G1 E2 D1 D1 E2 A2 F#2 G4', 4), # Marry Chistmas
    ('e2 e2 .1 e2 .1 c2 e4 g4 .2 G4 .2 C6 G2 .2 E6 A4 .2 B4 A#2 A4 G4 .1 e4 g4 a4 f2 g2 .1 e4 c2 d2 B6', 10), # Super Mario
    ('d#2 f#4 d#2 B1 G#2 A#2 B1 c2 c#2 f4 c#2 A#2 F#2 G#1 A2 A#1 B2 d#3 B2 G#3 F1 F#2 G#2 A2 A#2 A1 A#2 B2 c#3 .1 c#3 c2 c#1 .1 d#2 f#4 d#2 B1 .1 G#1 A#2 B1 c2 c#2 f4 c#2 A#2 F#2 G#1 A2 A#1 B2 d#3 B2 G#3 F2 G#2 c#2 B1 A#5', 7), # Take five
    ('C4 G4 F1 E1 D1 c4 G2 F1 E1 D1 c4 G2 A#1 A1 A#1 G6 C4 G4 F1 E1 D1 c4 G2 F1 E1 D1 c4 G2 A#1 A1 A#1 G4', 6), # Star wars
    ('E2 F#2 B6 A2 c#4 F#3 E1 D2 E3 E3 F#3 B6 A2 c#4 F#6', 6),
    ('D2 F2 d8 D2 F2 d8 e6 f2 e2 f2 e2 c2 A8 a4 D4 F2 G2 A8 A4 D4 F2 G2 E6 .2 D2 F2 d8 D2 F2 d8 e6 f2 e2 f2 e2 c2 A8 a4 D4 F2 G2 A8 A4 D8', 10),
    # ('C1 .1 C1 D2 C2 F2 E2 E2 C2 D2 C2 G2 F2 F2 C2 c2 A2 F2 E2 D2 D2 B2 A2 F2 G2 F2', 8),
]

def get_tone(song, speed):
    note_set = ['f-', 'f-#', 'g-', 'g-#', 'a-',
                'a-#', 'b-', 'C', 'C#', 'D',
                'D#', 'E', 'F', 'F#', 'G',
                'G#', 'A', 'A#', 'B', 'c',
                'c#', 'd', 'd#', 'e', 'f',
                'f#', 'g', 'g#', 'a', 'a#', 'b']
    freq_set = [349.23, 369.99, 392.00, 415.30, 440.00,
                466.16, 493.88, 523.25, 554.37, 587.33,
                622.25, 659.25, 698.46, 739.99, 783.99,
                830.61, 880.00, 932.33, 987.77, 1046.50,
                1108.73, 1174.66, 1244.51, 1318.51, 1396.91,
                1479.98, 1567.98, 1661.22, 1760.00, 1864.66, 1975.53]
    freq_map = dict(zip(note_set, freq_set))
    notes = str.split(song)
    print(notes)

    tone_list = []
    for i in notes:
        note = re.compile('([a-gA-G-\.]{1,3}#?)(\d?\.?\d*)').match(i)
        print(note.group(1), note.group(2))

        tone = note.group(1)
        length = float(note.group(2)) / speed * 1000


        if tone != '.':
            frequency = freq_map[tone]
            tone_list.append([frequency, length, 0])
        else:
            tone_list[-1][2] += length

    return tone_list

def rand_song():
    return get_tone(*random.choice(songs))
