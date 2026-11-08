"""
A module to access Mobile Devices from Windows via USB connection.
Implements access to basic functions of the Windows WPD API

Author:  Heribert Füchtenhans

Version: 2025.4.4

For examples please look into the examples directory.

All functions through IOError when a communication fails.

Requirements:
    - OS
        - Windows 10
        - Windows 11
    - Python modules
        - comtypes

The module contains the following functions:

- 'get_portable_devices' Get a list (instances of PortableDevice) of all connected portable devices.
- 'get_content_from_device_path' - Get the content (files, dirs) of a path as instances of
    PortableDeviceContent
- 'walk' - Iterates ower all files in a tree.
- 'makedirs' - Creates the directories on the MTP device if they don't exist.

The module contains the following classes:

- 'PortableDevice' - Class for one portable device found connected
- 'PortableDeviceContent' - Class for one file, directory or storage

Information to the filenames used in MTP:
- The filename consists of the following part:
    devicename/storagename/foldername/....
- The devicename can be found in PortableDevice.devicename
- The storagename is in content returned by PortableDevice.get_content
    It's the the name attribute
- Every PortableDeviceContent has an attribute 'full_filename' that contains the whole
    path of that content

Examples:
    >>> import mtp.win_access
    >>> devs = mtp.win_access.get_portable_devices()
    >>> len(devs) >= 1
    True
    >>> str(devs[0])[:33]
    'PortableDevice: PLEGAR1791402808 '
    >>> devs[0].close()
"""

import ctypes
import datetime
import io
import os
import os.path
from typing import Any, IO, Callable, Generator, List, Optional, Tuple
import contextlib
import comtypes  # type: ignore # pylint: disable=import-error
import comtypes.client  # type: ignore # pylint: disable=import-error
import comtypes.automation  # type: ignore # pylint: disable=import-error

gen_dir = os.path.join(os.path.dirname(__file__), "comtype_gen_win_wpd")
comtypes.client.gen_dir = gen_dir

try:
    from .comtype_gen_win_wpd import PortableDeviceApiLib as port
    from .comtype_gen_win_wpd import PortableDeviceTypesLib as types
except ImportError:
    # When doing doctest relative imports don't work and create ImportError
    # So do it with absolute imports
    from comtype_gen_win_wpd import PortableDeviceApiLib as port
    from comtype_gen_win_wpd import PortableDeviceTypesLib as types

# ComType Verweise anlegen
WPD_RESOURCE_DEFAULT = comtypes.pointer(
    port._tagpropertykey()  # pylint: disable=no-member, protected-access # type: ignore
)
WPD_RESOURCE_DEFAULT.contents.fmtid = comtypes.GUID("{E81E79BE-34F0-41BF-B53F-F1A06AE87842}")
WPD_RESOURCE_DEFAULT.contents.pid = 0

# ---------
WPD_OBJECT_NAME = comtypes.pointer(port._tagpropertykey())  # pylint: disable=no-member, protected-access # type: ignore
WPD_OBJECT_NAME.contents.fmtid = comtypes.GUID("{EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C}")
WPD_OBJECT_NAME.contents.pid = 4

# ---------
WPD_STORAGE_CAPACITY = comtypes.pointer(
    port._tagpropertykey()  # pylint: disable=no-member, protected-access # type: ignore
)
WPD_STORAGE_CAPACITY.contents.fmtid = comtypes.GUID("{01A3057A-74D6-4E80-BEA7-DC4C212CE50A}")
WPD_STORAGE_CAPACITY.contents.pid = 4

# ---------
WPD_STORAGE_FREE_SPACE_IN_BYTES = comtypes.pointer(
    port._tagpropertykey()  # pylint: disable=no-member, protected-access # type: ignore
)
WPD_STORAGE_FREE_SPACE_IN_BYTES.contents.fmtid = comtypes.GUID("{01A3057A-74D6-4E80-BEA7-DC4C212CE50A}")
WPD_STORAGE_FREE_SPACE_IN_BYTES.contents.pid = 5

# ---------
WPD_DEVICE_SERIAL_NUMBER = comtypes.pointer(
    port._tagpropertykey()  # pylint: disable=no-member, protected-access # type: ignore
)
WPD_DEVICE_SERIAL_NUMBER.contents.fmtid = comtypes.GUID("{26D4979A-E643-4626-9E2B-736DC0C92FDC}")
WPD_DEVICE_SERIAL_NUMBER.contents.pid = 9
#  0x26D4979A, 0xE643, 0x4626, 0x9E, 0x2B, 0x73, 0x6D, 0xC0, 0xC9, 0x2F, 0xDC ,  9

# ---------
WPD_OBJECT_PARENT_ID = comtypes.pointer(
    port._tagpropertykey()  # pylint: disable=no-member, protected-access # type: ignore
)
WPD_OBJECT_PARENT_ID.contents.fmtid = comtypes.GUID("{EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C}")
WPD_OBJECT_PARENT_ID.contents.pid = 3

