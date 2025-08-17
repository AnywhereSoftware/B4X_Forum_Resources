# mtp

Accessing the filesystem of MTP devices (Smartphones, MP3-Player, etc.) on Windows or Linux with python.

In the mtp directory there are three modules.
- win_access.py
- linux_access.py
- dialog.py

For detailed description see site directory

Tested with:
* Python 3.12 and above
* comptypes 1.4.10
* Windows 10 / 11
* Linux Mint, Zorin, Debian 12 with KDE


## win_access.py
This module implements the access to the Windows WPD functions to read and write MTP devices like smartphones, tablets. etc.

## linux_access.py
This module implements the access to read and write MTP devices like smartphones, tablets. etc. from Linux.
Only GNOME based systems are supported due to kio-fuse on KDE doesn't support the mtp protocol and the Python bindings for KIO don't exist yet.

## dialog.py
dialog.py implements a directory searcher in tkinter that shows the attached MTP devices and the directories on them.


# Changelog
* 2.0.4
    * Fixed remove. It will now raise IOError if remove could not be done
    * Added create_new_comtype_modules_from_wpd_dlls to automtically create new comtype files.
        This is only needed if for some reason the Windows WPD library changes.
    * Removed ProtableDevice.get_properties because all properties are now directly accessible
    * Updates documentation and doctest
* 2.0.3
    * Updated get_path to support relative filenames
* 2.0.2
    * Fixed wrong handling of error callback in walk
    * Modified 'upload' to work with older Gnome versions who don't support direct writing to the virtual filesystem
* 2.0.1
    * Deleted a bug when uploading files on a Linux KDE system
    * Changed returned filenames in content to be consitent with the windows module
* 2.0.0
    * Removed PortableDevice.get_description
      Use PortableDevice.name, PortableDevice.description
    * removed PortableDeviceContent.upload_stream and .download_stream
      Please use .upload and .download
    * get_properties now returns the modification time and not creation time
    * Corrected calculation of filetime in win_access
    * Added support for KDE
* 1.3.0
    * Eleminated the need for a programm restart after first use of the comtypes library and modifying the generated wpd access files.
      This requires that you use comtypes 1.4.10 or newer on Windows.
    * Updated documentation
* 1.2.0
    * Access MTP devices from Linux with Gnome as desktop environment
* 1.0.2
    * Fixed a bug when an MTP device doesn't have a userfriendly name
* 1.0.1
    * Fixed crash when during walk a directory is deleted.
    * Fixed full_filename for files was not set.

