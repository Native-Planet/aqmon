import random
from noun import * # make this a pip package some day
import socket
import os, os.path
import subprocess
import json
import sys
import requests
import time

def cue_noun(data):
    x = cue(int.from_bytes(data[5:], 'little'))

    hed_len = (x.head.bit_length()+7)//8
    mark = x.head.to_bytes(hed_len,'little').decode()
    noun = x.tail
    return (mark,noun)

def gen_data(json_data):
    data = Cell(1635017060,0) # %data
    data.head = 1635017060 # %data
    wifi = Cell(1768319351, -1*json_data['wifi'])       # [%wifi data]
    rco2 = Cell(846160754,    json_data['rco2'])        # [%rco2 data]
    pm02 = Cell(842034544,    json_data['pm02'])        # [%pmo2 data]
    tvoc = Cell(1668249204,   json_data['tvoc_index'])  # [%tvoc data]
    nox  = Cell(7892846,      json_data['nox_index'])   # [%nox data]
    atmp = Cell(1886221409, int(10*json_data['atmp']))  # [%atmp data]
    rhum = Cell(1836410994,   json_data['rhum'])        # [%rhum data]

    data.tail = Cell(0,0)
    data.tail.head = wifi
    data.tail.tail = Cell(0,0)
    data.tail.tail.head = rco2
    data.tail.tail.tail = Cell(0,0)
    data.tail.tail.tail.head = pm02
    data.tail.tail.tail.tail = Cell(0,0)
    data.tail.tail.tail.tail.head = tvoc
    data.tail.tail.tail.tail.tail = Cell(0,0)
    data.tail.tail.tail.tail.tail.head = nox
    data.tail.tail.tail.tail.tail.tail = Cell(0,0)
    data.tail.tail.tail.tail.tail.tail.head = atmp
    data.tail.tail.tail.tail.tail.tail.tail = Cell(0,0)
    data.tail.tail.tail.tail.tail.tail.tail.head = rhum

    return data

def newt_jam(noun_data):
    jammed_data = jam(noun_data)
    length = (jammed_data.bit_length()+7)//8
    newt_data = bytearray(jammed_data.to_bytes(length,'little'))
    length = length.to_bytes(4, 'little')
    
    newt_data.insert(0,0)
    newt_data.insert(1, length[0])
    newt_data.insert(2, length[1])
    newt_data.insert(3, length[2])
    newt_data.insert(4, length[3])

    return newt_data

def fake_data():
    data = dict()
    data['wifi'] = random.randrange(-100, 0, 1)
    data['rco2'] = random.randrange(400, 1600,1)
    data['pm02'] = random.randrange(2, 8,1)
    data['tvoc_index'] = random.randrange(100,900,1)
    data['nox_index'] = 1
    data['atmp'] = random.randrange(100, 300, 1)/10.
    data['rhum'] = random.randrange(0,100,1)
    return data

device_ip = 'http://192.168.0.69'
sock_name = '/sense/data'
pier_path = '/Users/acs/work-ships/zuse-412/zod/'
# vere_path = '/home/acs/work-ships/zuse-412/zod/'

sock_path = pier_path+'.urb/dev/'+sock_name



sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
sock.connect(sock_path)

while True:
    try:
        data = fake_data()
        print(data)
        noun_data = gen_data(data)
        newt_data = newt_jam(noun_data)

        sock.send(newt_data)
        time.sleep(2.0)
    except:
        print('error')
        sys.exit()
        pass