# ---------
WPD_OBJECT_CONTENT_TYPE = comtypes.pointer(
    port._tagpropertykey()  # pylint: disable=no-member, protected-access # type: ignore
)
WPD_OBJECT_CONTENT_TYPE.contents.fmtid = comtypes.GUID("{EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C}")
WPD_OBJECT_CONTENT_TYPE.contents.pid = 7


# ---------
WPD_OBJECT_SIZE = comtypes.pointer(port._tagpropertykey())  # pylint: disable=no-member, protected-access # type: ignore
WPD_OBJECT_SIZE.contents.fmtid = comtypes.GUID("{EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C}")
WPD_OBJECT_SIZE.contents.pid = 11

# ---------
WPD_OBJECT_ORIGINAL_FILE_NAME = comtypes.pointer(
    port._tagpropertykey()  # pylint: disable=no-member, protected-access # type: ignore
)
WPD_OBJECT_ORIGINAL_FILE_NAME.contents.fmtid = comtypes.GUID("{EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C}")
WPD_OBJECT_ORIGINAL_FILE_NAME.contents.pid = 12

# ---------
WPD_OBJECT_DATE_CREATED = comtypes.pointer(
    port._tagpropertykey()  # pylint: disable=no-member, protected-access # type: ignore
)
WPD_OBJECT_DATE_CREATED.contents.fmtid = comtypes.GUID("{ef6b490d-5cd8-437a-affc-da8b60ee4a3c}")
WPD_OBJECT_DATE_CREATED.contents.pid = 18

# ---------
WPD_OBJECT_DATE_MODIFIED = comtypes.pointer(
    port._tagpropertykey()  # pylint: disable=no-member, protected-access # type: ignore
)
WPD_OBJECT_DATE_MODIFIED.contents.fmtid = comtypes.GUID("{EF6B490D-5CD8-437A-AFFC-DA8B60EE4A3C}")
WPD_OBJECT_DATE_MODIFIED.contents.pid = 19

# ----------
WPD_CONTENT_TYPE_FOLDER_GUID = comtypes.GUID("{27E2E392-A111-48E0-AB0C-E17705A05F85}")


# Constants for the type entries returned bei PortableDeviceContent.get_properties
WPD_CONTENT_TYPE_UNDEFINED = -1
WPD_CONTENT_TYPE_STORAGE = 0
WPD_CONTENT_TYPE_DIRECTORY = 1
WPD_CONTENT_TYPE_FILE = 2
WPD_CONTENT_TYPE_DEVICE = 3

# Constants for delete
WPD_DELETE_NO_RECURSION = 0
WPD_DELETE_WITH_RECURSION = 1

# Module variables
DEVICE_MANAGER: Optional[Any] = None


