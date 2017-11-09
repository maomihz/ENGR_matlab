#!/usr/bin/env python3
import ev3dev.ev3 as ev3

btn = ev3.Button()

odd = False
while not btn.any():
    odd = not odd
    if odd:
        ev3.Leds.set_color(ev3.Leds.LEFT, ev3.Leds.GREEN)
        ev3.Leds.set_color(ev3.Leds.RIGHT, ev3.Leds.RED)
    else:
        ev3.Leds.set_color(ev3.Leds.RIGHT, ev3.Leds.GREEN)
        ev3.Leds.set_color(ev3.Leds.LEFT, ev3.Leds.RED)
