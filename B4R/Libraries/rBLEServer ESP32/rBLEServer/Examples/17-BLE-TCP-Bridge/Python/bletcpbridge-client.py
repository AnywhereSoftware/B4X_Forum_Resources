"""BLE-TCP-Bridge-Client

A client script to send hex commands to the BLE-TCP-Brdige.

Usage:
    python ble-tcp-bridge-client.py [-c <HEX_COMMAND>] [-h <HOST>] [-p <PORT>] [-r <0|N>]

Arguments:
    -c, --command   (Optional) Hex command to send (e.g., "0101" for two bytes).
    -s, --server    (Optional) Server name (default: 127.0.0.1).
    -p, --port      (Optional) Server port (default: 58001).
    -r, --response  (Optional) Get bridge response(s), e.g. 5 to get 5 responses (default: 0)

Examples:
    python ble-bridge-client.py -c 0101
    python ble-bridge-client.py -c AA55FF -s 192.168.1.100 -p 60000

Notes:
    - The command (-c) must be at least **2 hex characters** (1 byte).
    - Ensure the BLE-Bridge server is running before sending commands.
"""
import socket
import argparse

# Constants
# Change to the actual server IP if needed
TCP_HOST = "localhost"
TCP_PORT = 58001

def send_command(host, port, command, response):
    try:
        # Connect to the TCP server
        client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client.connect((TCP_HOST, TCP_PORT))
        print(f"Connected to {TCP_HOST}:{TCP_PORT}")

        # Check if command
        if command is not None and len(command) > 0:
            # Handle 'stop' command
            if command.lower() == "stop":
                client.sendall(b"stop")
                print("Sent exit command. Closing connection...")
                return
            else:
                # Convert hex string to bytes
                command_bytes = bytes.fromhex(command)
                client.sendall(command_bytes)
                print(f"Sent command: {command_bytes.hex()}")
                # If response requested, close connection immediate
                if response == 0:
                    client.close()

        # Get bridge response(s)
        if response > 0:
            # Wait for bridge data received
            for resp in range(response):
                data = client.recv(1024)
                if data:
                    print(f"Received data: {data.hex()}")

    except Exception as e:
        print(f"Error: {e}")
    finally:
        client.close()
        print("Connection closed.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="BLE-Bridge-Client - Send commands to BLE-TCP-Bridge.")
    parser.add_argument("-s", "--server", default=TCP_HOST, help="Server name (default: 127.0.0.1)")
    parser.add_argument("-p", "--port", type=int, default=TCP_PORT, help="Server port (default: 58001)")
    parser.add_argument("-c", "--command", type=str, help="HEX command to send (e.g., '0101') or 'stop' to shutdown the bridge.")
    parser.add_argument("-r", "--response", type=int, default=0, help="Get bridge response(s) (default: 0)")

    args = parser.parse_args()

    send_command(args.server, args.port, args.command, args.response)