# -------------------------------------------------------------------------------------------------
class PortableDeviceContent:  # pylint: disable=too-many-instance-attributes
    """Class for one file, directory or storage with it's properties.
    This instances of this class are created intern, please only use the methods and attributes

    Methods:
        get_children: Get the children of this content (files and directories)
        get_child: Returns a PortableDeviceContent for one child whos name is known.
        get_path: Returns a PortableDeviceContent for a child who's path in the tree is known.
        create_content: Creates an empty directory content in this content.
        upload_file: Upload of a file to MTP device.
        download_file: Download a file from MTP device.
        remove: Deletes the current directory or file.

    Attributes:
        name: Directory-/Filename of this content
        fullname: The full path name
        date_modified: The file modification date
        size: The size of the file in bytes
        content_type: Type of the entry. One of the WPD_CONTENT_TYPE_ constants:
        
            - WPD_CONTENT_TYPE_UNDEFINED = -1
            - WPD_CONTENT_TYPE_STORAGE = 0
            - WPD_CONTENT_TYPE_DIRECTORY = 1
            - WPD_CONTENT_TYPE_FILE = 2
            - WPD_CONTENT_TYPE_DEVICE = 3

    Exceptions:
        IOError: If something went wrong
    """

    # class variable
    _properties_to_read: types.PortableDeviceKeyCollection | None = None  # pylint: disable=no-member # type: ignore

    _CoTaskMemFree = ctypes.windll.ole32.CoTaskMemFree  # type: ignore
    _CoTaskMemFree.restype = None
    _CoTaskMemFree.argtypes = [ctypes.c_void_p]

    def __init__(
        self,
        object_id: Any,
        content: "PortableDeviceContent",
        device: "PortableDevice",
        properties: Any | None = None,
        parent_path: str = "",
    ) -> None:
        """Instance constructor"""

        self._object_id = object_id
        self._content: "PortableDeviceContent" = content
        self._parent_path = parent_path
        self.name: str = ""
        self._plain_name: str = ""
        self.content_type: int = WPD_CONTENT_TYPE_UNDEFINED
        self.full_filename: str = ""
        self.size: int = -1
        self.date_modified: datetime.datetime = datetime.datetime.now()
        self._serialnumber: str = ""
        self._port_device = device
        self._properties = properties or content.properties()  # type: ignore
        if PortableDeviceContent._properties_to_read is None:
            # We haven't set the properties wie will read, so do it now
            PortableDeviceContent._properties_to_read = comtypes.client.CreateObject(
                types.PortableDeviceKeyCollection,  # pylint: disable=no-member, protected-access # type: ignore
                clsctx=comtypes.CLSCTX_INPROC_SERVER,  # pylint: disable=no-member, protected-access
                interface=port.IPortableDeviceKeyCollection,  # pylint: disable=no-member, protected-access # type: ignore
            )
            PortableDeviceContent._properties_to_read.Add(WPD_OBJECT_NAME)  # type: ignore
            PortableDeviceContent._properties_to_read.Add(WPD_OBJECT_ORIGINAL_FILE_NAME)  # type: ignore
            PortableDeviceContent._properties_to_read.Add(WPD_OBJECT_CONTENT_TYPE)  # type: ignore
            PortableDeviceContent._properties_to_read.Add(WPD_OBJECT_SIZE)  # type: ignore
            PortableDeviceContent._properties_to_read.Add(WPD_OBJECT_DATE_MODIFIED)  # type: ignore
            PortableDeviceContent._properties_to_read.Add(WPD_DEVICE_SERIAL_NUMBER)  # type: ignore
        self._get_properties()

    def _get_properties(
        self,
    ) -> None:
        """Sets the properties of this content."""
        propvalues = self._properties.GetValues(  # type: ignore
            self._object_id, PortableDeviceContent._properties_to_read
        )
        self.content_type = WPD_CONTENT_TYPE_UNDEFINED
        try:
            self._plain_name = str(propvalues.GetStringValue(WPD_OBJECT_NAME))  # type: ignore
        except comtypes.COMError:
            self.content_type = WPD_CONTENT_TYPE_DIRECTORY
            self.name = self._plain_name = ""
        try:
            self.name = self._plain_name = str(propvalues.GetStringValue(WPD_OBJECT_ORIGINAL_FILE_NAME))  # type: ignore
        except comtypes.COMError:
            self.name = self._plain_name
        content_id = str(propvalues.GetGuidValue(WPD_OBJECT_CONTENT_TYPE))  # type: ignore
        if content_id in {
            "{23F05BBC-15DE-4C2A-A55B-A9AF5CE412EF}",
            "{99ED0160-17FF-4C44-9D98-1D7A6F941921}",
        }:
            # It's a storage
            with contextlib.suppress(comtypes.COMError):
                self._serialnumber = str(propvalues.GetStringValue(WPD_DEVICE_SERIAL_NUMBER))  # type: ignore
            self.content_type = WPD_CONTENT_TYPE_STORAGE
        else:
            if content_id == "{27E2E392-A111-48E0-AB0C-E17705A05F85}":
                self.content_type = WPD_CONTENT_TYPE_DIRECTORY
            else:
                self.content_type = WPD_CONTENT_TYPE_FILE
            self.size = int(propvalues.GetUnsignedLargeIntegerValue(WPD_OBJECT_SIZE))  # type: ignore
            filetime = float(propvalues.GetValue(WPD_OBJECT_DATE_MODIFIED).data.date)  # type: ignore
            filedate = abs(int(filetime))
            days_since_1970 = filedate - (datetime.datetime(1970, 1, 1) - datetime.datetime(1899, 12, 30)).days
            hours = (filetime - int(filetime)) * 24
            minutes = (hours - int(hours)) * 60
            seconds = (minutes - int(minutes)) * 60
            milliseconds = round((seconds - int(seconds)) * 1000)
            self.date_modified = datetime.datetime(1970, 1, 1) + datetime.timedelta(
                days=days_since_1970,
                hours=int(hours),
                minutes=int(minutes),
                seconds=int(seconds),
                milliseconds=milliseconds,
            )
        propvalues.Clear()  # type: ignore
        self.full_filename = os.path.join(self._parent_path, self._plain_name)

    def get_children(self) -> Generator["PortableDeviceContent", None, None]:
        """Get the child items (dirs and files) of a folder.

        Returns:
            A Generator of PortableDeviceContent instances each representing a child entry.

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.win_access
            >>> dev = mtp.win_access.get_portable_devices()
            >>> stor = dev[0].get_content()[0]
            >>> str(list(stor.get_children())[0])
            'PortableDeviceContent Pictures (1)'
            >>> dev[0].close()
        """
        try:
            enumobject_ids = self._content.EnumObjects(  # type: ignore
                ctypes.c_ulong(0),
                self._object_id,
                ctypes.POINTER(port.IPortableDeviceValues)(),  # pylint: disable=no-member # type: ignore
            )
            while True:
                num_objects = ctypes.c_ulong(16)  # block size, so to speak
                object_id_array = (ctypes.c_wchar_p * num_objects.value)()
                num_fetched = ctypes.pointer(ctypes.c_ulong(0))
                # be sure to change the IEnumPortableDeviceobject_ids 'Next'
                # function in the generated code to have object_ids as inout
                enumobject_ids.Next(  # type: ignore
                    num_objects,
                    ctypes.cast(object_id_array, ctypes.POINTER(ctypes.c_wchar_p)),
                    num_fetched,
                )
                if num_fetched.contents.value == 0:
                    break
                for index in range(num_fetched.contents.value):
                    curobject_id = object_id_array[index]
                    value = PortableDeviceContent(curobject_id, self._content, self._port_device, self._properties, self.full_filename)  # type: ignore
                    # Free memory
                    address = ctypes.addressof(object_id_array) + ctypes.sizeof(ctypes.c_wchar_p) * index
                    ptr = ctypes.pointer(ctypes.c_wchar_p.from_address(address))
                    ctypes.windll.ole32.CoTaskMemFree(ptr.contents)  # type: ignore
                    yield value
        except comtypes.COMError as err:
            raise IOError(f"Error getting child item from '{self.full_filename}': {err.args[1]}")

    def get_child(self, name: str) -> "PortableDeviceContent | None":
        """Returns a PortableDeviceContent for one child whos name is known.
        The search is case sensitive.

        Parameters:
            name: The name of the file or directory to search

        Returns:
            The PortableDeviceContent instance of the child or None if the child could not be found.

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.win_access
            >>> dev = mtp.win_access.get_portable_devices()
            >>> stor = dev[0].get_content()[0]
            >>> str(list(stor.get_children())[0])
            'PortableDeviceContent Pictures (1)'
            >>> dev[0].close()
        """
        matches = [c for c in self.get_children() if c.name == name]
        return matches[0] if matches else None

    def get_path(self, path: str) -> Optional["PortableDeviceContent"]:
        """Returns a PortableDeviceContent for a child who's path in the tree is known.
        The path can be fully qualified or starting from the current content.

        Parameters:
            path: The pathname to the child.

        Returns:
            The PortableDeviceContent instance of the child or None if the child could not be found.

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.win_access
            >>> dev = mtp.win_access.get_portable_devices()
            >>> stor = dev[0].get_content()[0]
            >>> str(stor.get_path(f"{stor.full_filename}/DCIM"))
            'PortableDeviceContent DCIM (1)'
            >>> str(stor.get_path(f"DCIM"))
            'PortableDeviceContent DCIM (1)'
            >>> dev[0].close()
        """
        name = path.replace("/", os.path.sep)
        start = name.split(os.sep, 1)[0]
        if start == self._port_device.devicename:
            return get_content_from_device_path(self._port_device, name)
        if start == self.name:
            name = name.split(os.sep, 1)[1]
        cur: Optional["PortableDeviceContent"] = self
        for part in name.split(os.path.sep):
            if not cur:
                return None
            cur = cur.get_child(part)
        return cur

    def __repr__(self) -> str:
        """String representation"""
        return f"PortableDeviceContent {self.name} ({self.content_type})"

    def create_content(self, dirname: str) -> "PortableDeviceContent":
        """Creates an empty directory content in this content.

        Parameters:
            dirname: Name of the directory that shall be created

        Returns:
            PortableDeviceContent for the new directory

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.win_access
            >>> dev = mtp.win_access.get_portable_devices()
            >>> stor = dev[0].get_content()[0]
            >>> mycont = stor.get_path(f"{stor.full_filename}/MyMusic")
            >>> if mycont: _ = mycont.remove()
            >>> cont = stor.create_content("MyMusic")
            >>> cont.full_filename
            'Nokia 6_Nokia 6_PLEGAR1791402808\\\\Interner gemeinsamer Speicher\\\\MyMusic'
            >>> dev[0].close()
        """
        pdc = None
        try:
            object_properties = comtypes.client.CreateObject(
                types.PortableDeviceValues,  # pylint: disable=no-member # type: ignore
                clsctx=comtypes.CLSCTX_INPROC_SERVER,
                interface=port.IPortableDeviceValues,  # pylint: disable=no-member # type: ignore
            )
            object_properties.SetStringValue(WPD_OBJECT_PARENT_ID, self._object_id)  # type: ignore
            object_properties.SetStringValue(WPD_OBJECT_NAME, dirname)  # type: ignore
            object_properties.SetStringValue(WPD_OBJECT_ORIGINAL_FILE_NAME, dirname)  # type: ignore
            object_properties.SetGuidValue(WPD_OBJECT_CONTENT_TYPE, WPD_CONTENT_TYPE_FOLDER_GUID)  # type: ignore
            self._content.CreateObjectWithPropertiesOnly(  # type: ignore
                object_properties, ctypes.POINTER(ctypes.c_wchar_p)()
            )
            pdc = self.get_child(dirname)
        except comtypes.COMError as err:
            raise IOError(f"Error creating directory '{dirname}': {err.args[1]}")
        if pdc is None:
            raise IOError(f"Error creating directory '{dirname}': Could not get conent of new directory")
        return pdc

    def _upload_stream(self, filename: str, inputstream: io.FileIO, stream_len: int) -> None:
        """Upload a steam to a file on the MTP device.

        Parameters:
            filename: Name of the new file on the MTP device
            inputstream: open python file
            stream_len: length of the file to upload
        """
        try:
            object_properties = comtypes.client.CreateObject(
                types.PortableDeviceValues,  # pylint: disable=no-member # type: ignore
                clsctx=comtypes.CLSCTX_INPROC_SERVER,
                interface=port.IPortableDeviceValues,  # pylint: disable=no-member # type: ignore
            )
            object_properties.SetStringValue(WPD_OBJECT_PARENT_ID, self._object_id)  # type: ignore
            object_properties.SetUnsignedLargeIntegerValue(WPD_OBJECT_SIZE, stream_len)  # type: ignore
            object_properties.SetStringValue(WPD_OBJECT_ORIGINAL_FILE_NAME, filename)  # type: ignore
            object_properties.SetStringValue(WPD_OBJECT_NAME, filename)  # type: ignore
            optimal_transfer_size_bytes = ctypes.pointer(ctypes.c_ulong(0))
            p_filestream = ctypes.POINTER(port.IStream)()  # pylint: disable=no-member # type: ignore
            # be sure to change the IPortableDeviceContent
            # 'CreateObjectWithPropertiesAndData' function in the generated code to
            # have IStream ppData as 'in','out'
            filestream, _, _ = self._content.CreateObjectWithPropertiesAndData(  # type: ignore
                object_properties,
                p_filestream,
                optimal_transfer_size_bytes,
                ctypes.POINTER(ctypes.c_wchar_p)(),
            )
            blocksize = optimal_transfer_size_bytes.contents.value
            while True:
                block = inputstream.read(blocksize)
                if len(block) <= 0:
                    break
                string_buf = ctypes.create_string_buffer(block)
                filestream.RemoteWrite(  # type: ignore
                    ctypes.cast(string_buf, ctypes.POINTER(ctypes.c_ubyte)),
                    len(block),
                )
            stgc_default = 0
            filestream.Commit(stgc_default)  # type: ignore
        except comtypes.COMError as err:
            raise IOError(f"Error storing stream '{filename}': {err.args[1]}")

    def upload_file(self, filename: str, inputfilename: str) -> None:
        """Upload of a file to MTP device.

        Parameters:
            filename: Name of the new file on the MTP device
            inputfilename: Name of the file that shall be uploaded

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.win_access
            >>> dev = mtp.win_access.get_portable_devices()
            >>> stor = dev[0].get_content()[0]
            >>> mycont = stor.get_path("DCIM/Camera/test.jpg")
            >>> if mycont: _ = mycont.remove()
            >>> cont = stor.get_path("DCIM/Camera")
            >>> name = './tests/pic.jpg'
            >>> cont.upload_file("test.jpg", name)
            >>> stor = dev[0].get_content()[0]
            >>> mycont = stor.get_path("DCIM/Camera/test.jpg")
            >>> str(mycont)
            'PortableDeviceContent test.jpg (2)'
            >>> dev[0].close()
        """
        try:
            length = os.path.getsize(inputfilename)
            # with open(inputfilename, "rb") as input_stream:
            with io.FileIO(inputfilename, "r") as input_stream:
                self._upload_stream(filename, input_stream, length)
        except comtypes.COMError as err:
            raise IOError(f"Error storing file '{filename}': {err.args[1]}")

    def _download_stream(self, outputstream: IO[bytes]) -> None:
        """Download a file from MTP device.
        The used ProtableDeviceContent instance must be a file!

        Parameters:
            outputstream: Open python file for writing
        """
        try:
            resources = self._content.Transfer()  # type: ignore
            stgm_read = ctypes.c_uint(0)
            optimal_transfer_size_bytes = ctypes.pointer(ctypes.c_ulong(0))
            p_filestream = ctypes.POINTER(port.IStream)()  # pylint: disable=no-member # type: ignore
            optimal_transfer_size_bytes, q_filestream = resources.GetStream(  # type: ignore
                self._object_id,
                WPD_RESOURCE_DEFAULT,
                stgm_read,
                optimal_transfer_size_bytes,
                p_filestream,
            )
            blocksize = int(optimal_transfer_size_bytes.contents.value)  # type: ignore
            filestream = q_filestream.value  # type: ignore
            #            buf = (ctypes.c_ubyte * blocksize)()
            # make sure all RemoteRead parameters are in
            while True:
                buf, length = filestream.RemoteRead(blocksize)  # type: ignore
                if length == 0:
                    break
                outputstream.write(bytearray(buf[:length]))  # type: ignore
        except comtypes.COMError as err:
            raise IOError(f"Error getting file': {err.args[1]}")

    def download_file(self, outputfilename: str) -> None:
        """Download of a file from MTP device
        The used ProtableDeviceContent instance must be a file!

        Parameters:
            outputfilename: Name of the file the MTP file shall be written to. Any existing
                            content will be replaced.

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.win_access
            >>> dev = mtp.win_access.get_portable_devices()
            >>> stor = dev[0].get_content()
            >>> cont = stor[0].get_path(f"{stor[0].full_filename}/DCIM/Camera/IMG_20241210_160830.jpg")
            >>> name = 'picture.jpg'
            >>> cont.download_file(name)
            >>> os.remove(name)
            >>> dev[0].close()
        """
        try:
            # with open(outputfilename, "wb") as output_stream:
            with io.FileIO(outputfilename, "w") as output_stream:
                self._download_stream(output_stream)
        except comtypes.COMError as err:
            raise IOError(f"Error getting file '{outputfilename}': {err.args[1]}")

    def remove(self) -> None:
        """Deletes the current directory or file.

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.win_access
            >>> dev = mtp.win_access.get_portable_devices()
            >>> stor = dev[0].get_content()[0]
            >>> mycont = stor.get_path("DCIM/Camera/test.jpg")
            >>> if mycont: _ = mycont.remove()
            >>> cont = stor.get_path("DCIM/Camera")
            >>> name = './tests/pic.jpg'
            >>> cont.upload_file("test.jpg", name)
            >>> mycont = stor.get_path("DCIM/Camera/test.jpg")
            >>> mycont.remove()
            >>> str(mycont)
            'PortableDeviceContent test.jpg (2)'
            >>> dev[0].close()
        """
        try:
            objects_to_delete = comtypes.client.CreateObject(
                types.PortableDevicePropVariantCollection,  # pylint: disable=no-member, protected-access # type: ignore
                clsctx=comtypes.CLSCTX_INPROC_SERVER,  # pylint: disable=no-member, protected-access
                interface=port.IPortableDevicePropVariantCollection,  # pylint: disable=no-member, protected-access # type: ignore
            )
            pvar = port.tag_inner_PROPVARIANT()  # pylint: disable=no-member # type: ignore
            pvar.vt = comtypes.automation.VT_LPWSTR
            pvar.data.pwszVal = ctypes.c_wchar_p(self._object_id)
            objects_to_delete.Add(pvar)  # type: ignore
            errors = comtypes.client.CreateObject(
                types.PortableDevicePropVariantCollection,  # pylint: disable=no-member, protected-access # type: ignore
                clsctx=comtypes.CLSCTX_INPROC_SERVER,  # pylint: disable=no-member, protected-access
                interface=port.IPortableDevicePropVariantCollection,  # pylint: disable=no-member, protected-access # type: ignore
            )
            result = self._content.Delete(WPD_DELETE_WITH_RECURSION, objects_to_delete, ctypes.pointer(errors))  # type: ignore
            if result != 0:
                raise IOError(f"Error deleting directory/file '{self.full_filename}': {result}")
        except comtypes.COMError as err:
            raise IOError(f"Error deleting directory/file '{self.full_filename}': {err.args[1]}")


