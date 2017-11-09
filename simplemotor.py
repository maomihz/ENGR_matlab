import ev3dev.ev3 as ev3
from time import sleep

import threading

motor = ev3.Motor('outA')
button = ev3.Button()

try:
    pressed = False
    pause = False
    motor.speed_sp = 80
    while True:
        if not pause:
            motor.run_forever()
        else:
            motor.stop(stop_action='coast')

        if button.any():
            if not pressed:
                pressed = True
                pause = not pause
        else:
            pressed = False
        # sleep(0.5)
        # motor.speed_sp = -motor.speed_sp
finally:
    motor.stop(stop_action='coast')
    # ev3.Sound.beep()
