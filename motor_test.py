#!/usr/bin/env python3
# EV3
import ev3dev.ev3 as ev3
from time import sleep
import random
from statistics import mode, mean, stdev
from math import sqrt

# position_motor = ev3.Motor('outA'); assert position_motor.connected
#
# holding_motor = ev3.Motor('outD'); assert holding_motor.connected
color_sensor = ev3.ColorSensor(); assert color_sensor.connected
distance_sensor = ev3.UltrasonicSensor(); assert distance_sensor.connected

# position_motor.position = 0

colors_rgb = {
    ('s','p'): ((112, 89, 78),),
    ('s','b'): ((24, 16, 29),),
    ('b','b'): ((31, 29, 49),),
    ('s','r'): ((107, 10, 7), (110, 11, 6), (108, 11, 5), (134, 14, 10)),
    ('b','r'): ((64, 8, 5), (95, 10, 5), (85, 10, 6), (77, 9, 6)),
    ('s','g'): ((40, 54, 17), (50, 72, 27), (38, 51, 15), (35, 42, 14), (28.7, 32.3, 10.1)),
    ('b','g'): ((48, 68, 21), (43, 62, 18), (46, 65, 19), (45, 65, 17)),
    ('s','y'): ((218, 113, 15), (195, 93, 15), (209, 119, 15), (209, 106, 14)),
    ('b','y'): ((171, 71, 11),(184, 77, 14), (175, 65, 11), (177, 75, 12)),
    ('s','w'): ((208, 175, 147), (221, 188, 146), (208, 175, 140),(202, 172, 136)),
    ('b','w'): ((179, 152, 109),),
    ('s','s'): ((60, 40, 30), (72, 56, 36), (87, 70, 46), (65, 46, 30)),
    # ('s','s'): ((87, 70, 46), (65, 46, 30), (55.4, 43.5, 23.1)),
}

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

# position_motor.position = 0
# holding_motor.position = 0
while True:
    while True:
        rs = []
        gs = []
        bs = []
        for i in range(10):
            rs.append(color_sensor.red)
            gs.append(color_sensor.green)
            bs.append(color_sensor.blue)
        r = mean(rs)
        g = mean(gs)
        b = mean(bs)
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
        if min_match_diff < 1.1 and cstd < 2:
            if final_type in 'rgw':
                distances = []
                for i in range(10):
                    distances.append(distance_sensor.distance_centimeters)
                # print(distances)
                distance = mean(distances)
                # print(distance)
                if (final_type == 'r' and distance > 72 and distance < 100) or (final_type in 'gw' and distance > 75 and distance < 100):
                    final_size = 's'
                else:
                    final_size = 'b'
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


# offset = 4
# #       SB,  S,   SG,  SY,  SR,  SW,  P,   BB,  BY,  BG,  BR,  BW
# pos_list = [-13, -20, -29, -38, -46, -54, -62, -69, -77, -85, -93]
# position_motor.speed_sp = 30
#
# # position_motor.run_to_abs_pos(position_sp=random.choice(pos_list)+offset)
# sleep(1.5)
#
# to_pos = pos_list[5]
# if final_type == 's':
#     to_pos = pos_list[0]
# elif final_type == 'b' and final_size == 's':
#     to_pos = -999
# elif final_type == 'g' and final_size == 's':
#     to_pos = pos_list[1]
# elif final_type == 'y' and final_size == 's':
#     to_pos = pos_list[2]
# elif final_type == 'r' and final_size == 's':
#     to_pos = pos_list[3]
# elif final_type == 'w' and final_size == 's':
#     to_pos = pos_list[4]
# elif final_type == 'p':
#     to_pos = pos_list[5]
# elif final_type == 'b' and final_size == 'b':
#     to_pos = pos_list[6]
# elif final_type == 'y' and final_size == 'b':
#     to_pos = pos_list[7]
# elif final_type == 'g' and final_size == 'b':
#     to_pos = pos_list[8]
# elif final_type == 'r' and final_size == 'b':
#     to_pos = pos_list[9]
# elif final_type == 'w' and final_size == 'b':
#     to_pos = pos_list[10]
#
# if not to_pos == -999:
#     position_motor.run_to_abs_pos(position_sp=to_pos + offset)
#
# sleep(0.5)
#
# holding_motor.speed_sp = 200
# holding_motor.run_to_abs_pos(position_sp=100, stop_action='hold')
# sleep(1.7)
# holding_motor.run_to_abs_pos(position_sp=0, stop_action='hold')
# #
# sleep(3)
# if not to_pos == -999:
#     position_motor.run_to_abs_pos(position_sp=0+offset)