# -------------------------------------------------------------------------------------------------


class PortableDevice:
    """Class with the infos for a connected portable device.
    This instances of this class are created intern, please only use the methods and attributes

    Methods:
        close: Must be called when the device is no more needed. This frees the resources
        get_content: Get the content (Storages) of the device

    Attributes:
        name: Name of the MTP device
        description: Description for the device
        serialnumber: Serialnumber of the device
        devicename: The full name of the device. Use it when building pathes

    Exceptions:
        IOError: If something went wrong
    """

    # Class variable
    _properties_to_read: types.PortableDeviceKeyCollection | None = None

    def __init__(self, p_id: str) -> None:
        """Init the class.

        Parameters:
            p_id: ID of the found device
        """
        self._p_id = p_id
        self._set_device()
        self.name, self.description = self._get_description()
        # Get the serialnumber
        self._pdc = PortableDeviceContent(ctypes.c_wchar_p("DEVICE"), self._device.Content(), self, None)  # type: ignore
        self.serialnumber = self._pdc._serialnumber
        self.devicename = f"{self.name}_{self.description}_{self.serialnumber}"
        # Correct filename because during the initialisation it's only filled
        # with the name, not name and serialnumber
        self._pdc.full_filename = self.devicename

    def close(self) -> None:
        """Close the connection to the device. This must be called when the device is no more needed."""
        pass

    def _get_description(self) -> Tuple[str, str]:
        """Get the name and the description of the device. If no description is available
        name and description will be identical.

        Returns:
            A tuple with of name, description

        Examples:
            >>> import mtp.win_access
            >>> dev = mtp.win_access.get_portable_devices()
            >>> dev[0]._get_description()
            ('Nokia 6', 'Nokia 6')
        """
        if DEVICE_MANAGER is None:
            return "", ""
        name_len = ctypes.pointer(ctypes.c_ulong(0))
        DEVICE_MANAGER.GetDeviceDescription(self._p_id, ctypes.POINTER(ctypes.c_ushort)(), name_len)
        name = ctypes.create_unicode_buffer(name_len.contents.value)
        DEVICE_MANAGER.GetDeviceDescription(
            self._p_id,
            ctypes.cast(name, ctypes.POINTER(ctypes.c_ushort)),
            name_len,
        )
        self._desc = name.value
        try:
            DEVICE_MANAGER.GetDeviceFriendlyName(self._p_id, ctypes.POINTER(ctypes.c_ushort)(), name_len)
            name = ctypes.create_unicode_buffer(name_len.contents.value)
            DEVICE_MANAGER.GetDeviceFriendlyName(
                self._p_id,
                ctypes.cast(name, ctypes.POINTER(ctypes.c_ushort)),
                name_len,
            )
            self._name = name.value
        except comtypes.COMError:
            self._name = self._desc
        return self._name, self._desc

    def _set_device(self):
        """Open a device and sets self._device"""
        client_information = comtypes.client.CreateObject(
            types.PortableDeviceValues,  # pylint: disable=no-member  # type: ignore
            clsctx=comtypes.CLSCTX_INPROC_SERVER,
            interface=port.IPortableDeviceValues,  # pylint: disable=no-member  # type: ignore
        )
        self._device = comtypes.client.CreateObject(
            port.PortableDevice,  # pylint: disable=no-member  # type: ignore
            clsctx=comtypes.CLSCTX_INPROC_SERVER,
            interface=port.IPortableDevice,  # pylint: disable=no-member  # type: ignore
        )
        if self._device is not None:  # type: ignore
            self._device.Open(self._p_id, client_information)  # type: ignore

    def get_content(self) -> List[PortableDeviceContent]:
        """Get the content of a device, the storages

        Returns:
            A list of instances of PortableDeviceContent, one for each storage

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.win_access
            >>> dev = mtp.win_access.get_portable_devices()
            >>> stor = dev[0].get_content()
            >>> len(stor)
            2
            >>> str(stor[0])
            'PortableDeviceContent Interner gemeinsamer Speicher (0)'
            >>> dev[0].close()
        """
        return list(self._pdc.get_children())

    def __repr__(self) -> str:
        return f"PortableDevice: {self.serialnumber} ({self.name})"


