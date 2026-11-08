"""
A module to modify the from comtypes generated modules.
They contain some wrong function calls. These calls are corrected by this function

Use it if you want to create a new comtype_gen_win_wpd directory

Author:  Heribert Füchtenhans

Version: 2025.4.3

"""

import shutil
import comtypes  # type: ignore # pylint: disable=import-error
import comtypes.client  # type: ignore # pylint: disable=import-error
import os


def modify_generated_files(gen_dir: str) -> None:
    """Modifies the from comtypes generated files because some call are incorrect"""
    filename = os.path.join(gen_dir, "_1F001332_1A57_4934_BE31_AFFC99F4EE0A_0_1_0.py")
    with open(filename, encoding="utf-8") as inp:
        content = inp.read()
    content_changed_count = 0
    for entry in (
        (
            "IEnumPortableDeviceObjectIDs._methods_",
            "'Next',",
            "(['out'], POINTER(WSTRING), 'pObjIDs')",
            "(['in', 'out'], POINTER(WSTRING), 'pObjIDs')",
        ),
        (
            "IPortableDeviceContent._methods_",
            "'CreateObjectWithPropertiesAndData'",
            "(['out'], POINTER(POINTER(IStream)), 'ppData')",
            "(['in', 'out'], POINTER(POINTER(IStream)), 'ppData')",
        ),
        (
            "IPortableDeviceResources._methods_",
            "'GetStream'",
            "(['out'], POINTER(POINTER(IStream)), 'ppStream')",
            "(['in', 'out'], POINTER(POINTER(IStream)), 'ppStream')",
        ),
        (
            "tag_inner_PROPVARIANT._fields_ =",
            "('__MIDL",
            "('__MIDL____MIDL_itf_PortableDeviceApi_0001_00000001', __MIDL___MIDL_itf_"
            "PortableDeviceApi_0001_0000_0001)",
            "('data', __MIDL___MIDL_itf_PortableDeviceApi_0001_0000_0001)",
        ),
        (
            "IPortableDeviceContent._methods_ =",
            "'Delete'",
            "    ['in', 'out'],",
            "    ['in'],",
        ),
    ):
        pos = content.find(entry[0])
        pos = content.find(entry[1], pos)
        pos1 = content.find(entry[2], pos, pos + 300)
        if pos1 > 0:
            content = content[:pos1] + content[pos1:].replace(entry[2], entry[3], 1)
            content_changed_count += 1
    # Save all back when changed
    if content_changed_count != 0:
        with open(filename, "w", encoding="utf-8") as outp:
            outp.write(content)
        if content_changed_count != 5:
            print(f"Changed uncomplete. Please check why not all changes where made")
        else:
            print("All changes done.")

    # Modify the Portable... files to import from correct module
    filename = os.path.join(gen_dir, "PortableDeviceApiLib.py")
    outlines: list[str] = []
    with open(filename, "rt", encoding="utf-8") as inp:
        for line in inp:
            if "import comtypes.gen." in line:
                line = line.replace("import comtypes.gen.", "from . import ")
            elif "from comtypes.gen." in line:
                line = line.replace("from comtypes.gen.", "from . ")
            outlines.append(line)
    with open(filename, "wt", encoding="UTF-8") as outp:
        outp.write("".join(outlines))

    filename = os.path.join(gen_dir, "PortableDeviceTypesLib.py")
    outlines: list[str] = []
    with open(filename, "rt", encoding="utf-8") as inp:
        for line in inp:
            if "import comtypes.gen." in line:
                line = line.replace("import comtypes.gen.", "from . import ")
            elif "from comtypes.gen." in line:
                line = line.replace("from comtypes.gen.", "from . ")
            outlines.append(line)
    with open(filename, "wt", encoding="UTF-8") as outp:
        outp.write("".join(outlines))

    filename = os.path.join(gen_dir, "_1F001332_1A57_4934_BE31_AFFC99F4EE0A_0_1_0.py")
    outlines: list[str] = []
    with open(filename, "rt", encoding="utf-8") as inp:
        for line in inp:
            if "import comtypes.gen." in line:
                line = line.replace("import comtypes.gen.", "from . import ")
            elif "comtypes.gen." in line:
                line = line.replace("comtypes.gen.", "")
            outlines.append(line)
    with open(filename, "wt", encoding="UTF-8") as outp:
        outp.write("".join(outlines))

    filename = os.path.join(gen_dir, "_2B00BA2F_E750_4BEB_9235_97142EDE1D3E_0_1_0.py")
    outlines: list[str] = []
    with open(filename, "rt", encoding="utf-8") as inp:
        for line in inp:
            if "import comtypes.gen." in line:
                line = line.replace("import comtypes.gen.", "from . import ")
            elif "comtypes.gen." in line:
                line = line.replace("comtypes.gen.", "")
            outlines.append(line)
    with open(filename, "wt", encoding="UTF-8") as outp:
        outp.write("".join(outlines))


if __name__ == "__main__":
    gen_dir = os.path.join(os.path.dirname(__file__), "comtype_gen_win_wpd")
    shutil.rmtree(gen_dir)
    os.makedirs(gen_dir, exist_ok=True)
    # Create new __init__ file for the module
    with open(os.path.join(gen_dir, "__init__.py"), "wt", encoding="UTF-8") as inp:
        inp.write("# comtypes.gen package, directory for generated files.\n")
    comtypes.client.gen_dir = gen_dir
    comtypes.client.GetModule("portabledeviceapi.dll")
    comtypes.client.GetModule("portabledevicetypes.dll")
    modify_generated_files(gen_dir)  # type: ignore
