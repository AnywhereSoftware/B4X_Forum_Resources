"""
A module to access Mobile Devices from UNIX via USB connection.
After connecting to gnome desktop the devices can be found under:
/run/user/1000/gvfs/
in the normal file system. If on an other desktop environment, for example KDE,
then any process that uses libmtp will be killed and this module will access
libmtp.

Author:  Heribert Füchtenhans

Version: 2025.4.6

For examples please look into the examples directory.

All functions through IOError when a communication fails.

Requirements:
    - OS
        - Linux (GNOME and KDE)

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
    >>> import mtp.linux_access
    >>> devs = mtp.linux_access.get_portable_devices()
    >>> len(devs) >= 1
    True
    >>> str(devs[0])[:16]
    'PortableDevice: '
    >>> devs[0].close()

"""

# __pylint: disable=global-statement
# pyright: reportPrivateUsage=false

import ctypes
import datetime
import os
import shutil
import subprocess
from typing import Generator, List, Optional, Callable
import urllib.parse


import mtp.pylibmtp as pylibmtp


# Constants for the type entries returned bei PortableDeviceContent.get_properties
WPD_CONTENT_TYPE_UNDEFINED = -1
WPD_CONTENT_TYPE_STORAGE = 0
WPD_CONTENT_TYPE_DIRECTORY = 1
WPD_CONTENT_TYPE_FILE = 2
WPD_CONTENT_TYPE_DEVICE = 3

# Constants for delete
WPD_DELETE_NO_RECURSION = 0
WPD_DELETE_WITH_RECURSION = 1

_libmtp: pylibmtp.MTP | None = None
_gvfs_found = True
_gvfs_search_path = f"/run/user/{os.getuid()}/gvfs"  # path for gvfs miunted devices


# -------------------------------------------------------------------------------------------------
# Internal functions