# -------------------------------------------------------------------------------------------------
# Globale functions


def get_portable_devices() -> list[PortableDevice]:
    """Get all attached portable devices.

    Returns:
        A list of PortableDevice one for each found MTP device. The list is empty if no device
            was found.

    Exceptions:
        IOError: If something went wrong

    Examples:
        >>> import mtp.win_access
        >>> devs = mtp.win_access.get_portable_devices()
        >>> len(devs) == 1
        True
    """
    global DEVICE_MANAGER  # pylint: disable=global-statement

    try:
        if DEVICE_MANAGER is None:
            comtypes.CoInitialize()
            DEVICE_MANAGER = comtypes.client.CreateObject(  # type: ignore
                port.PortableDeviceManager,  # pylint: disable=no-member  # type: ignore
                clsctx=comtypes.CLSCTX_INPROC_SERVER,
                interface=port.IPortableDeviceManager,  # pylint: disable=no-member  # type: ignore
            )
        if DEVICE_MANAGER is None:
            raise IOError("Error initialising Windows PortableDeviceManager")
        pnp_device_id_count = ctypes.pointer(ctypes.c_ulong(0))
        DEVICE_MANAGER.GetDevices(ctypes.POINTER(ctypes.c_wchar_p)(), pnp_device_id_count)
        if pnp_device_id_count.contents.value == 0:
            return []
        pnp_device_ids = (ctypes.c_wchar_p * pnp_device_id_count.contents.value)()
        DEVICE_MANAGER.GetDevices(  # pylint: disable=no-member  # type: ignore
            ctypes.cast(pnp_device_ids, ctypes.POINTER(ctypes.c_wchar_p)),
            pnp_device_id_count,
        )
        return [PortableDevice(cur_id) for cur_id in pnp_device_ids if cur_id is not None]
    except comtypes.COMError as err:
        raise IOError(f"Error getting list of devices: {err.args[1]}")


