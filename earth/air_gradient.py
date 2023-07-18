import random
from noun import * # make this a pip package some day
import socket
import os, os.path
import subprocess
import json
import sys
import requests

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
    data.tail.tail.tail.tail.tail.tail = Cell(atmp, rhum)

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

device_ip = 'http://192.168.0.69'
sock_name = '/sense/data'
pier_path = '/home/amadeo/learn_hoon/nec/'
vere_path = '/home/amadeo/learn_hoon/urbit-test'

sys.exit()

sock_path = pier_path+'.urb/dev/'+sock_name



sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
sock.connect(sock_path)

while True:
    try:
        data = requests.get(device_ip).json()
        noun_data = gen_data(data)
        jammed_data = jam(noun_data)
        length = (jammed_data.bit_length()+7)//8
        length = length.to_bytes(4, 'big')
        newt_data = bytearra(jammed_data.to_bytes(length+5,'big'))
        
        for i in range(0,4):
            newt_data[i+1] = length[i]

        sock.send(newt_data)
    except:
        print('error')
        pass
