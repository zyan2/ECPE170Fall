#!/usr/bin/env python3

# Python DNS query client
#
# Example usage:
#   ./dns.py --type=A --name=www.pacific.edu --server=8.8.8.8
#   ./dns.py --type=AAAA --name=www.google.com --server=8.8.8.8

# Should provide equivalent results to:
#   dig www.pacific.edu A @8.8.8.8 +noedns
#   dig www.google.com AAAA @8.8.8.8 +noedns
#   (note that the +noedns option is used to disable the pseduo-OPT
#    header that dig adds. Our Python DNS client does not need
#    to produce that optional, more modern header)


from dns_tools import dns  # Custom module for boilerplate code
from dns_tools import dns_header_bitfields
import argparse
import ctypes
import random
import socket
import struct
import sys

def main():

    # Setup configuration
    parser = argparse.ArgumentParser(description='DNS client for ECPE 170')
    parser.add_argument('--type', action='store', dest='qtype',
                        required=True, help='Query Type (A or AAAA)')
    parser.add_argument('--name', action='store', dest='qname',
                        required=True, help='Query Name')
    parser.add_argument('--server', action='store', dest='server_ip',
                        required=True, help='DNS Server IP')

    args = parser.parse_args()
    qtype = args.qtype
    qname = args.qname
    server_ip = args.server_ip
    port = 53
    server_address = (server_ip, port)

    if qtype not in ("A", "AAAA"):
        print("Error: query Type should  be 'A' (IPv4) or 'AAAA' (IPv6)")
        sys.exit()

    # Create UDP socket
    # ---------
    # STUDENT TO-DO
    # ---------
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    print("created a UDP socket")

    # Generate DNS request message
    # ---------
    # STUDENT TO-DO
    # ---------
    header = dns_header_bitfields()
    msg_ID = random.getrandbits(16)#dns_tool
    header.qr = 0#query
    header.opcode = 0#stand query
    header.aa = 0#1 represents authoritative response
    header.tc = 0
    header.rd = 1# 1 = Recursion desired.
    header.ra = 1# 1 = Recursion available
    header.reserved = 0
    header.rcode = 0# 0 - No error
    x = b''+header

    
    qdcount = 1
    ancount = 0
    nscount = 0
    arcount = 0
    qclass = 1
    
   
    

    header_bytes = struct.pack('!H2sHHHH', #
                   msg_ID,      
                   x, 
                   qdcount,      
                   ancount,      
                   nscount,       
                   arcount) 
    #print("head_bytes is")
    #print(header_bytes)    


    raw_bytes = b''

    sqname = qname.split('.')

    for i in sqname:
        raw_bytes += struct.pack("B", len(i))
        raw_bytes += bytes(i, 'ascii')
    raw_bytes += struct.pack("B", 0)
    
    if qtype == "A":
          qq = 1
    else:
          qq = 28

    dns_query = header_bytes + raw_bytes + struct.pack("!HH", qq, qclass)

    # Send request message to server
    # (Tip: Use sendto() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------
    bytes_sent = s.sendto(dns_query, server_address)


    # Receive message from server
    # (Tip: use recvfrom() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------
    max_bytes = 4096
    (raw_bytes, src_addr) = s.recvfrom(max_bytes)

    # Close socket
    # ---------
    # STUDENT TO-DO
    # ---------
    s.close()
       
    print("closed the socket")

    # Decode DNS message and display to screen
    dns.decode_dns(raw_bytes)


if __name__ == "__main__":
    sys.exit(main())