def get_content_from_device_path(dev: PortableDevice, path: str) -> PortableDeviceContent | None:
    """Get the content of a path.

    Parameters:
        dev: The instance of PortableDevice where the path is searched
        path: The pathname of the file or directory

    Returns:
        An instance of PortableDeviceContent if the path is an existing file or directory
            else None is returned.

    Exceptions:
        IOError: If something went wrong

    Examples:
        >>> import mtp.win_access
        >>> dev = mtp.win_access.get_portable_devices()
        >>> n = "Nokia 6_Nokia 6_PLEGAR1791402808/Interner gemeinsamer Speicher/DCIM/Camera"
        >>> cont = mtp.win_access.get_content_from_device_path(dev[0], n)
        >>> str(cont)
        'PortableDeviceContent Camera (1)'
        >>> dev[0].close()
    """
    path = path.replace("\\", os.path.sep).replace("/", os.path.sep)
    path_parts = path.split(os.path.sep)
    if len(path_parts) < 2:
        raise IOError("get_content_from_device_path needs a devicename and a storage as paramter")
    if path_parts[0] == dev.devicename:
        try:
            cont: PortableDeviceContent | None = None
            for entry in dev.get_content():
                if entry.name == path_parts[1]:
                    cont = entry
                    break
            if cont is None:
                return None
            for part in path_parts[2:]:
                cont = cont.get_child(part)
                if cont is None:
                    return None
            return cont
        except comtypes.COMError as err:
            raise IOError(f"Error reading directory '{path}': {err.args[1]}")
    return None

