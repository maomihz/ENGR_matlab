#!/usr/bin/env python3
# EV3
import ev3dev.ev3 as ev3
import ev3dev.fonts as fonts

# Sys
from PIL import Image
from time import time, sleep
import json
import threading
import random
import signal
import os
import subprocess

from statistics import mode, mean, stdev
from math import sqrt

import urllib.request as request
import urllib.parse as parse

# import requests

# Load default configuration
conf = {
    'rotate': 0, # Speed of rotating motor
    'stir': 0, # Speed of stirring motor
    'led': 0, # LED Mode
    'paused': False, # Pause or not
    'music': False, # Play music or not
    'alternate_stir': True, # Alternate stirring mode
    'alternate_pause': 0.5, # Alternate stirring pause
    'rotate_pause': 5,
    'music_subprocess': None,
    'subprocess_paused': False,
    'last_op_time': time(),
}

# Infos on the screen
info = {
    'text': '',
    'time': time()
}

# If the configuration file exist then read the configuration and update app settings
if os.path.isfile('motor.json'):
    with open('motor.json', 'r') as f:
        conf_file = json.loads(open('motor.json').read())
        conf.update(conf_file)


# Setup constants and helper functions
LED_COLORS = (ev3.Leds.RED, ev3.Leds.GREEN, ev3.Leds.ORANGE, ev3.Leds.AMBER, ev3.Leds.YELLOW)
SPEED_STEP = 5
STIR_STEP = 5
ALTERNATE_STEP = 0.1
GITHUB_LOGO = Image.open('github_s.png')
FONT = fonts.load('helvB18')

# Sorter variables
colors_rgb = {
    ('s','p'): ((112, 89, 78),),
    ('s','b'): ((24, 17, 25),(20.7,12.8,22),(21.1, 14, 20.5)),
    ('b','b'): ((31, 29, 49),),
    ('s','r'): ((107, 10, 7), (110, 11, 6), (108, 11, 5), (134, 14, 10)),
    ('b','r'): ((64, 8, 5), (95, 10, 5), (85, 10, 6), (77, 9, 6)),
    ('s','g'): ((40, 54, 17), (50, 72, 27), (38, 51, 15), (35, 42, 14)),
    ('b','g'): ((48, 68, 21), (43, 62, 18), (46, 65, 19), (45, 65, 17)),
    ('s','y'): ((218, 113, 15), (195, 93, 15), (209, 119, 15), (209, 106, 14)),
    ('b','y'): ((171, 71, 11),(184, 77, 14), (175, 65, 11), (177, 75, 12)),
    ('s','w'): ((208, 175, 147), (221, 188, 146), (208, 175, 140),(202, 172, 136)),
    ('b','w'): ((179, 152, 109),),
    ('s','s'): ((60, 40, 30), (72, 56, 36), (87, 70, 46), (65, 46, 30)),
    # ('s','s'): ((87, 70, 46), (65, 46, 30), (55.4, 43.5, 23.1)),
}

marbles_count = [0] * 12

sizes_list = {
    'b':'big',
    's':'small',
}

types_list = {
    'p': 'plastic',
    'w': 'white',
    'g': 'green',
    'y': 'yellow',
    's': 'steel',
    'b': 'blue',
    'r': 'red',
}

# Load EV3 components
btn = ev3.Button()
screen = ev3.Screen()
rotating_motor = ev3.Motor('outA'); assert rotating_motor.connected
stirring_motor = ev3.Motor('outB'); assert stirring_motor.connected
position_motor = ev3.Motor('outD'); assert position_motor.connected
holding_motor = ev3.Motor('outC'); assert holding_motor.connected
color_sensor = ev3.ColorSensor(); assert color_sensor.connected
distance_sensor = ev3.UltrasonicSensor(); assert distance_sensor.connected


# rotating_motor.position = 0
# stirring_motor.position = 0
position_motor.speed_sp = 30
holding_motor.speed_sp = 300