def _init_libmtp() -> None:
    """Kills all prgs that use libmtp and connect to libmtp.
    The killed programm will be restarted when needed (tested with Gnome)"""
    global _libmtp, _gvfs_found
    _gvfs_found = False
    if _libmtp is not None:
        return
    # Kill any process that uses libmtp
    # Getting MTP devices from lsusb
    p = subprocess.Popen("lsusb", stdout=subprocess.PIPE, shell=True)
    (output, _) = p.communicate()
    if p.wait() != 0:
        raise IOError("Can't get output from lsusb!")
    for o in output.decode("ascii").split("\n"):
        if o.upper().endswith("(MTP MODE)"):
            bus = o[4:7]
            dev = o[15:18]
            # Get programm that uses libmtp return pid
            p = subprocess.Popen(f"fuser -k /dev/bus/usb/{bus}/{dev}", stdout=subprocess.PIPE, shell=True)
            (output, _) = p.communicate()
            if p.wait() != 0:
                if len(output) != 0:
                    raise IOError(f'Can\'t get programs that use libmtp: {output.decode("utf-8")}')
                else:
                    # No prg using ist
                    continue
    _libmtp = pylibmtp.MTP()


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

    def __init__(self, device: "str | ctypes._Pointer[pylibmtp.LIBMTP_RawDevice]") -> None: # type: ignore
        """Init the class.

        Parameters:
           device: Linux path to the device on Gnome or a libmtp device pointer on KDE
        """
        self.description = "Unknown"
        self.name = "Unknown"
        self.serialnumber = "Unknown"
        if type(device) == str:
            self._device = device
            if "=" in device:
                self._device_start_part, self.devicename = device.split("=", 1)
                self._device_start_part += "="
            else:
                self._device_start_part = ""
                self.devicename = device
            if "_" in self.devicename:
                parts = self.devicename.split("_")
                try:
                    self.name = parts[0]
                    self.description = parts[1]
                    self.serialnumber = parts[2]
                except IndexError:
                    pass
        else:
            # We do the killing of the processes that use libmtp just bevor
            # we use libmtp because so the chances that any other programm
            # greps libmtp back is very small
            if _libmtp is None:
                _init_libmtp()
            self._libmntp_device = pylibmtp.MTP(device) # type: ignore
            self._libmntp_device.connect()
            self.name = self._libmntp_device.get_devicename()
            self.description = self._libmntp_device.get_modelname()
            if self.name == "":
                self.name = self.description
            self.serialnumber = self._libmntp_device.get_serialnumber()
            self.devicename = f"{self.name}_{self.description}_{self.serialnumber}"

    def close(self) -> None:
        """Close the connection to the device. This must be called when the device is no more needed."""
        if not _gvfs_found:
            self._libmntp_device.disconnect()

    def get_content(self) -> List["PortableDeviceContent"]:
        """Get the content of a device, the storages

        Returns:
            A list of instances of PortableDeviceContent, one for each storage

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.linux_access
            >>> dev = mtp.linux_access.get_portable_devices()
            >>> stor = dev[0].get_content()
            >>> len(stor)
            2
            >>> str(stor[0])[:31]
            'PortableDeviceContent Interner '
            >>> dev[0].close()
        """
        ret_objs: list["PortableDeviceContent"] = []
        if _gvfs_found:
            try:
                for entry in os.listdir(os.path.join(_gvfs_search_path, self._device)):
                    full_name = os.path.join(self.devicename, entry)
                    ret_objs.append(PortableDeviceContent(self, full_name, 0, 0, WPD_CONTENT_TYPE_STORAGE))
            except OSError as err:
                raise IOError(f"Can't access {self.devicename}.") from err
        else:
            try:
                for entry in self._libmntp_device.get_storage():
                    full_name = os.path.join(self.devicename, entry[0])
                    pdc = PortableDeviceContent(
                        self,
                        full_name,
                        entry[1],
                        pylibmtp.LIBMTP_FILES_AND_FOLDERS_ROOT,
                        WPD_CONTENT_TYPE_STORAGE,
                    )
                    ret_objs.append(pdc)
            except pylibmtp.CommandFailed as err:
                raise IOError(f"Can't access {self.devicename}.") from err
        ret_objs.sort(key=lambda entry: entry.name)
        return ret_objs

    def __repr__(self) -> str:
        return f"PortableDevice: {self.serialnumber} ({self.name})"


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

    def __init__(
        self,
        port_device: PortableDevice,
        dirpath: str,
        storage_id: int,
        entry_id: int,
        typ: int,
        size: int = 0,
        date_modified: int = 0,
    ) -> None:
        """Instance constructor"""

        self._port_device = port_device
        self.full_filename = dirpath
        self.name = os.path.basename(dirpath)
        self.storage_id = storage_id
        self.entry_id = entry_id
        self.content_type = typ
        self.size = -1
        self.date_modified = datetime.datetime.now()
        if typ == WPD_CONTENT_TYPE_FILE:
            if _gvfs_found:
                try:
                    full_filename = os.path.join(_gvfs_search_path, port_device._device_start_part + dirpath)
                    self.size = os.path.getsize(full_filename)
                    self.date_modified = datetime.datetime.fromtimestamp(os.path.getmtime(full_filename))
                except OSError:
                    self.content_type = WPD_CONTENT_TYPE_STORAGE
            else:
                self.size = size
                self.date_modified = datetime.datetime.fromtimestamp(date_modified)
        elif typ == WPD_CONTENT_TYPE_DEVICE:
            self.full_filename = port_device.devicename

    def get_children(self) -> Generator["PortableDeviceContent", None, None]:
        """Get the child items (dirs and files) of a folder.

        Returns:
            A Generator of PortableDeviceContent instances each representing a child entry.

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.linux_access
            >>> dev = mtp.linux_access.get_portable_devices()
            >>> stor = dev[0].get_content()[0]
            >>> str(list(stor.get_children())[0])
            'PortableDeviceContent Pictures (1)'
            >>> dev[0].close()
        """
        if _gvfs_found:
            full_filename = os.path.join(_gvfs_search_path, self._port_device._device_start_part + self.full_filename)
            if not os.path.isdir(full_filename):
                return
            for entry in os.listdir(full_filename):
                full_name = os.path.join(self.full_filename, entry)
                yield PortableDeviceContent(
                    self._port_device,
                    full_name,
                    1,
                    0,
                    (
                        WPD_CONTENT_TYPE_DIRECTORY
                        if os.path.isdir(os.path.join(full_filename, entry))
                        else WPD_CONTENT_TYPE_FILE
                    ),
                )
        else:
            if _libmtp is None:
                return
            for entry in self._port_device._libmntp_device.get_files_and_folder(self.storage_id, self.entry_id):
                type = (
                    WPD_CONTENT_TYPE_DIRECTORY
                    if entry.filetype == pylibmtp.LIBMTP_Filetype["FOLDER"].value
                    else WPD_CONTENT_TYPE_FILE
                )
                yield PortableDeviceContent(
                    self._port_device,
                    os.path.join(self.full_filename, entry.filename.decode("utf-8")),
                    self.storage_id,
                    entry.item_id,
                    type,
                    entry.filesize,
                    entry.modificationdate,
                )

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
            >>> import mtp.linux_access
            >>> dev = mtp.linux_access.get_portable_devices()
            >>> stor = dev[0].get_content()[0]
            >>> str(stor.get_child("DCIM"))
            'PortableDeviceContent DCIM (1)'
            >>> dev[0].close()
        """
        if _gvfs_found:
            fullname = os.path.join(_gvfs_search_path, self._port_device._device_start_part + self.full_filename, name)
            if not os.path.exists(fullname):
                return None
            return PortableDeviceContent(
                self._port_device,
                os.path.join(self.full_filename, name),
                1,
                1,
                (WPD_CONTENT_TYPE_DIRECTORY if os.path.isdir(fullname) else WPD_CONTENT_TYPE_FILE),
            )
        else:
            if _libmtp is None:
                return
            for entry in self._port_device._libmntp_device.get_files_and_folder(self.storage_id, self.entry_id):
                entry_filename = entry.filename.decode("UTF-8")
                if entry_filename != name:
                    continue
                # Ok found, so do a direct return
                type = (
                    WPD_CONTENT_TYPE_DIRECTORY
                    if entry.filetype == pylibmtp.LIBMTP_Filetype["FOLDER"].value
                    else WPD_CONTENT_TYPE_FILE
                )
                return PortableDeviceContent(
                    self._port_device,
                    os.path.join(self.full_filename, entry_filename),
                    self.storage_id,
                    entry.item_id,
                    type,
                    entry.filesize,
                    entry.modificationdate,
                )
            return None

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
            >>> import mtp.linux_access
            >>> dev = mtp.linux_access.get_portable_devices()
            >>> stor = dev[0].get_content()[0]
            >>> str(stor.get_path(f"{stor.full_filename}/DCIM"))
            'PortableDeviceContent DCIM (1)'
            >>> str(stor.get_path(f"DCIM"))
            'PortableDeviceContent DCIM (1)'
            >>> dev[0].close()
        """
        path = path.replace("\\", os.path.sep)
        start = path.split(os.sep, 1)[0]
        if start == self._port_device.devicename:
            return get_content_from_device_path(self._port_device, path)
        if start == self.name:
            path = path.split(os.sep, 1)[1]
        # Difference between gvfs and libmtp
        if _gvfs_found:
            full_filename = os.path.join(
                _gvfs_search_path, self._port_device._device_start_part + self.full_filename, path
            )
            if not os.path.exists(full_filename):
                return None
            return PortableDeviceContent(
                self._port_device,
                os.path.join(self.full_filename, path),
                1,
                1,
                (WPD_CONTENT_TYPE_DIRECTORY if os.path.isdir(full_filename) else WPD_CONTENT_TYPE_FILE),
            )
        else:
            cur: Optional["PortableDeviceContent"] = self
            for part in path.split(os.path.sep):
                if not cur:
                    return None
                cur = cur.get_child(part)
            return cur

    def __repr__(self) -> str:
        """ """
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
            >>> import mtp.linux_access
            >>> dev = mtp.linux_access.get_portable_devices()
            >>> stor = dev[0].get_content()
            >>> mycont = stor[0].get_path(f"{stor[0].full_filename}/MyMusic")
            >>> if mycont: _ = mycont.remove()
            >>> cont = stor[0].create_content("MyMusic")
            >>> str(cont)
            'PortableDeviceContent MyMusic (1)'
            >>> dev[0].close()
        """
        fullname = os.path.join(self.full_filename, dirname)
        if _gvfs_found:
            full_filename = os.path.join(_gvfs_search_path, self._port_device._device_start_part + fullname)
            if os.path.exists(full_filename):
                raise IOError(f"Directory '{fullname}' allready exists")
            os.mkdir(full_filename)
            pdc = PortableDeviceContent(self._port_device, fullname, 0, 0, WPD_CONTENT_TYPE_DIRECTORY)
        else:
            try:
                id = self._port_device._libmntp_device.create_folder(dirname, self.entry_id, self.storage_id)
                pdc = PortableDeviceContent(
                    self._port_device, fullname, self.storage_id, id, WPD_CONTENT_TYPE_DIRECTORY
                )
            except Exception:
                raise IOError(f"Error creating directory '{fullname}'")
        return pdc

    def upload_file(self, filename: str, inputfilename: str) -> None:
        """Upload of a file to MTP device.

        Parameters:
            filename: Name of the new file on the MTP device
            inputfilename: Name of the file that shall be uploaded

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.linux_access
            >>> dev = mtp.linux_access.get_portable_devices()
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
        if _gvfs_found:
            full_filename = os.path.join(
                _gvfs_search_path,
                self._port_device._device_start_part + self.full_filename,
                filename,
            )
            try:
                shutil.copyfile(inputfilename, full_filename)
            except OSError:
                # Ok can't copy with shutil on older Gnomes (for example Zorin). si we use gio
                gio_full_filename = "mtp://" + full_filename.split("=", 1)[1]
                try:
                    _ = subprocess.check_output(
                        f'gio copy "{inputfilename}" "{gio_full_filename}"',
                        shell=True,
                        stderr=subprocess.STDOUT,
                    )
                except subprocess.CalledProcessError as err:
                    raise IOError(
                        f"Error copying file '{inputfilename}' to '{gio_full_filename}'"
                        f": {urllib.parse.unquote(err.output.decode('utf-8'))}"
                    ) from err
            # shutil.copy(inputfilename, full_filename)
        else:
            self._port_device._libmntp_device.send_file_from_file(
                inputfilename, filename, self.storage_id, self.entry_id
            )

    def download_file(self, outputfilename: str) -> None:
        """Download of a file from MTP device
        The used ProtableDeviceContent instance must be a file!

        Parameters:
            outputfilename: Name of the file the MTP file shall be written to. Any existing
                            content will be replaced.

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.linux_access
            >>> dev = mtp.linux_access.get_portable_devices()
            >>> stor = dev[0].get_content()
            >>> cont = stor[0].get_path(f"{stor[0].full_filename}/DCIM/Camera/IMG_20241210_160830.jpg")
            >>> name = 'picture.jpg'
            >>> cont.download_file(name)
            >>> os.remove(name)
            >>> dev[0].close()
        """
        if _gvfs_found:
            full_filename = os.path.join(_gvfs_search_path, self._port_device._device_start_part + self.full_filename)
            shutil.copy2(full_filename, outputfilename)
        else:
            self._port_device._libmntp_device.get_file_to_file(self.entry_id, outputfilename)

    def remove(self) -> None:
        """Deletes the current directory or file.

        Exceptions:
            IOError: If something went wrong

        Examples:
            >>> import mtp.linux_access
            >>> dev = mtp.linux_access.get_portable_devices()
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
        if _gvfs_found:
            full_name = os.path.join(_gvfs_search_path, self._port_device._device_start_part + self.full_filename)
            if not os.path.exists(full_name):
                return
            if self.content_type == WPD_CONTENT_TYPE_FILE:
                os.remove(full_name)
            else:
                shutil.rmtree(full_name)
        else:
            self._port_device._libmntp_device.delete_object(self.entry_id)


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
        >>> import mtp.linux_access
        >>> devs = mtp.linux_access.get_portable_devices()
        >>> len(devs) == 1
        True
        >>> devs[0].close()
    """
    global _gvfs_found
    devices: List[PortableDevice] = []
    if not os.path.exists(_gvfs_search_path):
        # We assume, we are not on a GNOME system with installed gvfs
        # So we try to use libmtp
        if _libmtp is None:
            _init_libmtp()
        for entry in _libmtp.detect_devices():  # type: ignore
            dev = PortableDevice(entry)
            # Device is not ready if we don't get a content
            if len(dev.get_content()) != 0:
                devices.append(dev)
    else:
        _gvfs_found = True
        for entry in os.scandir(_gvfs_search_path):
            dev = PortableDevice(entry.name)
            # Device is not ready if we don't get a content
            if len(dev.get_content()) != 0:
                devices.append(dev)
    return devices