# ->  Generator[
#    tuple[str, list[PortableDeviceContent], list[PortableDeviceContent]],
#    ]
def walk(
    dev: PortableDevice,
    path: str,
    callback: Optional[Callable[[str], bool]] = None,
    error_callback: Optional[Callable[[str], bool]] = None,
):
    """Iterates ower all files in a tree just like os.walk

    Parameters:
        dev: Portable device to iterate in
        path: path from witch to iterate
        callback: when given, a function that takes one argument (the selected file) and returns
                a boolean. If the returned value is false, walk will cancel an return empty
                list.
                the callback is usefull to show for example a progress because reading thousands
                of file from one MTP directory lasts very long.
        error_callback: when given, a function that takes one argument (the errormessage) and returns
                a boolean. If the returned value is false, walk will cancel and return empty
                list.

    Returns:
        A tuple with this content:
            A string with the root directory
            A list of PortableDeviceContent for the directories  in the directory
            A list of PortableDeviceContent for the files in the directory

    Exceptions:
        IOError: If something went wrong

    Examples:
        >>> import mtp.win_access
        >>> dev = mtp.win_access.get_portable_devices()
        >>> n = "Nokia 6_Nokia 6_PLEGAR1791402808/Interner gemeinsamer Speicher/DCIM/Camera"
        >>> for r, d, f in mtp.win_access.walk(dev[0], n):
        ...     for f1 in f:
        ...             print(f1.name)
        ...
        IMG_20241210_160830.jpg
        IMG_20241210_160833.jpg
        IMG_20241210_161150.jpg
        test.jpg
        >>> dev[0].close()
    """
    if not (cont := get_content_from_device_path(dev, path)):
        return
    cont.full_filename = path
    walk_cont: list[PortableDeviceContent] = [cont]
    while walk_cont:
        cont = walk_cont[0]
        del walk_cont[0]
        directories: list[PortableDeviceContent] = []
        files: list[PortableDeviceContent] = []
        try:
            for child in cont.get_children():
                if child.content_type in [
                    WPD_CONTENT_TYPE_STORAGE,
                    WPD_CONTENT_TYPE_DIRECTORY,
                ]:
                    # child.full_filename = os.path.join(cont.full_filename, name)
                    directories.append(child)
                elif child.content_type == WPD_CONTENT_TYPE_FILE:
                    # child.full_filename = os.path.join(cont.full_filename, name)
                    files.append(child)
                if callback and not callback(child.full_filename):
                    directories = []
                    files = []
                    return
            yield cont.full_filename, sorted(directories, key=lambda ent: ent.full_filename), sorted(
                files, key=lambda ent: ent.full_filename
            )
        except Exception as err:
            if error_callback is not None:
                if not error_callback(str(err)):
                    directories = []
                    files = []
                    return
        walk_cont.extend(directories)


