#!/usr/bin/env python3
# EV3
import ev3dev.ev3 as ev3
import ev3dev.fonts as fonts
from PIL import Image
from time import sleep, time

import random
import math
import threading
import signal


class Puzzle:
    pieces = list(range(1, 16)) + [0]
    UP = (0, 1)
    DOWN = (0, -1)
    LEFT = (1, 0)
    RIGHT = (-1, 0)
    step_count = 0
    start_time = 0
    final_time = 0
    started = False
    paused = False

    def shuffle(self):
        '''Shuffle the puzzle and ensure solvable'''
        random.shuffle(self.pieces)

        # Move 0 to the end
        zeropos = self.pieces.index(0)
        self.swap(15, zeropos)

        while not self.solvable():
            self.swap(*random.sample(range(15), 2))

        self.started = False

    # Move in 4 directions
    def up(self):
        self.move(self.UP)

    def down(self):
        self.move(self.DOWN)

    def left(self):
        self.move(self.LEFT)

    def right(self):
        self.move(self.RIGHT)

    def move(self, direction, force_move=False):
        zero = self.pieces.index(0)
        targetx = self.x(zero) + direction[0]
        targety = self.y(zero) + direction[1]
        if self.valid(targetx, targety):
            if force_move or not self.paused:
                self.swap(zero, self.pos(targetx, targety))

                if not force_move:
                    if not self.started:
                        self.step_count = 0
                        self.start_time = time()
                        self.started = True
                    self.step_count += 1

    def pause(self):
        self.pause_start = time()
        self.paused = True

    def resume(self):
        self.start_time += time() - self.pause_start
        self.paused = False


    def valid(self, x, y=-999):
        ''' Check either a position or a x, y coordination is valid '''
        if y != -999:
            return x >= 0 and x <= 3 and y >= 0 and y <= 3
        else:
            return x >= 0 and x < 16

    def swap(self, one, another):
        ''' swap value with one another'''
        if one != another:
            self.pieces[one], self.pieces[another] = self.pieces[another], self.pieces[one]

    def pos(self, x, y):
        ''' Convert coordinate to position '''
        return 4 * y + x

    def x(self, pos):
        ''' convert position to x coordinate '''
        return pos % 4

    def y(self, pos):
        ''' convert position to y coordinate '''
        return pos // 4

    def coord(self, pos):
        ''' Convert position to x,y coordinate '''
        return (self.x(pos), self.y(pos))

    def check_win(self):
        win = self.pieces == list(range(1, 16)) + [0]
        if win and not self.final_time:
            self.final_time = time() - self.start_time
        return win

    def solvable(self):
        '''Maomi\'s Chain Algorithm'''
        count = 0
        mark = [False] * 16
        mark[self.pieces.index(0)] = True
        while True:
            try:
                start = mark.index(False)
            except ValueError:
                break
            mark[start] = True

            target = self.pieces[start]
            while not mark[target]:
                mark[target] = True
                target = self.pieces[target]
            count += 1
        return count % 2 == 1


    def __str__(self):
        str_pieces = ''
        for i, num in enumerate(self.pieces):
            str_pieces += str(num) + ' '
            if (i+1) % 4 == 0:
                str_pieces += '\n'

        return str_pieces


# Main program
welcome_img = Image.open('pics/welcome.png')
FONT = fonts.load('helvB14')
WELCOME = 0
MAIN = 1
PAUSE = 2

puzzles = [
    'numbers',
    'bad_apple',
    'bad_apple2',
    'github',
    'reigns',
    'pikachu',
]

conf = {
    'state': WELCOME,
    'puzzle': 0,
    'puzzle_imgs': [],
    'all_imgs': [Image.open('pics/%s.png' % p) for p in puzzles],
    'selected_puzzle': 0,
}

