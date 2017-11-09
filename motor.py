#!/usr/bin/env python3
# EV3
import ev3dev.ev3 as ev3
import ev3dev.fonts as fonts
from PIL import Image

# Sys
import time
sleep = time.sleep
import random
import json
import signal
import os

# Custom
import player

# Load configuration
conf = {
    'rotate': 0,
    'stir': 0,
    'led': 0,
    'paused': False,
    'music': False
}

if os.path.isfile('motor.json'):
    with open('motor.json', 'r') as f:
        conf_file = json.loads(open('motor.json').read())
        conf.update(conf_file)

# Setup constants and helper functions
LED_COLORS = (ev3.Leds.RED, ev3.Leds.GREEN, ev3.Leds.ORANGE, ev3.Leds.AMBER, ev3.Leds.YELLOW)
SPEED_STEP = 5
STIR_STEP = 5
GITHUB_LOGO = Image.open('github_s.png')

def print_text(text, x=1, y=1):
    screen.draw.text((x, y), text, font=fonts.load('helvB24'))

# Load EV3 components
btn = ev3.Button()
screen = ev3.Screen()
rotating_motor = ev3.LargeMotor('outA')
stirring_motor = ev3.LargeMotor('outD')
rotating_motor.speed_sp = conf['rotate']
stirring_motor.speed_sp = conf['stir']

song = None
consecutive_increment = 0
info_text = ''
info_time = None
scr_updated = True

prev_btn_state = {
    'enter': False
}

try:
    # Start the motor
    if not conf['paused']:
        rotating_motor.run_forever()
        stirring_motor.run_forever()
    ev3.Leds.set_color(ev3.Leds.LEFT, random.choice(LED_COLORS))
    ev3.Leds.set_color(ev3.Leds.RIGHT, random.choice(LED_COLORS))

    # Detecting buttons
    while not btn.backspace:
        if btn.up and btn.down: # Play a song
            if not song or song.poll() != None:
                song = ev3.Sound.tone(player.rand_song())
                info_text = 'Playing Music'
                scr_updated = True

        else:
            if btn.up: # UP button: increase speed
                conf['rotate'] += SPEED_STEP
                # Fix > 1000
                if conf['rotate'] > 1000:
                    conf['rotate'] = 1000
                rotating_motor.speed_sp = conf['rotate']
                if not conf['paused']:
                    rotating_motor.run_forever()
                scr_updated = True

            if btn.down: # Down button: decrease speed
                conf['rotate'] -= SPEED_STEP
                # Fix < 0
                if conf['rotate'] < 0:
                    conf['rotate'] = 0
                rotating_motor.speed_sp = conf['rotate']
                if not conf['paused']:
                    rotating_motor.run_forever()
                scr_updated = True

        if btn.left and btn.right:
            with open('motor.json', 'w') as f:
                f.write(json.dumps(conf))
                info_text = 'Config Written'
                scr_updated = True
        else:
            if btn.right: # UP button: increase speed
                conf['stir'] += STIR_STEP
                # Fix > 1000
                if conf['stir'] > 1000:
                    conf['stir'] = 1000
                stirring_motor.speed_sp = conf['stir']
                if not conf['paused']:
                    stirring_motor.run_forever()
                scr_updated = True

            if btn.left: # Down button: decrease speed
                conf['stir'] -= STIR_STEP
                # Fix < 0
                if conf['stir'] < 0:
                    conf['stir'] = 0
                stirring_motor.speed_sp = conf['stir']
                if not conf['paused']:
                    stirring_motor.run_forever()
                scr_updated = True


        if btn.enter: # Enter button: pause
            if prev_btn_state['enter'] == False:
                conf['paused'] = not conf['paused']
                prev_btn_state['enter'] = True

                if conf['paused']:
                    rotating_motor.stop(stop_action='coast')
                    stirring_motor.stop(stop_action='coast')
                else:
                    rotating_motor.run_forever()
                    stirring_motor.run_forever()
                scr_updated = True

        else:
            prev_btn_state['enter'] = False

        if info_text and not info_time:
            info_time = time.time()
        if info_time and time.time() - info_time > 3:
            info_text = ''
            info_time = None
            scr_updated = True

        # Draw LEDs
        if scr_updated:
            screen.clear()
            if conf['paused']:
                print_text('Paused')
            else:
                print_text('Running...')
                screen.image.paste(GITHUB_LOGO, (130, 1))
            print_text('Motor: %d' % conf['rotate'], y=30)
            print_text('Stir: %d' % conf['stir'], y=60)
            print_text(info_text, y=90)
            screen.update()
            scr_updated = False

finally:
    rotating_motor.stop(stop_action='coast')
    stirring_motor.stop(stop_action='coast')
    ev3.Leds.all_off()
    screen.clear()
    screen.update()
