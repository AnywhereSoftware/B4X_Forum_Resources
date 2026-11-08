from enum import IntFlag

import comtypes.gen._00020430_0000_0000_C000_000000000046_0_2_0 as __wrapper_module__
from comtypes.gen._00020430_0000_0000_C000_000000000046_0_2_0 import (
    Color, OLE_YSIZE_HIMETRIC, DISPMETHOD, Default, OLE_YSIZE_PIXELS,
    OLE_XSIZE_CONTAINER, VARIANT_BOOL, OLE_COLOR, OLE_XPOS_HIMETRIC,
    OLE_XSIZE_HIMETRIC, FONTSIZE, OLE_XPOS_CONTAINER, _check_version,
    Library, OLE_YPOS_HIMETRIC, StdPicture, OLE_HANDLE,
    FONTUNDERSCORE, dispid, FONTSTRIKETHROUGH, Checked, GUID, Gray,
    _lcid, OLE_YPOS_CONTAINER, OLE_OPTEXCLUSIVE, FontEvents, Font,
    DISPPROPERTY, COMMETHOD, IFontEventsDisp, FONTBOLD,
    OLE_ENABLEDEFAULTBOOL, IPicture, HRESULT, OLE_XSIZE_PIXELS, IFont,
    IPictureDisp, typelib_path, FONTNAME, OLE_YPOS_PIXELS,
    OLE_CANCELBOOL, VgaColor, OLE_XPOS_PIXELS, BSTR,
    OLE_YSIZE_CONTAINER, IDispatch, Unchecked, Monochrome, StdFont,
    EXCEPINFO, DISPPARAMS, IFontDisp, FONTITALIC, IUnknown, Picture,
    IEnumVARIANT, CoClass
)


class OLE_TRISTATE(IntFlag):
    Unchecked = 0
    Checked = 1
    Gray = 2


class LoadPictureConstants(IntFlag):
    Default = 0
    Monochrome = 1
    VgaColor = 2
    Color = 4


__all__ = [
    'Color', 'OLE_YSIZE_HIMETRIC', 'IPicture', 'Default',
    'OLE_YSIZE_PIXELS', 'OLE_XSIZE_CONTAINER', 'OLE_XSIZE_PIXELS',
    'IFont', 'IPictureDisp', 'typelib_path', 'OLE_COLOR', 'FONTNAME',
    'OLE_XPOS_HIMETRIC', 'OLE_XSIZE_HIMETRIC', 'OLE_CANCELBOOL',
    'OLE_YPOS_PIXELS', 'FONTSIZE', 'VgaColor', 'OLE_XPOS_CONTAINER',
    'OLE_TRISTATE', 'OLE_XPOS_PIXELS', 'Library', 'OLE_YPOS_HIMETRIC',
    'StdPicture', 'OLE_HANDLE', 'FONTUNDERSCORE',
    'OLE_YSIZE_CONTAINER', 'LoadPictureConstants',
    'FONTSTRIKETHROUGH', 'Checked', 'Gray', 'Unchecked', 'Monochrome',
    'StdFont', 'OLE_YPOS_CONTAINER', 'OLE_OPTEXCLUSIVE', 'FontEvents',
    'Font', 'IFontDisp', 'FONTITALIC', 'IFontEventsDisp', 'Picture',
    'FONTBOLD', 'OLE_ENABLEDEFAULTBOOL'
]