def makedirs(dev: PortableDevice, path: str) -> PortableDeviceContent:
    """Creates the directories in path on the MTP device if they don't exist.

    Parameters:
        dev: Portable device to create the dirs on
        path: pathname of the dir to create. Any directories in path that don't exist
            will be created automatically.

    Returns:
        A PortableDeviceContent instance for the last directory in path.
            
    Exceptions:
        IOError: If something went wrong

    Examples:
        >>> import mtp.win_access
        >>> dev = mtp.win_access.get_portable_devices()
        >>> n = "Nokia 6_Nokia 6_PLEGAR1791402808/Interner gemeinsamer Speicher/DCIM/Camera/Test"
        >>> cont = mtp.win_access.makedirs(dev[0], n)
        >>> str(cont)
        'PortableDeviceContent Test (1)'
        >>> cont.remove()
        >>> dev[0].close()
    """
    try:
        content = dev.get_content()[0]
        path = path.replace("\\", os.path.sep).replace("/", os.path.sep)
        parts = path.split(os.path.sep)
        path_int = parts[0]
        for dirname in parts[1:]:
            if dirname == "":
                continue
            path_int = os.path.join(path_int, dirname)
            ziel_content = get_content_from_device_path(dev, path_int)
            if ziel_content is None:
                ziel_content = content.create_content(dirname)
            content = ziel_content
        return content
    except (comtypes.COMError, ImportError) as err:
        raise IOError(f"Error creating directory '{path}': {err.args[1]}")