# Command these lines if necessary
# position_motor.position = 0
# holding_motor.position = 0


prev_btn = {
    'enter': False,
    'music': False,
    'save': False,
}


def print_info(text):
    info['text'] = text
    info['time'] = time()

def detect_buttons(done):
    while not done.is_set():
        if btn.up and btn.down:
            if not prev_btn['music']:
                conf['music'] = not conf['music']
                if conf['music']:
                    print_info('Music On')
                else:
                    print_info('Music Off')
                prev_btn['music'] = True
        else:
            prev_btn['music'] = False
            if btn.up: # UP button: increase speed
                conf['rotate'] = min(1000, conf['rotate'] + SPEED_STEP)

            if btn.down: # Down button: decrease speed
                conf['rotate'] = max(0, conf['rotate'] - SPEED_STEP)

        if btn.left and btn.right:
            if not prev_btn['save']:
                with open('motor.json', 'w') as f:
                    f.write(json.dumps(conf))
                    print_info('Config Written')
                    prev_btn['save'] = True
        else:
            prev_btn['save'] = False
            if btn.left: # Down button: decrease speed
                # conf['stir'] = max(0, conf['stir'] - STIR_STEP)
                conf['rotate_pause'] = max(0.1, conf['rotate_pause'] - 0.1)

            if btn.right:
                # conf['stir'] = min(1000, conf['stir'] + STIR_STEP)
                conf['rotate_pause'] = min(10, conf['rotate_pause'] + 0.1)

        if btn.enter:
            if not prev_btn['enter']:
                conf['paused'] = not conf['paused']
                prev_btn['enter'] = True
        else:
            prev_btn['enter'] = False

def rotation_motor_runner(done):
    while not done.is_set():
        if not conf['paused']:
            if rotating_motor.position > 360:
                rotating_motor.stop(stop_action='brake')
                rotating_motor.position = 0
                sleep(conf['rotate_pause'])
            rotating_motor.run_forever(speed_sp = conf['rotate'])
        else:
            rotating_motor.stop(stop_action='coast')
        sleep(0.2)


def stir_motor_runner(done):
    while not done.is_set():
        if not conf['paused']:
            stirring_motor.run_forever(speed_sp = conf['stir'])
        else:
            stirring_motor.stop(stop_action='coast')
        sleep(0.2)


def motor_alternator(done):
    while not done.is_set():
        if conf['alternate_stir']:
            conf['stir'] = -conf['stir']
            sleep(0.8)


def screen_runner(done):
    while not done.is_set():
        screen.clear()
        screen.draw.text((1, 1), 'Paused' if conf['paused'] else 'Running...', font=FONT)
        if conf['paused'] and round(time()) % 2 == 0 or not conf['paused']:
            screen.image.paste(GITHUB_LOGO, (130, 1))

        screen.draw.text((1, 25), 'Motor: %d' % conf['rotate'], font=FONT)
        screen.draw.text((1, 50), 'Alternate: %.1fs' % conf['rotate_pause'], font=FONT)
        screen.draw.text((1, 75), info['text'], font=FONT)
        screen.update()

def led_blinker(done):
    while not done.is_set():
        if not conf['paused']:
            ev3.Leds.set_color(ev3.Leds.LEFT, random.choice(LED_COLORS))
            ev3.Leds.set_color(ev3.Leds.RIGHT, random.choice(LED_COLORS))
            sleep(0.5)

