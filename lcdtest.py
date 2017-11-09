#!/usr/env/python3

import ev3dev.ev3 as ev3
import ev3dev.fonts as fonts

screen = ev3.Screen()
btn = ev3.Button()

screen.clear()

while True:
    screen.clear()
    if btn.any():
        screen.draw.text((10,10), 'Hello Button!', font=fonts.load('helvB24'))
    else:
        screen.draw.text((10,10), 'Hello World!', font=fonts.load('helvB24'))
    screen.update()
