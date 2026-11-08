"""
jmc_motor_gui.py

Simple PySide6 GUI to control a PowerFunctions BLE motor.
"""

import sys
import asyncio
import threading

from bleak import BleakClient

from PySide6.QtWidgets import (
    QApplication,
    QWidget,
    QPushButton,
    QTextEdit,
    QVBoxLayout,
    QHBoxLayout,
)


# ---------------------------------------------------------------------
# BLE configuration
# ---------------------------------------------------------------------

ADDRESS = "80:F3:DA:4C:36:7A"
CHAR_UUID = "abcd1234-5678-1234-5678-1234567890ab"

FRAME_HEADER = 0x19
FRAME_FOOTER = 0x58

DEVICE_ADDRESS = 0x12
SERVO_CMD_ANGLE = 0x05

SERVO_ANGLE_OPEN = 0x5A  # DEC 90
SERVO_ANGLE_CLOSE = 0x87 # DEC 135

CMD_OPEN = bytes(
    [FRAME_HEADER, DEVICE_ADDRESS, SERVO_CMD_ANGLE, SERVO_ANGLE_OPEN, FRAME_FOOTER]
)

CMD_CLOSE = bytes(
    [FRAME_HEADER, DEVICE_ADDRESS, SERVO_CMD_ANGLE, SERVO_ANGLE_CLOSE, FRAME_FOOTER]
)


# ---------------------------------------------------------------------
# Utility
# ---------------------------------------------------------------------

def bytes_to_hex(data: bytes) -> str:
    """Convert bytes to readable hex string."""
    return " ".join(f"{b:02X}" for b in data)


# ---------------------------------------------------------------------
# BLE Worker
# ---------------------------------------------------------------------

class BLEWorker:

    """Background BLE worker running asyncio loop."""

    def __init__(self, log_callback):
        self.log = log_callback
        self.loop = asyncio.new_event_loop()
        self.client = BleakClient(ADDRESS)

        self.thread = threading.Thread(target=self.run_loop, daemon=True)
        self.thread.start()

        asyncio.run_coroutine_threadsafe(self.connect(), self.loop)

    def run_loop(self):
        """Run asyncio loop in background thread."""
        asyncio.set_event_loop(self.loop)
        self.loop.run_forever()

    async def connect(self):
        """Connect to BLE device."""
        self.log("Connecting...")

        await self.client.connect()

        if self.client.is_connected:
            self.log("Connected")

            await self.client.start_notify(
                CHAR_UUID,
                self.notification_handler
            )

    def notification_handler(self, sender, data):
        """Handle BLE notifications."""
        self.log(f"ACK RX: {bytes_to_hex(data)}")

    def send(self, cmd, label):
        """Send command to device."""
        asyncio.run_coroutine_threadsafe(
            self.send_async(cmd, label),
            self.loop
        )

    async def send_async(self, cmd, label):
        """Async command sender."""
        if not self.client.is_connected:
            self.log("Not connected")
            return

        self.log(f"TX {label}: {bytes_to_hex(cmd)}")

        await self.client.write_gatt_char(
            CHAR_UUID,
            cmd
        )


# ---------------------------------------------------------------------
# GUI
# ---------------------------------------------------------------------

class MotorWindow(QWidget):

    """Main GUI window."""

    def __init__(self):
        super().__init__()

        self.setWindowTitle("BLE GeekServo")

        # Log window
        self.log = QTextEdit()
        self.log.setReadOnly(True)

        # Buttons
        self.btn_open = QPushButton("Open")
        self.btn_close = QPushButton("Close")

        btn_layout = QHBoxLayout()
        btn_layout.addWidget(self.btn_open)
        btn_layout.addWidget(self.btn_close)

        layout = QVBoxLayout(self)
        layout.addLayout(btn_layout)
        layout.addWidget(self.log)

        # BLE worker
        self.ble = BLEWorker(self.log_message)

        # Button actions
        self.btn_open.clicked.connect(
            lambda: self.ble.send(CMD_OPEN, "OPEN")
        )

        self.btn_close.clicked.connect(
            lambda: self.ble.send(CMD_CLOSE, "CLOSE")
        )

    def log_message(self, msg):
        """Append message to log window."""
        self.log.append(msg)


# ---------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------

def main():
    """Application entry point."""

    app = QApplication(sys.argv)

    window = MotorWindow()
    window.resize(400, 250)
    window.show()

    sys.exit(app.exec())


if __name__ == "__main__":
    main()