def get_content_from_device_path(dev: PortableDevice, fpath: str) -> PortableDeviceContent | None:
    """Get the content of a path.

    Parameters:
        dev: The instance of PortableDevice where the path is searched
        fpath: The pathname of the file or directory

    Returns:
        An instance of PortableDeviceContent if the path is an existing file or directory
            else None is returned.

    Exceptions:
        IOError: If something went wrong

    Examples:
        >>> import mtp.linux_access
        >>> dev = mtp.linux_access.get_portable_devices()
        >>> if os.path.exists(_gvfs_search_path):
        ...    n = "Android_Android_PLEGAR1791402808/Interner gemeinsamer Speicher/DCIM/Camera"
        ... else:
        ...    n = "Nokia 6_Nokia 6_PLEGAR1791402808/Interner gemeinsamer Speicher/DCIM/Camera"
        >>> cont = mtp.linux_access.get_content_from_device_path(dev[0], n)
        >>> str(cont)
        'PortableDeviceContent Camera (1)'
        >>> dev[0].close()
    """
    fpath = fpath.replace("\\", os.path.sep)
    if fpath == dev.devicename:
        raise IOError("get_content_from_device_path needs a devicename and a storage as paramter")
    if _gvfs_found:
        full_fpath = os.path.join(_gvfs_search_path, dev._device_start_part + fpath)
        if not os.path.exists(full_fpath):
            return None
        content_type = WPD_CONTENT_TYPE_DIRECTORY if os.path.isdir(full_fpath) else WPD_CONTENT_TYPE_FILE
        return PortableDeviceContent(
            dev,
            fpath,
            1,
            1,
            content_type,
        )
    else:
        parts = fpath.split(os.sep)
        storname_to_search = os.path.join(parts[0], parts[1])
        found_stor = None
        for stor in dev.get_content():
            if stor.full_filename == storname_to_search:
                found_stor = stor
                break
        if found_stor is None:
            raise IOError(f"The storage {storname_to_search} could not be found")
        cont = found_stor
        for pp in parts[2:]:
            cont = cont.get_child(pp)
            if cont is None:
                return None
        return cont


