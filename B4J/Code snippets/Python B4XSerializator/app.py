from flask import Flask, Response
from B4XSerializator import B4XSerializator

app = Flask(__name__)


@app.route('/test', methods=['GET'])
def test_b4x_serializator():
    serializer = B4XSerializator()
    my_dict = {
        "key1": "value1",
        "key2": False,
        "testKey": 123,
        "nestedList": [1, 2, 3],
        "nestedDict": {"innerKey": "innerValue"},
        "byteData": b'\x00\x01\x02',
        "floatVal": 3.14,
        "longInt": 1234567890123456789,
        "shortInt": 12345,
        "byteInt": -128,
        "nullValue": None
    }
    bytes_data = serializer.convert_object_to_bytes(my_dict)

    # Return the bytes as a response
    return Response(bytes_data, content_type='application/octet-stream')


if __name__ == '__main__':
    app.run(debug=True)
