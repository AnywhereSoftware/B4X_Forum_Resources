# Version 0.0.1
import zlib
import struct


class B4XSerializator:
    # Type indicators matching B4XSerializer
    T_NULL = 0
    T_STRING = 1
    T_SHORT = 2
    T_INT = 3
    T_LONG = 4
    T_FLOAT = 5
    T_DOUBLE = 6
    T_BOOLEAN = 7
    T_BYTE = 10
    T_CHAR = 14
    T_MAP = 20
    T_LIST = 21
    T_NSARRAY = 22
    T_NSDATA = 23
    T_TYPE = 24

    def __init__(self):
        self.tag = None

    def set_tag(self, tag):
        """
        Sets the Tag value. This is a placeholder that can be used to store additional data.
        """
        self.tag = tag

    def get_tag(self):
        """
        Gets the Tag value.
        """
        return self.tag

    def convert_object_to_bytes(self, obj):
        """
        Serializes the object to bytes using the B4X serialization format and compresses it.
        """
        serialized_data = self._serialize_object(obj)
        compressed_data = zlib.compress(serialized_data)
        return compressed_data

    def convert_bytes_to_object(self, bytes_data):
        """
        Decompresses the bytes and deserializes the object using the B4X serialization format.
        """
        decompressed_data = zlib.decompress(bytes_data)
        obj, _ = self._parse_b4j_object(decompressed_data, 0)
        return obj

    def _serialize_object(self, o):
        serialized_data = bytearray()
        if o is None:
            serialized_data.append(self.T_NULL)
        elif isinstance(o, str):
            serialized_data.append(self.T_STRING)
            o_bytes = o.encode('utf-8')
            serialized_data.extend(len(o_bytes).to_bytes(4, 'little'))
            serialized_data.extend(o_bytes)
        elif isinstance(o, bool):
            serialized_data.append(self.T_BOOLEAN)
            serialized_data.append(1 if o else 0)
        elif isinstance(o, int):
            # Decide between T_BYTE, T_SHORT, T_INT, T_LONG based on the value range
            if -128 <= o <= 127:
                serialized_data.append(self.T_BYTE)
                serialized_data.append(o & 0xFF)
            elif -32768 <= o <= 32767:
                serialized_data.append(self.T_SHORT)
                serialized_data.extend(o.to_bytes(2, 'little', signed=True))
            elif -2147483648 <= o <= 2147483647:
                serialized_data.append(self.T_INT)
                serialized_data.extend(o.to_bytes(4, 'little', signed=True))
            else:
                serialized_data.append(self.T_LONG)
                serialized_data.extend(o.to_bytes(8, 'little', signed=True))
        elif isinstance(o, float):
            # Use T_DOUBLE for floating-point numbers
            serialized_data.append(self.T_DOUBLE)
            serialized_data.extend(struct.pack('<d', o))  # Little-endian double
        elif isinstance(o, list):
            serialized_data.append(self.T_LIST)
            serialized_data.extend(len(o).to_bytes(4, 'little'))
            for item in o:
                serialized_data.extend(self._serialize_object(item))
        elif isinstance(o, dict):
            serialized_data.append(self.T_MAP)
            serialized_data.extend(len(o).to_bytes(4, 'little'))
            for key, value in o.items():
                serialized_data.extend(self._serialize_object(key))
                serialized_data.extend(self._serialize_object(value))
        elif isinstance(o, bytes):
            serialized_data.append(self.T_NSDATA)
            serialized_data.extend(len(o).to_bytes(4, 'little'))
            serialized_data.extend(o)
        else:
            raise ValueError(f"Unsupported data type: {type(o)}")
        return bytes(serialized_data)

    def _parse_b4j_object(self, data, i):
        t = data[i]
        i += 1
        if t == self.T_NULL:
            return None, i
        elif t == self.T_STRING:
            length = int.from_bytes(data[i:i + 4], 'little')
            i += 4
            s = data[i:i + length].decode('utf-8')
            i += length
            return s, i
        elif t == self.T_INT:
            val = int.from_bytes(data[i:i + 4], 'little', signed=True)
            i += 4
            return val, i
        elif t == self.T_LONG:
            val = int.from_bytes(data[i:i + 8], 'little', signed=True)
            i += 8
            return val, i
        elif t == self.T_SHORT:
            val = int.from_bytes(data[i:i + 2], 'little', signed=True)
            i += 2
            return val, i
        elif t == self.T_BYTE:
            val = int.from_bytes(data[i:i + 1], 'little', signed=True)
            i += 1
            return val, i
        elif t == self.T_DOUBLE:
            val = struct.unpack('<d', data[i:i + 8])[0]
            i += 8
            return val, i
        elif t == self.T_FLOAT:
            val = struct.unpack('<f', data[i:i + 4])[0]
            i += 4
            return val, i
        elif t == self.T_BOOLEAN:
            val = data[i] != 0
            i += 1
            return val, i
        elif t == self.T_MAP:
            length = int.from_bytes(data[i:i + 4], 'little')
            i += 4
            result = {}
            for _ in range(length):
                key, i = self._parse_b4j_object(data, i)
                value, i = self._parse_b4j_object(data, i)
                result[key] = value
            return result, i
        elif t == self.T_LIST:
            length = int.from_bytes(data[i:i + 4], 'little')
            i += 4
            result = []
            for _ in range(length):
                item, i = self._parse_b4j_object(data, i)
                result.append(item)
            return result, i
        elif t == self.T_NSDATA:
            length = int.from_bytes(data[i:i + 4], 'little')
            i += 4
            val = data[i:i + length]
            i += length
            return val, i
        else:
            raise ValueError(f"Unsupported type indicator: {t}")
