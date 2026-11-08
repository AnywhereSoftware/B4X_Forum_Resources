

Reference:
lego.github.io/lego-ble-wireless-protocol-docs/index.html


General Format of LEGO BLE Messages

A LEGO® BLE message typically follows this format:

[0]  Length (excluding this byte)
[1]  Hub ID (usually 0x00)
[2]  Message Type
[3+] Payload...

Let’s decode the most relevant notifications:
✅ BLE_NewData=050082000A

Breakdown:

    05 → Length = 5 bytes (excluding this byte)

    00 → Hub ID

    82 → Message Type 0x82 = Port Output Command Feedback

    00 → Port ID (Port 0)

    0A → Feedback (0x0A = Command Completed)

➡️ Interpretation: The hub confirms that a command for Port 0 (motor) has completed successfully.
✅ BLE_NewData=0F0004000102000000000000000000

Breakdown:

    0F → 15 bytes following

    00 → Hub ID

    04 → Message Type 0x04 = Hub Properties

    00 → Property Type: Advertising Name?

    Not fully meaningful here — might be a port input notification instead.

Likely an Input Format Single notification with sensor data. The actual decoding depends on the port and mode settings.
✅ BLE_NewData=0500040100

Could be:

    05 → 5 bytes

    00 → Hub ID

    04 → Message Type (Hub Properties or Input Event)

    01 → Possibly Port ID 1

    00 → Some value or mode setting

✅ The longer ones:

    0F0004320117...

    0F00043B0115...

    0F00043C0114...

These seem to be port value updates (e.g., motor position, speed, tacho count, or sensor input values). You’ll typically get those after starting notifications on a port and enabling a mode (like speed, position, etc.).

They all start with:

    0F = 15 bytes

    00 = Hub ID

    04 = Message Type: probably Port Value Single (0x45) or Port Input Format Setup (0x41–0x44)

The actual decoding depends on which Mode each port is set to.
🧩 Summary
Message Type	Code	Description
0x01	Hub Properties	
0x04	Hub Actions / Port Input Format	
0x45	Port Value (single)	
0x82	Port Output Command Feedback