def reload_img():
    num = conf['puzzle']
    if num > len(puzzles) or num < 0:
        num = 0
    conf['img'] = conf['all_imgs'][num]
    width, height = conf['img'].size
    conf['puzzle_imgs'] = []
    for i in range(0,16):
        box = (
            (i % 4) * (height / 4),
            (i // 4) * (width / 4),
            (i % 4 + 1) * (height / 4),
            (i // 4 + 1) * (width / 4),
        )
        conf['puzzle_imgs'].append(conf['img'].crop(int(x) for x in box))
    print(puzzles[num])

def paint_board(done):
    while not done.is_set():
        screen.clear()
        if conf['welcome']:
            screen.image.paste(welcome_img, (0,0))
            if int(time() * 2) % 4 < 3:
                screen.draw.text((15, 85), '[Press Enter to start]', font=fonts.load('helvB14'))
        elif puzzle.check_win():
            screen.draw.text((40, 15), 'You Win!', font=fonts.load('helvB24'))
            screen.draw.text((15, 55), 'Press Enter to restart', font=fonts.load('helvB14'))
            screen.draw.text((15, 75), 'Time used: %02d:%02d' % (puzzle.final_time // 60, puzzle.final_time % 60), font=fonts.load('helvB18'))
            screen.draw.text((15, 100), '# Steps: %02d' % puzzle.step_count, font=fonts.load('helvB18'))
        elif puzzle.paused:
            try:
                screen.image.paste(conf['img'], (1, 1))
                screen.draw.rectangle((31,1,31,121), fill='black')
                screen.draw.rectangle((61,1,61,121), fill='black')
                screen.draw.rectangle((91,1,91,121), fill='black')
                screen.draw.rectangle((1,31,121,31), fill='black')
                screen.draw.rectangle((1,61,121,61), fill='black')
                screen.draw.rectangle((1,91,121,91), fill='black')
                screen.draw.rectangle((1,1,121,1), fill='black')
                screen.draw.rectangle((1,1,1,121), fill='black')
                screen.draw.rectangle((121,1,121,121), fill='black')
                screen.draw.rectangle((1,121,121,121), fill='black')
                # for i in range(3):
                #     screen.draw.rectangle((i+1) * 30 + 1, 1, (i+1) * 30 + 2, 121)
                #     screen.draw.rectangle((i+1) * 30 + 1, 1, (i+1) * 30 + 2, 121)
            except:
                continue
            screen.draw.text((128, 50), 'Puzzle', font=FONT)
            if conf['puzzle'] > 0:
                screen.draw.text((130, 70), '<', font=fonts.load('helvB24'))
            if conf['puzzle'] < len(puzzles)-1:
                screen.draw.text((155, 70), '>', font=fonts.load('helvB24'))
            screen.draw.text((137, 100), '%d/%d' % (conf['puzzle'] + 1, len(puzzles)), font=fonts.load('helvB18'))
        else:
            for i, num in enumerate(puzzle.pieces):
                if num != 0:
                    screen.image.paste(conf['puzzle_imgs'][num-1], (i % 4 * 30+1, i // 4 * 30 + 1))
            if puzzle.started:
                time_elapsed = int(time() - puzzle.start_time)
                step_count = puzzle.step_count
            else:
                time_elapsed = 0
                step_count = 0
            screen.draw.text((132, 10), 'Time', font=FONT)
            screen.draw.text((130, 60), 'Steps', font=FONT)
            screen.draw.text((132, 30), '%02d:%02d' % (time_elapsed // 60, time_elapsed % 60), font=FONT)
            screen.draw.text((140, 80), '%02d' % step_count, font=FONT)

        screen.update()

def btn_control(done):
    while not done.is_set():
        if conf['welcome']:
            if btn.enter:
                conf['welcome'] = False
                prev_btn['enter'] = True
        elif not puzzle.check_win():
            if btn.up:
                if not prev_btn['up']:
                    puzzle.up()
                    prev_btn['up'] = True
            else:
                prev_btn['up'] = False

            if btn.down:
                if not prev_btn['down']:
                    puzzle.down()
                    prev_btn['down'] = True
            else:
                prev_btn['down'] = False

            if btn.left and btn.right and puzzle.paused:
                conf['all_imgs'] = [Image.open('pics/%s.png' % p) for p in puzzles]
                sleep(1)
                print('reloaded')
            else:
                if btn.left:
                    if not prev_btn['left']:
                        puzzle.left()
                        if puzzle.paused:
                            if conf['puzzle'] > 0:
                                conf['puzzle'] -= 1
                                reload_img()
                                sleep(0.05)
                        prev_btn['left'] = True
                else:
                    prev_btn['left'] = False


                if btn.right:
                    if not prev_btn['right']:
                        puzzle.right()
                        if puzzle.paused:
                            if conf['puzzle'] < len(puzzles) - 1:
                                conf['puzzle'] += 1
                                reload_img()
                                sleep(0.05)
                        prev_btn['right'] = True
                else:
                    prev_btn['right'] = False



            if btn.enter:
                if not prev_btn['enter']:
                    if puzzle.paused:
                        if conf['selected_puzzle'] != conf['puzzle']:
                            conf['selected_puzzle'] = conf['puzzle']
                            puzzle.shuffle()
                        puzzle.resume()
                    else:
                        puzzle.pause()
                    prev_btn['enter'] = True
            else:
                prev_btn['enter'] = False

            if btn.backspace:
                if not puzzle.paused:
                    done.set()
        else: # Already Win
            if btn.enter:
                if not prev_btn['enter']:
                    puzzle.shuffle()
                    prev_btn['enter'] = True
            else:
                prev_btn['enter'] = False


btn = ev3.Button()
screen = ev3.Screen()
puzzle = Puzzle()
puzzle.shuffle()

prev_btn = {
    'up': False,
    'down': False,
    'left': False,
    'right': False,
    'enter': False,
    'backspace': False,
}

done = threading.Event()
reload_img()

def signal_handler(signal, frame):
    done.set()

signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

board_paint = threading.Thread(target=paint_board, args=(done,))
ctrl = threading.Thread(target=btn_control, args=(done,))

board_paint.start()
ctrl.start()

while not done.is_set():
    sleep(0.5)

board_paint.join()
ctrl.join()
screen.clear()
screen.update()