def detection_runner(done):
    while not done.is_set():
        while True:
            if done.is_set():
                return;
            rs = []
            gs = []
            bs = []
            for i in range(10):
                rs.append(color_sensor.red)
                gs.append(color_sensor.green)
                bs.append(color_sensor.blue)
                if rs[-1] > 15 or gs[-1] > 5 or bs[-1] > 5:
                    conf['paused'] = True
                    conf['last_op_time'] = time()
                else:
                    conf['paused'] = False
                # print('bbb')
            r = mean(rs)
            # print('biong')
            g = mean(gs)
            # print('biong')
            b = mean(bs)
            # print('biong')
            cstd = stdev(rs) + stdev(gs) + stdev(bs)

            print('%.1f, %.1f, %.1f' % (r,g,b), end = ' | ')

            matches = dict()
            min_match = 10000009
            min_match_diff = 10000009

            for size, type in colors_rgb.keys():
                re = mean(a[0] for a in colors_rgb[(size, type)])
                ge = mean(a[1] for a in colors_rgb[(size, type)])
                be = mean(a[2] for a in colors_rgb[(size, type)])
                match_diff = abs((r - re)/re) + abs((g - ge)/ge) + abs((b - be) / be)
                match_dist = sqrt((r - re) ** 2 + (g - ge) ** 2 + (b - be) ** 2)
                if min_match > match_dist:
                    final_size = size
                    final_type = type
                    min_match = match_dist
                    min_match_diff = match_diff


            distance = distance_sensor.distance_centimeters
            if min_match_diff < 1.1 and cstd < 3:
                if final_type in 'rgwy' or (final_type in 'b' and final_size in 'b'):
                    print('b')
                    distances = []
                    for i in range(10):
                        distances.append(distance_sensor.distance_centimeters)
                    # print(distances)
                    distance = mean(distances)
                    # print(distance)
                    # if (final_type == 'r' and distance > 71 and distance < 100) or (final_type not in 'r' and distance > 75 and distance < 100):
                    final_size = 'b'
                    print(final_type)
                    if final_type == 'y':
                        if distance > 70 and distance < 85:
                            final_size = 's'
                    elif final_type == 'w':
                        if (distance > 70 and distance < 90) or (distance > 58.5 and distance < 59.5):
                            final_size = 's'
                    else:
                        if distance > 75 and distance < 90:
                            final_size = 's'
                print('break')
                break
            print('ERR=%.2f' % min_match_diff, end=' | ')
            print('DIST=%.3f' % min_match, end = ' | ')
            print('%.1f' % distance, end=' | ')
            print('STD=%.3f' % cstd, end = ' | ')


            print(sizes_list.get(final_size, 'None') + ',' + types_list.get(final_type, 'None'), end='')
            print()



        print('ERR=%.2f' % min_match_diff, end=' | ')
        print('DIST=%.3f' % min_match, end = ' | ')
        print('%.1f' % distance, end=' | ')
        print('STD=%.3f' % cstd, end = ' | ')


        print(sizes_list.get(final_size, 'None') + ',' + types_list.get(final_type, 'None'), end='')
        print()
        conf['paused'] = True;

        offset = -8
        #       SB,  S,   SG,  SY,  SR,  SW,  P,   BB,  BY,  BG,  BR,  BW
        pos_list = [-13, -20, -29, -38, -46, -54, -62, -69, -77, -85, -97]
        position_motor.speed_sp = 30

        # position_motor.run_to_abs_pos(position_sp=random.choice(pos_list)+offset)
        sleep(1.5)

        to_pos = pos_list[5]
        if final_type == 's':
            to_pos = pos_list[0]
            marbles_count[10] += 1
        elif final_type == 'y' and final_size == 's':
            to_pos = -999
            marbles_count[11] += 1
        elif final_type == 'g' and final_size == 's':
            to_pos = pos_list[1]
            marbles_count[9] += 1
        elif final_type == 'r' and final_size == 's':
            to_pos = pos_list[2]
            marbles_count[8] += 1
        elif final_type == 'b' and final_size == 's':
            to_pos = pos_list[3]
            marbles_count[7] += 1
        elif final_type == 'w' and final_size == 's':
            to_pos = pos_list[4]
            marbles_count[6] += 1
        elif final_type == 'b' and final_size == 'b':
            to_pos = pos_list[5]
            marbles_count[5] += 1
        elif final_type == 'p':
            to_pos = pos_list[6]
            marbles_count[4] += 1
        elif final_type == 'g' and final_size == 'b':
            to_pos = pos_list[7]
            marbles_count[3] += 1
        elif final_type == 'r' and final_size == 'b':
            to_pos = pos_list[8]
            marbles_count[2] += 1
        elif final_type == 'y' and final_size == 'b':
            to_pos = pos_list[9]
            marbles_count[1] += 1
        elif final_type == 'w' and final_size == 'b':
            to_pos = pos_list[10]
            marbles_count[0] += 1

        if not to_pos == -999:
            position_motor.run_to_abs_pos(position_sp=to_pos + offset, stop_action='hold')

        sleep(1)

        holding_motor.speed_sp = 200
        holding_motor.run_to_abs_pos(position_sp=100, stop_action='hold')
        sleep(1.7)
        holding_motor.run_to_abs_pos(position_sp=0, stop_action='hold')
        #
        sleep(3)
        if not to_pos == -999:
            position_motor.run_to_abs_pos(position_sp=2+offset, stop_action='coast')
        conf['paused'] = False # Resume motor functions
        conf['last_op_time'] = time()