def walk(
    dev: PortableDevice,
    path: str,
    callback: Optional[Callable[[str], bool]] = None,
    error_callback: Optional[Callable[[str], bool]] = None,
) -> Generator[
    tuple[str, list[PortableDeviceContent], list[PortableDeviceContent]],
    None,
    None
    ]:
    """Iterates ower all files in a tree just like os.walk

    Parameters:
        dev: Portable device to iterate in
        path: path from witch to iterate
        callback: When given, a function that takes one argument (the selected file) and returns
                a boolean. If the returned value is false, walk will cancel and return empty
                list. The callback is usefull to show for example a progress because reading thousands
                of file from one MTP directory lasts very long.
        error_callback: When given, a function that takes one argument (the errormessage) and returns
                a boolean. If the returned value is false, walk will cancel and return empty
                list.

    Returns:
        A tuple with this content:

            - A string with the root directory
            - A list of PortableDeviceContent for the directories  in the directory
            - A list of PortableDeviceContent for the files in the directory

    Exceptions:
        IOError: If something went wrong

    Examples:
        >>> import mtp.linux_access
        >>> dev = mtp.linux_access.get_portable_devices()
        >>> if os.path.exists(_gvfs_search_path):
        ...    n = "Android_Android_PLEGAR1791402808/Interner gemeinsamer Speicher/DCIM/Camera"
        ... else:
        ...    n = "Nokia 6_Nokia 6_PLEGAR1791402808/Interner gemeinsamer Speicher/DCIM/Camera"
        >>> for r, d, f in mtp.linux_access.walk(dev[0], n):
        ...     for f1 in f:
        ...             print(f1.name)
        ...
        IMG_20241210_160830.jpg
        IMG_20241210_160833.jpg
        IMG_20241210_161150.jpg
        test.jpg
        >>> dev[0].close()
    """
    path = path.replace("\\", os.path.sep)
    if (cont := get_content_from_device_path(dev, path)) is None:
        return
    walk_cont: list[PortableDeviceContent] = [cont]
    while walk_cont:
        cont = walk_cont[0]
        del walk_cont[0]
        directories: list[PortableDeviceContent] = []
        files: list[PortableDeviceContent] = []
        try:
            for child in cont.get_children():
                contenttype = child.content_type
                if contenttype in [
                    WPD_CONTENT_TYPE_STORAGE,
                    WPD_CONTENT_TYPE_DIRECTORY,
                ]:
                    directories.append(child)
                elif contenttype == WPD_CONTENT_TYPE_FILE:
                    files.append(child)
                if callback and not callback(child.full_filename):
                    directories = []
                    files = []
                    return
            directories.sort(key=lambda ent: ent.full_filename)
            files.sort(key=lambda ent: ent.full_filename)
            yield cont.full_filename, directories, files
        except Exception as err:
            if error_callback is not None:
                if not error_callback(str(err)):
                    directories = []
                    files = []
                    return
            else:
                raise IOError from err
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
        >>> import mtp.linux_access
        >>> dev = mtp.linux_access.get_portable_devices()
        >>> if os.path.exists(_gvfs_search_path):
        ...    n = "Android_Android_PLEGAR1791402808/Interner gemeinsamer Speicher/DCIM/Camera/Test"
        ... else:
        ...    n = "Nokia 6_Nokia 6_PLEGAR1791402808/Interner gemeinsamer Speicher/DCIM/Camera/Test"
        >>> cont = mtp.linux_access.makedirs(dev[0], n)
        >>> str(cont)
        'PortableDeviceContent Test (1)'
        >>> cont.remove()
        >>> dev[0].close()
    """
    path = path.replace("\\", os.path.sep)
    if _gvfs_found:
        try:
            fullpath = os.path.join(_gvfs_search_path, dev._device_start_part + path)
            if not os.path.exists(fullpath):
                os.makedirs(fullpath, exist_ok=True)
            cont = get_content_from_device_path(dev, path)
        except (IOError, IndexError) as err:
            raise IOError(f"Error creating directory '{path}': {err.args[1]}") from err
        if cont is None:
            raise IOError(f"Error creating directory '{path}'")
    else:
        found_stor = None
        parts = path.split(os.sep)
        if len(parts) <= 2:
            raise IOError(f"Devicename and or storage are missing in  {path}")
        storname_to_search = os.path.join(parts[0], parts[1])
        for stor in dev.get_content():
            if stor.full_filename == storname_to_search:
                found_stor = stor
                break
        if found_stor is None:
            raise IOError(f"The storage {storname_to_search} could not be found")
        cont = found_stor
        for pp in parts[2:]:
            par_cont = cont
            cont = cont.get_child(pp)
            if cont is None:
                cont = par_cont.create_content(pp)
    return cont


if __name__ == "__main__":
    dev = get_portable_devices()
    stor = dev[0].get_content()[0]
    print(str(stor.get_path(f"{stor.full_filename}/DCIM")))
    print(str(stor.get_path(f"DCIM")))
