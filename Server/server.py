import socket
import io
import threading
import time
import convert_image

server = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
server.bind(('192.168.35.145',1002))

server.listen()

BUFFER_SIZE = 512

def data_recv():
    with open('server_image.jpg','wb') as file:
        recv_data = client_socket.recv(BUFFER_SIZE)
        print("image is arrived")
        try:
            while recv_data:
                file.write(recv_data)
                recv_data = client_socket.recv(BUFFER_SIZE)
                if recv_data == b"%IMAGE_COMPLETE%":
                    print("image clearly done")
                    break
        except:
            print("image not clearly done")

while True:
    client_socket,_ = server.accept()
    print("new one!")
    t=threading.Thread(target=data_recv)
    t.deamon=True
    t.start()
    time.sleep(5)
    #convert_image.test()
    client_socket.send(b"192.168.35.145:8000")
    time.sleep(5)
    client_socket.close()
    print("done")