def music_player(done):
    while not done.is_set():
        if not conf['music']:
            if not conf['paused']:
                if not conf['music_subprocess'] or conf['music_subprocess'].poll() != None:
                    conf['music_subprocess'] = subprocess.Popen('music/Magnolia.sh', shell=True, preexec_fn=os.setsid);
                    print('biong! biong! biong')
                elif conf['subprocess_paused']:
                    os.killpg(os.getpgid(conf['music_subprocess'].pid), signal.SIGCONT)
                    conf['subprocess_paused'] = False
            else:
                if conf['music_subprocess']:
                    os.killpg(os.getpgid(conf['music_subprocess'].pid), signal.SIGSTOP)
                    conf['subprocess_paused'] = True
        else:
            if conf['music_subprocess'] != None and conf['music_subprocess'].poll() == None:
                os.killpg(os.getpgid(conf['music_subprocess'].pid), signal.SIGKILL)
                conf['music_subprocess'] = None
    if conf['music_subprocess']:
        os.killpg(os.getpgid(conf['music_subprocess'].pid), signal.SIGKILL)

def auto_pauser(done):
    while not done.is_set():
        if time() - conf['last_op_time'] > 30:
            done.set()


def signal_handler(signal, frame):
    done.set()

for sig in (signal.SIGINT, signal.SIGTERM):
    signal.signal(sig, signal_handler)


done = threading.Event()
running_threads = (
    # threading.Thread(target=detect_buttons, args=(done,)),
    threading.Thread(target=rotation_motor_runner, args=(done,)),
    threading.Thread(target=stir_motor_runner, args=(done,)),
    # threading.Thread(target=screen_runner, args=(done,)),
    # threading.Thread(target=led_blinker, args=(done,)),
    # threading.Thread(target=music_player, args=(done,)),
    threading.Thread(target=motor_alternator, args=(done,)),
    threading.Thread(target=detection_runner, args=(done,)),
    # threading.Thread(target=auto_pauser, args=(done,)),
)

for t in running_threads:
    t.start()

while not btn.backspace and not done.is_set():
    if info['text'] and time() - info['time'] > 3:
        info['text'] = ''
    sleep(0.1)

done.set()
for t in running_threads:
    t.join()

# Cleanup action
rotating_motor.stop(stop_action='coast')
stirring_motor.stop(stop_action='coast')
ev3.Leds.all_off()
screen.clear()
screen.update()
print(marbles_count)

# Upload to server
request.urlopen('http://ss.lk1.bid:8099/?' + parse.urlencode({'key': marbles_count}))
sleep(5)
request.urlopen('http://ss.lk1.bid:8099/?' + parse.urlencode({'key': marbles_count}))
