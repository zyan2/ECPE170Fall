#!/usr/bin/python3

# Usage:
#  ./display.py --help
#  ./display.py --port=??? --url=????
#
# Example commands:
#  ./display.py --port=80 --url=http://www.google.com/images/srpr/logo3w.png
#  ./display.py --port=80 --url=http://imgsrc.hubblesite.org/hu/db/images/hs-2006-01-a-800_wallpaper.jpg
#  ./display.py --port=80 --url=http://imgsrc.hubblesite.org/hu/db/images/hs-2010-13-a-2560x1024_wallpaper.jpg
#  ./display.py --port=80 --url=http://ut-images.s3.amazonaws.com/wp-content/uploads/2009/09/SED_wall_1920x1200.jpg
#  ./display.py --port=80 --url=http://history.nasa.gov/ap11ann/kippsphotos/69-H-1096.jpg
#  ./display.py --port=80 --url=http://www.nasa.gov/centers/dryden/images/content/690557main_SCA_Endeavour_over_Ventura.jpg
#  ./display.py --port=8080 --url=http://cmdb.nccs.nasa.gov/odisees/images/CDS_Website_Banner-2-4-14.png

import argparse
import string
import socket
import sys
import os
from subprocess import call
from urllib.parse import urlparse


def GenerateHeader(urlParse):
    HttpRequestHeader = b'GET ' +urlParse.path.encode() + b' HTTP/1.1\r\n'
    HttpRequestHeader += b'Host: ' + urlParse.netloc.encode() + b'\r\n'
    HttpRequestHeader += b'Connection: close\r\n\r\n'
    return HttpRequestHeader

def decodeReply(reply):
    try:
        number = reply.split(" ")[1]
    except Exception as msg:
        print("No such files in server")
        return False

    if number == "200":
        return True
    return False
# Size of receive buffer.
# Maximum number of bytes to get from network in one recv() call
max_recv = 64*1024

# Setup configuration
parser = argparse.ArgumentParser(description='Download client for ECPE 170')
parser.add_argument('--url', 
                    action='store',
                    dest='url', 
                    required=True,
                    help='URL of file to download')
parser.add_argument('--port', 
                    action='store',
                    dest='port', 
                    required=True,
                    help='Port number of web server')

args = parser.parse_args()
url = args.url
port = int(args.port)

print("Running download client")
print("Download url: %s" % url)
print("Download port number: %i" % port)

# Split URL into "host", "path", and "filename" variables.
# http://www.google.com/images/srpr/logo3w.png
#  * host=www.google.com
#  * path=/images/srpr
#  * file=logo3w.png

u = urlparse(url)
print("Parsing URL:")
print(" * scheme=%s" % u.scheme)
print(" * netloc=%s" % u.netloc)
print(" * path+file=%s" % u.path)
print(" * path=%s" % os.path.dirname(u.path))
print(" * file=%s" %os.path.basename(u.path))
print()

# Download file (image) from http://host/path/filename
host = u.netloc
path = os.path.dirname(u.path) + '/'
filename = os.path.basename(u.path)

print("Preparing to download object from http://" + host + path + filename)


# *****************************
# STUDENT WORK: 
#  (1) Build the HTTP request string to send to the server
#      and *print it* on the screen.
#
#      Requirements:
#        HTTP 1.1
#        Use the Host header
#        Request the connection be closed after response sent.
#
#      Tip: What is the important sequence of characters that
#      must be provided at the end of the HTTP client request
#      to the server? (otherwise, the server won't begin processing)
# *****************************
# If successful, we now have TWO sockets
#  (1) The original listening socket, still active
#  (2) The new socket connected to the client
# Receive data

request = GenerateHeader(u)





# *****************************
# STUDENT WORK: 
#  (2) Create a TCP socket (SOCK_STREAM)
#  (3) Connect to the remote host using the socket
#  (4) Send the HTTP request to the remote host.
#      Tip: Look at the demo client program to see how
#      to convert a unicode string to a byte array
#      prior to transmitting it.
# *****************************

try:
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
except socket.error as msg:
        print("Error: could not create socket")
        print("Description: " + str(msg))
        sys.exit()

try:
	s.connect((host, port))
except socket.error as msg:
        print("Error: Could not open connection")
        print("Description: " + str(msg))
        sys.exit()
 
print("Connection established")
print(request)
s.sendall(request)




# *****************************
# STUDENT WORK: 
#  (5) Receive everything the remote host sends us
#      in chunks of 'max_recv' bytes (64kB).
#      When the server finishes sending us the data,
#      it will close the socket. That is detected locally
#      by receiving an array of length ZERO
#      (i.e. no bytes received)
#  (6) Close the socket - finished with the network now
# *****************************
data = b''
print("Receiving response from server")
while True:
	response = s.recv(max_recv)
	if len(response) <= 0:
		break
	data += response

s.close()




# *****************************
# STUDENT WORK: 
#  (7) Split the response into two parts:
#        1.) The part before the \r\n\r\n sequence - the HEADER
#        2.) The part after the \r\n\r\n sequence - the DATA
#  (8) Print the HEADER out on the screen - it's ASCII text
#  (9) Save the DATA to disk as a binary file. Somewhere
#      in the /tmp directory would be a great spot.
# *****************************
#(header,data) = response.split(bytes("\r\n\r\n",'ascii'), 1)
(header,data) = data.split(bytes("\r\n\r\n",'ascii'), 1)

header = header.decode('ascii')

print("Header from server (omitting data):")
print("-------------------")
print(header)
print("-------------------\n")
#try:
 #   theHeader = raw_bytes.split("\r\n\r\n")[0]
  #  theData = raw_bytes.split("\r\n\r\n")[1]
   # print(theHeader)
#except Exception as msg:
 #   print("No such files in server")



# *****************************
# END OF STUDENT WORK
# *****************************

# Assuming you downloaded the image, and placed its path/filename
# in the variable 'saved_filename', use the 'eog' utility to 
# display the image on screen
saved_filename=filename
output = open(saved_filename, 'wb')
output.write(data)
output.close()

call(["eog", saved_filename])
