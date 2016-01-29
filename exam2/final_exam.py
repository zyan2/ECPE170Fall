#!/usr/bin/python3

import argparse
import ctypes
import random
import socket
import struct
import sys



host='10.10.5.203'

port=3456
# num1 = int args()
# num2 = int arhs()

try:
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
except socket.error as msg:
        print("Error: could not create socket")
        print("Description: " + str(msg))
        sys.exit()
print("create the socket")
s.bind(("", port))
try:
	s.connect((host, port))
except socket.error as msg:
        print("Error: Could not open connection")
        print("Description: " + str(msg))
        sys.exit()
 
print("Connection established")

a = struct.pack('>I', 989160764)
b = struct.pack('>I', 25)
c = struct.pack('>I', 66)
request = "2"+a + b+ c
s.sendall(request)
max_recv=64*1024
response = s.recv(max_recv)
(suc,response) = response.split(bytes("2",'ascii'), 2)
#//if suc == 1
#//print("Sucess")
#//else
#//print("Failure")
#//(gcd,response)= response.split(bytes("1",'ascii'), 2)
#//print(gcd)
s.close()


