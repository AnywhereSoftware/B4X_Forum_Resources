# -*- coding: mbcs -*-

from ctypes import *
from ctypes.wintypes import (
    _FILETIME, _LARGE_INTEGER, _ULARGE_INTEGER, DWORD, VARIANT_BOOL
)
from comtypes.typeinfo import (
    IRecordInfo, ITypeComp, ITypeInfo, ITypeLib, tagARRAYDESC,
    tagCALLCONV, tagDESCKIND, tagELEMDESC, tagFUNCDESC, tagFUNCKIND,
    tagIDLDESC, tagPARAMDESC, tagPARAMDESCEX, tagSAFEARRAYBOUND,
    tagSYSKIND, tagTLIBATTR, tagTYPEATTR, tagTYPEDESC, tagTYPEKIND,
    tagVARDESC, tagVARKIND, ULONG_PTR
)
from comtypes.automation import (
    DECIMAL, IDispatch, SCODE, tagINVOKEKIND, VARIANT
)
from . import _00020430_0000_0000_C000_000000000046_0_2_0
from comtypes import _check_version, BSTR, CoClass, COMMETHOD, GUID, IUnknown
from comtypes.stream import ISequentialStream
from ctypes import HRESULT
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from comtypes import hints


_lcid = 0  # change this if required
typelib_path = 'C:\\Windows\\System32\\PortableDeviceTypes.dll'
WSTRING = c_wchar_p
STRING = c_char_p



class _SHORT_SIZEDARR(Structure):
    pass


_SHORT_SIZEDARR._fields_ = [
    ('clSize', c_ulong),
    ('pData', POINTER(c_ushort)),
]

assert sizeof(_SHORT_SIZEDARR) == 16, sizeof(_SHORT_SIZEDARR)
assert alignment(_SHORT_SIZEDARR) == 8, alignment(_SHORT_SIZEDARR)


class Library(object):
    """PortableDeviceTypes 1.0 Type Library"""
    name = 'PortableDeviceTypesLib'
    _reg_typelib_ = ('{2B00BA2F-E750-4BEB-9235-97142EDE1D3E}', 1, 0)


class _BYTE_SIZEDARR(Structure):
    pass


_BYTE_SIZEDARR._fields_ = [
    ('clSize', c_ulong),
    ('pData', POINTER(c_ubyte)),
]

assert sizeof(_BYTE_SIZEDARR) == 16, sizeof(_BYTE_SIZEDARR)
assert alignment(_BYTE_SIZEDARR) == 8, alignment(_BYTE_SIZEDARR)


class tag_inner_PROPVARIANT(Structure):
    pass


class __MIDL___MIDL_itf_PortableDeviceTypes_0003_0017_0001(Union):
    pass


class tagCLIPDATA(Structure):
    pass


class tagBSTRBLOB(Structure):
    pass


tagBSTRBLOB._fields_ = [
    ('cbSize', c_ulong),
    ('pData', POINTER(c_ubyte)),
]

assert sizeof(tagBSTRBLOB) == 16, sizeof(tagBSTRBLOB)
assert alignment(tagBSTRBLOB) == 8, alignment(tagBSTRBLOB)


class tagBLOB(Structure):
    pass


tagBLOB._fields_ = [
    ('cbSize', c_ulong),
    ('pBlobData', POINTER(c_ubyte)),
]

assert sizeof(tagBLOB) == 16, sizeof(tagBLOB)
assert alignment(tagBLOB) == 8, alignment(tagBLOB)


class IStream(ISequentialStream):
    _case_insensitive_ = True
    _iid_ = GUID('{0000000C-0000-0000-C000-000000000046}')
    _idlflags_ = []

    if TYPE_CHECKING:  # commembers
        def RemoteSeek(self, dlibMove: hints.Incomplete, dwOrigin: hints.Incomplete) -> hints.Incomplete: ...
        def SetSize(self, libNewSize: hints.Incomplete) -> hints.Hresult: ...
        def RemoteCopyTo(self, pstm: hints.Incomplete, cb: hints.Incomplete) -> hints.Tuple[hints.Incomplete, hints.Incomplete]: ...
        def Commit(self, grfCommitFlags: hints.Incomplete) -> hints.Hresult: ...
        def Revert(self) -> hints.Hresult: ...
        def LockRegion(self, libOffset: hints.Incomplete, cb: hints.Incomplete, dwLockType: hints.Incomplete) -> hints.Hresult: ...
        def UnlockRegion(self, libOffset: hints.Incomplete, cb: hints.Incomplete, dwLockType: hints.Incomplete) -> hints.Hresult: ...
        def Stat(self, grfStatFlag: hints.Incomplete) -> hints.Incomplete: ...
        def Clone(self) -> 'IStream': ...


class IStorage(_00020430_0000_0000_C000_000000000046_0_2_0.IUnknown):
    _case_insensitive_ = True
    _iid_ = GUID('{0000000B-0000-0000-C000-000000000046}')
    _idlflags_ = []

    if TYPE_CHECKING:  # commembers
        def CreateStream(self, pwcsName: hints.Incomplete, grfMode: hints.Incomplete, reserved1: hints.Incomplete, reserved2: hints.Incomplete) -> 'IStream': ...
        def RemoteOpenStream(self, pwcsName: hints.Incomplete, cbReserved1: hints.Incomplete, reserved1: hints.Incomplete, grfMode: hints.Incomplete, reserved2: hints.Incomplete) -> 'IStream': ...
        def CreateStorage(self, pwcsName: hints.Incomplete, grfMode: hints.Incomplete, reserved1: hints.Incomplete, reserved2: hints.Incomplete) -> 'IStorage': ...
        def OpenStorage(self, pwcsName: hints.Incomplete, pstgPriority: hints.Incomplete, grfMode: hints.Incomplete, snbExclude: hints.Incomplete, reserved: hints.Incomplete) -> 'IStorage': ...
        def RemoteCopyTo(self, ciidExclude: hints.Incomplete, rgiidExclude: hints.Incomplete, snbExclude: hints.Incomplete, pstgDest: hints.Incomplete) -> hints.Hresult: ...
        def MoveElementTo(self, pwcsName: hints.Incomplete, pstgDest: hints.Incomplete, pwcsNewName: hints.Incomplete, grfFlags: hints.Incomplete) -> hints.Hresult: ...
        def Commit(self, grfCommitFlags: hints.Incomplete) -> hints.Hresult: ...
        def Revert(self) -> hints.Hresult: ...
        def RemoteEnumElements(self, reserved1: hints.Incomplete, cbReserved2: hints.Incomplete, reserved2: hints.Incomplete, reserved3: hints.Incomplete) -> 'IEnumSTATSTG': ...
        def DestroyElement(self, pwcsName: hints.Incomplete) -> hints.Hresult: ...
        def RenameElement(self, pwcsOldName: hints.Incomplete, pwcsNewName: hints.Incomplete) -> hints.Hresult: ...
        def SetElementTimes(self, pwcsName: hints.Incomplete, pctime: hints.Incomplete, patime: hints.Incomplete, pmtime: hints.Incomplete) -> hints.Hresult: ...
        def SetClass(self, clsid: hints.Incomplete) -> hints.Hresult: ...
        def SetStateBits(self, grfStateBits: hints.Incomplete, grfMask: hints.Incomplete) -> hints.Hresult: ...
        def Stat(self, grfStatFlag: hints.Incomplete) -> hints.Incomplete: ...


class tagVersionedStream(Structure):
    pass


class _wireSAFEARRAY(Structure):
    pass


wirePSAFEARRAY = POINTER(POINTER(_wireSAFEARRAY))


class tagCAC(Structure):
    pass


tagCAC._fields_ = [
    ('cElems', c_ulong),
    ('pElems', STRING),
]

assert sizeof(tagCAC) == 16, sizeof(tagCAC)
assert alignment(tagCAC) == 8, alignment(tagCAC)


class tagCAUB(Structure):
    pass


tagCAUB._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(c_ubyte)),
]

assert sizeof(tagCAUB) == 16, sizeof(tagCAUB)
assert alignment(tagCAUB) == 8, alignment(tagCAUB)


class tagCAI(Structure):
    pass


tagCAI._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(c_short)),
]

assert sizeof(tagCAI) == 16, sizeof(tagCAI)
assert alignment(tagCAI) == 8, alignment(tagCAI)


class tagCAUI(Structure):
    pass


tagCAUI._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(c_ushort)),
]

assert sizeof(tagCAUI) == 16, sizeof(tagCAUI)
assert alignment(tagCAUI) == 8, alignment(tagCAUI)


class tagCAL(Structure):
    pass


tagCAL._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(c_int)),
]

assert sizeof(tagCAL) == 16, sizeof(tagCAL)
assert alignment(tagCAL) == 8, alignment(tagCAL)


class tagCAUL(Structure):
    pass


tagCAUL._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(c_ulong)),
]

assert sizeof(tagCAUL) == 16, sizeof(tagCAUL)
assert alignment(tagCAUL) == 8, alignment(tagCAUL)


class tagCAH(Structure):
    pass


tagCAH._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(_LARGE_INTEGER)),
]

assert sizeof(tagCAH) == 16, sizeof(tagCAH)
assert alignment(tagCAH) == 8, alignment(tagCAH)


class tagCAUH(Structure):
    pass


tagCAUH._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(_ULARGE_INTEGER)),
]

assert sizeof(tagCAUH) == 16, sizeof(tagCAUH)
assert alignment(tagCAUH) == 8, alignment(tagCAUH)


class tagCAFLT(Structure):
    pass


tagCAFLT._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(c_float)),
]

assert sizeof(tagCAFLT) == 16, sizeof(tagCAFLT)
assert alignment(tagCAFLT) == 8, alignment(tagCAFLT)


class tagCADBL(Structure):
    pass


tagCADBL._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(c_double)),
]

assert sizeof(tagCADBL) == 16, sizeof(tagCADBL)
assert alignment(tagCADBL) == 8, alignment(tagCADBL)


class tagCABOOL(Structure):
    pass


tagCABOOL._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(VARIANT_BOOL)),
]

assert sizeof(tagCABOOL) == 16, sizeof(tagCABOOL)
assert alignment(tagCABOOL) == 8, alignment(tagCABOOL)


class tagCASCODE(Structure):
    pass


tagCASCODE._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(SCODE)),
]

assert sizeof(tagCASCODE) == 16, sizeof(tagCASCODE)
assert alignment(tagCASCODE) == 8, alignment(tagCASCODE)


class tagCACY(Structure):
    pass


tagCACY._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(c_longlong)),
]

assert sizeof(tagCACY) == 16, sizeof(tagCACY)
assert alignment(tagCACY) == 8, alignment(tagCACY)


class tagCADATE(Structure):
    pass


tagCADATE._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(c_double)),
]

assert sizeof(tagCADATE) == 16, sizeof(tagCADATE)
assert alignment(tagCADATE) == 8, alignment(tagCADATE)


class tagCAFILETIME(Structure):
    pass


tagCAFILETIME._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(_FILETIME)),
]

assert sizeof(tagCAFILETIME) == 16, sizeof(tagCAFILETIME)
assert alignment(tagCAFILETIME) == 8, alignment(tagCAFILETIME)


class tagCACLSID(Structure):
    pass


tagCACLSID._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(_00020430_0000_0000_C000_000000000046_0_2_0.GUID)),
]

assert sizeof(tagCACLSID) == 16, sizeof(tagCACLSID)
assert alignment(tagCACLSID) == 8, alignment(tagCACLSID)


class tagCACLIPDATA(Structure):
    pass


tagCACLIPDATA._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(tagCLIPDATA)),
]

assert sizeof(tagCACLIPDATA) == 16, sizeof(tagCACLIPDATA)
assert alignment(tagCACLIPDATA) == 8, alignment(tagCACLIPDATA)


class tagCABSTR(Structure):
    pass


tagCABSTR._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(BSTR)),
]

assert sizeof(tagCABSTR) == 16, sizeof(tagCABSTR)
assert alignment(tagCABSTR) == 8, alignment(tagCABSTR)


class tagCABSTRBLOB(Structure):
    pass


tagCABSTRBLOB._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(tagBSTRBLOB)),
]

assert sizeof(tagCABSTRBLOB) == 16, sizeof(tagCABSTRBLOB)
assert alignment(tagCABSTRBLOB) == 8, alignment(tagCABSTRBLOB)


class tagCALPSTR(Structure):
    pass


tagCALPSTR._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(STRING)),
]

assert sizeof(tagCALPSTR) == 16, sizeof(tagCALPSTR)
assert alignment(tagCALPSTR) == 8, alignment(tagCALPSTR)


class tagCALPWSTR(Structure):
    pass


tagCALPWSTR._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(WSTRING)),
]

assert sizeof(tagCALPWSTR) == 16, sizeof(tagCALPWSTR)
assert alignment(tagCALPWSTR) == 8, alignment(tagCALPWSTR)


class tagCAPROPVARIANT(Structure):
    pass


tagCAPROPVARIANT._fields_ = [
    ('cElems', c_ulong),
    ('pElems', POINTER(tag_inner_PROPVARIANT)),
]

assert sizeof(tagCAPROPVARIANT) == 16, sizeof(tagCAPROPVARIANT)
assert alignment(tagCAPROPVARIANT) == 8, alignment(tagCAPROPVARIANT)

__MIDL___MIDL_itf_PortableDeviceTypes_0003_0017_0001._fields_ = [
    ('cVal', c_char),
    ('bVal', c_ubyte),
    ('iVal', c_short),
    ('uiVal', c_ushort),
    ('lVal', c_int),
    ('ulVal', c_ulong),
    ('intVal', c_int),
    ('uintVal', c_uint),
    ('hVal', _LARGE_INTEGER),
    ('uhVal', _ULARGE_INTEGER),
    ('fltVal', c_float),
    ('dblVal', c_double),
    ('boolVal', VARIANT_BOOL),
    ('__OBSOLETE__VARIANT_BOOL', VARIANT_BOOL),
    ('scode', SCODE),
    ('cyVal', c_longlong),
    ('date', c_double),
    ('filetime', _FILETIME),
    ('puuid', POINTER(_00020430_0000_0000_C000_000000000046_0_2_0.GUID)),
    ('pClipData', POINTER(tagCLIPDATA)),
    ('bstrVal', BSTR),
    ('bstrblobVal', tagBSTRBLOB),
    ('blob', tagBLOB),
    ('pszVal', STRING),
    ('pwszVal', WSTRING),
    ('punkVal', POINTER(IUnknown)),
    ('pdispVal', POINTER(IDispatch)),
    ('pStream', POINTER(IStream)),
    ('pStorage', POINTER(IStorage)),
    ('pVersionedStream', POINTER(tagVersionedStream)),
    ('parray', wirePSAFEARRAY),
    ('cac', tagCAC),
    ('caub', tagCAUB),
    ('cai', tagCAI),
    ('caui', tagCAUI),
    ('cal', tagCAL),
    ('caul', tagCAUL),
    ('cah', tagCAH),
    ('cauh', tagCAUH),
    ('caflt', tagCAFLT),
    ('cadbl', tagCADBL),
    ('cabool', tagCABOOL),
    ('cascode', tagCASCODE),
    ('cacy', tagCACY),
    ('cadate', tagCADATE),
    ('cafiletime', tagCAFILETIME),
    ('cauuid', tagCACLSID),
    ('caclipdata', tagCACLIPDATA),
    ('cabstr', tagCABSTR),
    ('cabstrblob', tagCABSTRBLOB),
    ('calpstr', tagCALPSTR),
    ('calpwstr', tagCALPWSTR),
    ('capropvar', tagCAPROPVARIANT),
    ('pcVal', STRING),
    ('pbVal', POINTER(c_ubyte)),
    ('piVal', POINTER(c_short)),
    ('puiVal', POINTER(c_ushort)),
    ('plVal', POINTER(c_int)),
    ('pulVal', POINTER(c_ulong)),
    ('pintVal', POINTER(c_int)),
    ('puintVal', POINTER(c_uint)),
    ('pfltVal', POINTER(c_float)),
    ('pdblVal', POINTER(c_double)),
    ('pboolVal', POINTER(VARIANT_BOOL)),
    ('pdecVal', POINTER(DECIMAL)),
    ('pscode', POINTER(SCODE)),
    ('pcyVal', POINTER(c_longlong)),
    ('pdate', POINTER(c_double)),
    ('pbstrVal', POINTER(BSTR)),
    ('ppunkVal', POINTER(POINTER(IUnknown))),
    ('ppdispVal', POINTER(POINTER(IDispatch))),
    ('pparray', POINTER(wirePSAFEARRAY)),
    ('pvarVal', POINTER(tag_inner_PROPVARIANT)),
]

assert sizeof(__MIDL___MIDL_itf_PortableDeviceTypes_0003_0017_0001) == 16, sizeof(__MIDL___MIDL_itf_PortableDeviceTypes_0003_0017_0001)
assert alignment(__MIDL___MIDL_itf_PortableDeviceTypes_0003_0017_0001) == 8, alignment(__MIDL___MIDL_itf_PortableDeviceTypes_0003_0017_0001)

tag_inner_PROPVARIANT._fields_ = [
    ('vt', c_ushort),
    ('wReserved1', c_ubyte),
    ('wReserved2', c_ubyte),
    ('wReserved3', c_ulong),
    ('__MIDL____MIDL_itf_PortableDeviceTypes_0003_00170001', __MIDL___MIDL_itf_PortableDeviceTypes_0003_0017_0001),
]

assert sizeof(tag_inner_PROPVARIANT) == 24, sizeof(tag_inner_PROPVARIANT)
assert alignment(tag_inner_PROPVARIANT) == 8, alignment(tag_inner_PROPVARIANT)


class _wireSAFEARR_HAVEIID(Structure):
    pass


_wireSAFEARR_HAVEIID._fields_ = [
    ('Size', c_ulong),
    ('apUnknown', POINTER(POINTER(IUnknown))),
    ('iid', _00020430_0000_0000_C000_000000000046_0_2_0.GUID),
]

assert sizeof(_wireSAFEARR_HAVEIID) == 32, sizeof(_wireSAFEARR_HAVEIID)
assert alignment(_wireSAFEARR_HAVEIID) == 8, alignment(_wireSAFEARR_HAVEIID)


class IPropertyStore(_00020430_0000_0000_C000_000000000046_0_2_0.IUnknown):
    """Simple Property Store Interface"""
    _case_insensitive_ = True
    _iid_ = GUID('{886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99}')
    _idlflags_ = []

    if TYPE_CHECKING:  # commembers
        def GetCount(self) -> hints.Incomplete: ...
        def GetAt(self, iProp: hints.Incomplete) -> hints.Incomplete: ...
        def GetValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetValue(self, key: hints.Incomplete, propvar: hints.Incomplete) -> hints.Hresult: ...
        def Commit(self) -> hints.Hresult: ...


class _tagpropertykey(Structure):
    pass


IPropertyStore._methods_ = [
    COMMETHOD(
        [],
        HRESULT,
        'GetCount',
        (['out'], POINTER(c_ulong), 'cProps')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetAt',
        (['in'], c_ulong, 'iProp'),
        (['out'], POINTER(_tagpropertykey), 'pKey')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(tag_inner_PROPVARIANT), 'pv')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], POINTER(tag_inner_PROPVARIANT), 'propvar')
    ),
    COMMETHOD([], HRESULT, 'Commit'),
]

################################################################
# code template for IPropertyStore implementation
# class IPropertyStore_Impl(object):
#     def GetCount(self):
#         '-no docstring-'
#         #return cProps
#
#     def GetAt(self, iProp):
#         '-no docstring-'
#         #return pKey
#
#     def GetValue(self, key):
#         '-no docstring-'
#         #return pv
#
#     def SetValue(self, key, propvar):
#         '-no docstring-'
#         #return 
#
#     def Commit(self):
#         '-no docstring-'
#         #return 
#


class IPortableDeviceValuesCollection(_00020430_0000_0000_C000_000000000046_0_2_0.IUnknown):
    """IPortableDeviceValuesCollection Interface"""
    _case_insensitive_ = True
    _iid_ = GUID('{6E3F2D79-4E07-48C4-8208-D8C2E5AF4A99}')
    _idlflags_ = []

    if TYPE_CHECKING:  # commembers
        def GetCount(self, pcElems: hints.Incomplete) -> hints.Hresult: ...
        def GetAt(self, dwIndex: hints.Incomplete) -> 'IPortableDeviceValues': ...
        def Add(self, pValues: hints.Incomplete) -> hints.Hresult: ...
        def Clear(self) -> hints.Hresult: ...
        def RemoveAt(self, dwIndex: hints.Incomplete) -> hints.Hresult: ...


class IPortableDeviceValues(_00020430_0000_0000_C000_000000000046_0_2_0.IUnknown):
    """IPortableDeviceValues Interface"""
    _case_insensitive_ = True
    _iid_ = GUID('{6848F6F2-3155-4F86-B6F5-263EEEAB3143}')
    _idlflags_ = []

    if TYPE_CHECKING:  # commembers
        def GetCount(self, pcelt: hints.Incomplete) -> hints.Hresult: ...
        def GetAt(self, index: hints.Incomplete, pKey: hints.Incomplete, pValue: hints.Incomplete) -> hints.Tuple[hints.Incomplete, hints.Incomplete]: ...
        def SetValue(self, key: hints.Incomplete, pValue: hints.Incomplete) -> hints.Hresult: ...
        def GetValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetStringValue(self, key: hints.Incomplete, Value: hints.Incomplete) -> hints.Hresult: ...
        def GetStringValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetUnsignedIntegerValue(self, key: hints.Incomplete, Value: hints.Incomplete) -> hints.Hresult: ...
        def GetUnsignedIntegerValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetSignedIntegerValue(self, key: hints.Incomplete, Value: hints.Incomplete) -> hints.Hresult: ...
        def GetSignedIntegerValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetUnsignedLargeIntegerValue(self, key: hints.Incomplete, Value: hints.Incomplete) -> hints.Hresult: ...
        def GetUnsignedLargeIntegerValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetSignedLargeIntegerValue(self, key: hints.Incomplete, Value: hints.Incomplete) -> hints.Hresult: ...
        def GetSignedLargeIntegerValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetFloatValue(self, key: hints.Incomplete, Value: hints.Incomplete) -> hints.Hresult: ...
        def GetFloatValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetErrorValue(self, key: hints.Incomplete, Value: hints.Incomplete) -> hints.Hresult: ...
        def GetErrorValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetKeyValue(self, key: hints.Incomplete, Value: hints.Incomplete) -> hints.Hresult: ...
        def GetKeyValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetBoolValue(self, key: hints.Incomplete, Value: hints.Incomplete) -> hints.Hresult: ...
        def GetBoolValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetIUnknownValue(self, key: hints.Incomplete, pValue: hints.Incomplete) -> hints.Hresult: ...
        def GetIUnknownValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetGuidValue(self, key: hints.Incomplete, Value: hints.Incomplete) -> hints.Hresult: ...
        def GetGuidValue(self, key: hints.Incomplete) -> hints.Incomplete: ...
        def SetBufferValue(self, key: hints.Incomplete, pValue: hints.Incomplete, cbValue: hints.Incomplete) -> hints.Hresult: ...
        def GetBufferValue(self, key: hints.Incomplete) -> hints.Tuple[hints.Incomplete, hints.Incomplete]: ...
        def SetIPortableDeviceValuesValue(self, key: hints.Incomplete, pValue: hints.Incomplete) -> hints.Hresult: ...
        def GetIPortableDeviceValuesValue(self, key: hints.Incomplete) -> 'IPortableDeviceValues': ...
        def SetIPortableDevicePropVariantCollectionValue(self, key: hints.Incomplete, pValue: hints.Incomplete) -> hints.Hresult: ...
        def GetIPortableDevicePropVariantCollectionValue(self, key: hints.Incomplete) -> 'IPortableDevicePropVariantCollection': ...
        def SetIPortableDeviceKeyCollectionValue(self, key: hints.Incomplete, pValue: hints.Incomplete) -> hints.Hresult: ...
        def GetIPortableDeviceKeyCollectionValue(self, key: hints.Incomplete) -> 'IPortableDeviceKeyCollection': ...
        def SetIPortableDeviceValuesCollectionValue(self, key: hints.Incomplete, pValue: hints.Incomplete) -> hints.Hresult: ...
        def GetIPortableDeviceValuesCollectionValue(self, key: hints.Incomplete) -> 'IPortableDeviceValuesCollection': ...
        def RemoveValue(self, key: hints.Incomplete) -> hints.Hresult: ...
        def CopyValuesFromPropertyStore(self, pStore: hints.Incomplete) -> hints.Hresult: ...
        def CopyValuesToPropertyStore(self, pStore: hints.Incomplete) -> hints.Hresult: ...
        def Clear(self) -> hints.Hresult: ...


IPortableDeviceValuesCollection._methods_ = [
    COMMETHOD(
        [],
        HRESULT,
        'GetCount',
        (['in'], POINTER(c_ulong), 'pcElems')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetAt',
        (['in'], c_ulong, 'dwIndex'),
        (['out'], POINTER(POINTER(IPortableDeviceValues)), 'ppValues')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'Add',
        (['in'], POINTER(IPortableDeviceValues), 'pValues')
    ),
    COMMETHOD([], HRESULT, 'Clear'),
    COMMETHOD(
        [],
        HRESULT,
        'RemoveAt',
        (['in'], c_ulong, 'dwIndex')
    ),
]

################################################################
# code template for IPortableDeviceValuesCollection implementation
# class IPortableDeviceValuesCollection_Impl(object):
#     def GetCount(self, pcElems):
#         '-no docstring-'
#         #return 
#
#     def GetAt(self, dwIndex):
#         '-no docstring-'
#         #return ppValues
#
#     def Add(self, pValues):
#         '-no docstring-'
#         #return 
#
#     def Clear(self):
#         '-no docstring-'
#         #return 
#
#     def RemoveAt(self, dwIndex):
#         '-no docstring-'
#         #return 
#


class _wireSAFEARR_BRECORD(Structure):
    pass


class _wireBRECORD(Structure):
    pass


_wireSAFEARR_BRECORD._fields_ = [
    ('Size', c_ulong),
    ('aRecord', POINTER(POINTER(_wireBRECORD))),
]

assert sizeof(_wireSAFEARR_BRECORD) == 16, sizeof(_wireSAFEARR_BRECORD)
assert alignment(_wireSAFEARR_BRECORD) == 8, alignment(_wireSAFEARR_BRECORD)


class IPortableDeviceKeyCollection(_00020430_0000_0000_C000_000000000046_0_2_0.IUnknown):
    """IPortableDeviceKeyCollection Interface"""
    _case_insensitive_ = True
    _iid_ = GUID('{DADA2357-E0AD-492E-98DB-DD61C53BA353}')
    _idlflags_ = []

    if TYPE_CHECKING:  # commembers
        def GetCount(self, pcElems: hints.Incomplete) -> hints.Hresult: ...
        def GetAt(self, dwIndex: hints.Incomplete, pKey: hints.Incomplete) -> hints.Hresult: ...
        def Add(self, key: hints.Incomplete) -> hints.Hresult: ...
        def Clear(self) -> hints.Hresult: ...
        def RemoveAt(self, dwIndex: hints.Incomplete) -> hints.Hresult: ...


IPortableDeviceKeyCollection._methods_ = [
    COMMETHOD(
        [],
        HRESULT,
        'GetCount',
        (['in'], POINTER(c_ulong), 'pcElems')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetAt',
        (['in'], c_ulong, 'dwIndex'),
        (['in'], POINTER(_tagpropertykey), 'pKey')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'Add',
        (['in'], POINTER(_tagpropertykey), 'key')
    ),
    COMMETHOD([], HRESULT, 'Clear'),
    COMMETHOD(
        [],
        HRESULT,
        'RemoveAt',
        (['in'], c_ulong, 'dwIndex')
    ),
]

################################################################
# code template for IPortableDeviceKeyCollection implementation
# class IPortableDeviceKeyCollection_Impl(object):
#     def GetCount(self, pcElems):
#         '-no docstring-'
#         #return 
#
#     def GetAt(self, dwIndex, pKey):
#         '-no docstring-'
#         #return 
#
#     def Add(self, key):
#         '-no docstring-'
#         #return 
#
#     def Clear(self):
#         '-no docstring-'
#         #return 
#
#     def RemoveAt(self, dwIndex):
#         '-no docstring-'
#         #return 
#

tagCLIPDATA._fields_ = [
    ('cbSize', c_ulong),
    ('ulClipFmt', c_int),
    ('pClipData', POINTER(c_ubyte)),
]

assert sizeof(tagCLIPDATA) == 16, sizeof(tagCLIPDATA)
assert alignment(tagCLIPDATA) == 8, alignment(tagCLIPDATA)


class PortableDeviceValues(CoClass):
    """Portable Device Values Class"""
    _reg_clsid_ = GUID('{0C15D503-D017-47CE-9016-7B3F978721CC}')
    _idlflags_ = []
    _typelib_path_ = typelib_path
    _reg_typelib_ = ('{2B00BA2F-E750-4BEB-9235-97142EDE1D3E}', 1, 0)


PortableDeviceValues._com_interfaces_ = [IPortableDeviceValues]


class IPortableDevicePropVariantCollection(_00020430_0000_0000_C000_000000000046_0_2_0.IUnknown):
    """IPortableDevicePropVariantCollection Interface"""
    _case_insensitive_ = True
    _iid_ = GUID('{89B2E422-4F1B-4316-BCEF-A44AFEA83EB3}')
    _idlflags_ = []

    if TYPE_CHECKING:  # commembers
        def GetCount(self, pcElems: hints.Incomplete) -> hints.Hresult: ...
        def GetAt(self, dwIndex: hints.Incomplete, pValue: hints.Incomplete) -> hints.Hresult: ...
        def Add(self, pValue: hints.Incomplete) -> hints.Hresult: ...
        def GetType(self) -> hints.Incomplete: ...
        def ChangeType(self, vt: hints.Incomplete) -> hints.Hresult: ...
        def Clear(self) -> hints.Hresult: ...
        def RemoveAt(self, dwIndex: hints.Incomplete) -> hints.Hresult: ...


IPortableDevicePropVariantCollection._methods_ = [
    COMMETHOD(
        [],
        HRESULT,
        'GetCount',
        (['in'], POINTER(c_ulong), 'pcElems')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetAt',
        (['in'], c_ulong, 'dwIndex'),
        (['in'], POINTER(tag_inner_PROPVARIANT), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'Add',
        (['in'], POINTER(tag_inner_PROPVARIANT), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetType',
        (['out'], POINTER(c_ushort), 'pvt')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'ChangeType',
        (['in'], c_ushort, 'vt')
    ),
    COMMETHOD([], HRESULT, 'Clear'),
    COMMETHOD(
        [],
        HRESULT,
        'RemoveAt',
        (['in'], c_ulong, 'dwIndex')
    ),
]

################################################################
# code template for IPortableDevicePropVariantCollection implementation
# class IPortableDevicePropVariantCollection_Impl(object):
#     def GetCount(self, pcElems):
#         '-no docstring-'
#         #return 
#
#     def GetAt(self, dwIndex, pValue):
#         '-no docstring-'
#         #return 
#
#     def Add(self, pValue):
#         '-no docstring-'
#         #return 
#
#     def GetType(self):
#         '-no docstring-'
#         #return pvt
#
#     def ChangeType(self, vt):
#         '-no docstring-'
#         #return 
#
#     def Clear(self):
#         '-no docstring-'
#         #return 
#
#     def RemoveAt(self, dwIndex):
#         '-no docstring-'
#         #return 
#


class tagSTATSTG(Structure):
    pass


IStream._methods_ = [
    COMMETHOD(
        [],
        HRESULT,
        'RemoteSeek',
        (['in'], _LARGE_INTEGER, 'dlibMove'),
        (['in'], c_ulong, 'dwOrigin'),
        (['out'], POINTER(_ULARGE_INTEGER), 'plibNewPosition')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetSize',
        (['in'], _ULARGE_INTEGER, 'libNewSize')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'RemoteCopyTo',
        (['in'], POINTER(IStream), 'pstm'),
        (['in'], _ULARGE_INTEGER, 'cb'),
        (['out'], POINTER(_ULARGE_INTEGER), 'pcbRead'),
        (['out'], POINTER(_ULARGE_INTEGER), 'pcbWritten')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'Commit',
        (['in'], c_ulong, 'grfCommitFlags')
    ),
    COMMETHOD([], HRESULT, 'Revert'),
    COMMETHOD(
        [],
        HRESULT,
        'LockRegion',
        (['in'], _ULARGE_INTEGER, 'libOffset'),
        (['in'], _ULARGE_INTEGER, 'cb'),
        (['in'], c_ulong, 'dwLockType')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'UnlockRegion',
        (['in'], _ULARGE_INTEGER, 'libOffset'),
        (['in'], _ULARGE_INTEGER, 'cb'),
        (['in'], c_ulong, 'dwLockType')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'Stat',
        (['out'], POINTER(tagSTATSTG), 'pstatstg'),
        (['in'], c_ulong, 'grfStatFlag')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'Clone',
        (['out'], POINTER(POINTER(IStream)), 'ppstm')
    ),
]

################################################################
# code template for IStream implementation
# class IStream_Impl(object):
#     def RemoteSeek(self, dlibMove, dwOrigin):
#         '-no docstring-'
#         #return plibNewPosition
#
#     def SetSize(self, libNewSize):
#         '-no docstring-'
#         #return 
#
#     def RemoteCopyTo(self, pstm, cb):
#         '-no docstring-'
#         #return pcbRead, pcbWritten
#
#     def Commit(self, grfCommitFlags):
#         '-no docstring-'
#         #return 
#
#     def Revert(self):
#         '-no docstring-'
#         #return 
#
#     def LockRegion(self, libOffset, cb, dwLockType):
#         '-no docstring-'
#         #return 
#
#     def UnlockRegion(self, libOffset, cb, dwLockType):
#         '-no docstring-'
#         #return 
#
#     def Stat(self, grfStatFlag):
#         '-no docstring-'
#         #return pstatstg
#
#     def Clone(self):
#         '-no docstring-'
#         #return ppstm
#

tagSTATSTG._fields_ = [
    ('pwcsName', WSTRING),
    ('type', c_ulong),
    ('cbSize', _ULARGE_INTEGER),
    ('mtime', _FILETIME),
    ('ctime', _FILETIME),
    ('atime', _FILETIME),
    ('grfMode', c_ulong),
    ('grfLocksSupported', c_ulong),
    ('clsid', _00020430_0000_0000_C000_000000000046_0_2_0.GUID),
    ('grfStateBits', c_ulong),
    ('reserved', c_ulong),
]

assert sizeof(tagSTATSTG) == 80, sizeof(tagSTATSTG)
assert alignment(tagSTATSTG) == 8, alignment(tagSTATSTG)


class tagRemSNB(Structure):
    pass


wireSNB = POINTER(tagRemSNB)


class IEnumSTATSTG(_00020430_0000_0000_C000_000000000046_0_2_0.IUnknown):
    _case_insensitive_ = True
    _iid_ = GUID('{0000000D-0000-0000-C000-000000000046}')
    _idlflags_ = []

    if TYPE_CHECKING:  # commembers
        def RemoteNext(self, celt: hints.Incomplete) -> hints.Tuple[hints.Incomplete, hints.Incomplete]: ...
        def Skip(self, celt: hints.Incomplete) -> hints.Hresult: ...
        def Reset(self) -> hints.Hresult: ...
        def Clone(self) -> 'IEnumSTATSTG': ...


IStorage._methods_ = [
    COMMETHOD(
        [],
        HRESULT,
        'CreateStream',
        (['in'], WSTRING, 'pwcsName'),
        (['in'], c_ulong, 'grfMode'),
        (['in'], c_ulong, 'reserved1'),
        (['in'], c_ulong, 'reserved2'),
        (['out'], POINTER(POINTER(IStream)), 'ppstm')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'RemoteOpenStream',
        (['in'], WSTRING, 'pwcsName'),
        (['in'], c_ulong, 'cbReserved1'),
        (['in'], POINTER(c_ubyte), 'reserved1'),
        (['in'], c_ulong, 'grfMode'),
        (['in'], c_ulong, 'reserved2'),
        (['out'], POINTER(POINTER(IStream)), 'ppstm')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'CreateStorage',
        (['in'], WSTRING, 'pwcsName'),
        (['in'], c_ulong, 'grfMode'),
        (['in'], c_ulong, 'reserved1'),
        (['in'], c_ulong, 'reserved2'),
        (['out'], POINTER(POINTER(IStorage)), 'ppstg')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'OpenStorage',
        (['in'], WSTRING, 'pwcsName'),
        (['in'], POINTER(IStorage), 'pstgPriority'),
        (['in'], c_ulong, 'grfMode'),
        (['in'], wireSNB, 'snbExclude'),
        (['in'], c_ulong, 'reserved'),
        (['out'], POINTER(POINTER(IStorage)), 'ppstg')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'RemoteCopyTo',
        (['in'], c_ulong, 'ciidExclude'),
        (
            ['in'],
            POINTER(_00020430_0000_0000_C000_000000000046_0_2_0.GUID),
            'rgiidExclude',
        ),
        (['in'], wireSNB, 'snbExclude'),
        (['in'], POINTER(IStorage), 'pstgDest')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'MoveElementTo',
        (['in'], WSTRING, 'pwcsName'),
        (['in'], POINTER(IStorage), 'pstgDest'),
        (['in'], WSTRING, 'pwcsNewName'),
        (['in'], c_ulong, 'grfFlags')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'Commit',
        (['in'], c_ulong, 'grfCommitFlags')
    ),
    COMMETHOD([], HRESULT, 'Revert'),
    COMMETHOD(
        [],
        HRESULT,
        'RemoteEnumElements',
        (['in'], c_ulong, 'reserved1'),
        (['in'], c_ulong, 'cbReserved2'),
        (['in'], POINTER(c_ubyte), 'reserved2'),
        (['in'], c_ulong, 'reserved3'),
        (['out'], POINTER(POINTER(IEnumSTATSTG)), 'ppenum')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'DestroyElement',
        (['in'], WSTRING, 'pwcsName')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'RenameElement',
        (['in'], WSTRING, 'pwcsOldName'),
        (['in'], WSTRING, 'pwcsNewName')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetElementTimes',
        (['in'], WSTRING, 'pwcsName'),
        (['in'], POINTER(_FILETIME), 'pctime'),
        (['in'], POINTER(_FILETIME), 'patime'),
        (['in'], POINTER(_FILETIME), 'pmtime')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetClass',
        (
            ['in'],
            POINTER(_00020430_0000_0000_C000_000000000046_0_2_0.GUID),
            'clsid',
        )
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetStateBits',
        (['in'], c_ulong, 'grfStateBits'),
        (['in'], c_ulong, 'grfMask')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'Stat',
        (['out'], POINTER(tagSTATSTG), 'pstatstg'),
        (['in'], c_ulong, 'grfStatFlag')
    ),
]

################################################################
# code template for IStorage implementation
# class IStorage_Impl(object):
#     def CreateStream(self, pwcsName, grfMode, reserved1, reserved2):
#         '-no docstring-'
#         #return ppstm
#
#     def RemoteOpenStream(self, pwcsName, cbReserved1, reserved1, grfMode, reserved2):
#         '-no docstring-'
#         #return ppstm
#
#     def CreateStorage(self, pwcsName, grfMode, reserved1, reserved2):
#         '-no docstring-'
#         #return ppstg
#
#     def OpenStorage(self, pwcsName, pstgPriority, grfMode, snbExclude, reserved):
#         '-no docstring-'
#         #return ppstg
#
#     def RemoteCopyTo(self, ciidExclude, rgiidExclude, snbExclude, pstgDest):
#         '-no docstring-'
#         #return 
#
#     def MoveElementTo(self, pwcsName, pstgDest, pwcsNewName, grfFlags):
#         '-no docstring-'
#         #return 
#
#     def Commit(self, grfCommitFlags):
#         '-no docstring-'
#         #return 
#
#     def Revert(self):
#         '-no docstring-'
#         #return 
#
#     def RemoteEnumElements(self, reserved1, cbReserved2, reserved2, reserved3):
#         '-no docstring-'
#         #return ppenum
#
#     def DestroyElement(self, pwcsName):
#         '-no docstring-'
#         #return 
#
#     def RenameElement(self, pwcsOldName, pwcsNewName):
#         '-no docstring-'
#         #return 
#
#     def SetElementTimes(self, pwcsName, pctime, patime, pmtime):
#         '-no docstring-'
#         #return 
#
#     def SetClass(self, clsid):
#         '-no docstring-'
#         #return 
#
#     def SetStateBits(self, grfStateBits, grfMask):
#         '-no docstring-'
#         #return 
#
#     def Stat(self, grfStatFlag):
#         '-no docstring-'
#         #return pstatstg
#

tagRemSNB._pack_ = 4

tagRemSNB._fields_ = [
    ('ulCntStr', c_ulong),
    ('ulCntChar', c_ulong),
    ('rgString', POINTER(c_ushort)),
]

assert sizeof(tagRemSNB) == 16, sizeof(tagRemSNB)
assert alignment(tagRemSNB) == 4, alignment(tagRemSNB)

IEnumSTATSTG._methods_ = [
    COMMETHOD(
        [],
        HRESULT,
        'RemoteNext',
        (['in'], c_ulong, 'celt'),
        (['out'], POINTER(tagSTATSTG), 'rgelt'),
        (['out'], POINTER(c_ulong), 'pceltFetched')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'Skip',
        (['in'], c_ulong, 'celt')
    ),
    COMMETHOD([], HRESULT, 'Reset'),
    COMMETHOD(
        [],
        HRESULT,
        'Clone',
        (['out'], POINTER(POINTER(IEnumSTATSTG)), 'ppenum')
    ),
]

################################################################
# code template for IEnumSTATSTG implementation
# class IEnumSTATSTG_Impl(object):
#     def RemoteNext(self, celt):
#         '-no docstring-'
#         #return rgelt, pceltFetched
#
#     def Skip(self, celt):
#         '-no docstring-'
#         #return 
#
#     def Reset(self):
#         '-no docstring-'
#         #return 
#
#     def Clone(self):
#         '-no docstring-'
#         #return ppenum
#

tagVersionedStream._fields_ = [
    ('guidVersion', _00020430_0000_0000_C000_000000000046_0_2_0.GUID),
    ('pStream', POINTER(IStream)),
]

assert sizeof(tagVersionedStream) == 24, sizeof(tagVersionedStream)
assert alignment(tagVersionedStream) == 8, alignment(tagVersionedStream)


class _wireSAFEARRAY_UNION(Structure):
    pass


class __MIDL_IOleAutomationTypes_0001(Union):
    pass


class _wireSAFEARR_BSTR(Structure):
    pass


class _FLAGGED_WORD_BLOB(Structure):
    pass


_wireSAFEARR_BSTR._fields_ = [
    ('Size', c_ulong),
    ('aBstr', POINTER(POINTER(_FLAGGED_WORD_BLOB))),
]

assert sizeof(_wireSAFEARR_BSTR) == 16, sizeof(_wireSAFEARR_BSTR)
assert alignment(_wireSAFEARR_BSTR) == 8, alignment(_wireSAFEARR_BSTR)


class _wireSAFEARR_UNKNOWN(Structure):
    pass


_wireSAFEARR_UNKNOWN._fields_ = [
    ('Size', c_ulong),
    ('apUnknown', POINTER(POINTER(IUnknown))),
]

assert sizeof(_wireSAFEARR_UNKNOWN) == 16, sizeof(_wireSAFEARR_UNKNOWN)
assert alignment(_wireSAFEARR_UNKNOWN) == 8, alignment(_wireSAFEARR_UNKNOWN)


class _wireSAFEARR_DISPATCH(Structure):
    pass


_wireSAFEARR_DISPATCH._fields_ = [
    ('Size', c_ulong),
    ('apDispatch', POINTER(POINTER(IDispatch))),
]

assert sizeof(_wireSAFEARR_DISPATCH) == 16, sizeof(_wireSAFEARR_DISPATCH)
assert alignment(_wireSAFEARR_DISPATCH) == 8, alignment(_wireSAFEARR_DISPATCH)


class _wireSAFEARR_VARIANT(Structure):
    pass


class _wireVARIANT(Structure):
    pass


_wireSAFEARR_VARIANT._fields_ = [
    ('Size', c_ulong),
    ('aVariant', POINTER(POINTER(_wireVARIANT))),
]

assert sizeof(_wireSAFEARR_VARIANT) == 16, sizeof(_wireSAFEARR_VARIANT)
assert alignment(_wireSAFEARR_VARIANT) == 8, alignment(_wireSAFEARR_VARIANT)


class _LONG_SIZEDARR(Structure):
    pass


_LONG_SIZEDARR._fields_ = [
    ('clSize', c_ulong),
    ('pData', POINTER(c_ulong)),
]

assert sizeof(_LONG_SIZEDARR) == 16, sizeof(_LONG_SIZEDARR)
assert alignment(_LONG_SIZEDARR) == 8, alignment(_LONG_SIZEDARR)


class _HYPER_SIZEDARR(Structure):
    pass


_HYPER_SIZEDARR._fields_ = [
    ('clSize', c_ulong),
    ('pData', POINTER(c_longlong)),
]

assert sizeof(_HYPER_SIZEDARR) == 16, sizeof(_HYPER_SIZEDARR)
assert alignment(_HYPER_SIZEDARR) == 8, alignment(_HYPER_SIZEDARR)

__MIDL_IOleAutomationTypes_0001._fields_ = [
    ('BstrStr', _wireSAFEARR_BSTR),
    ('UnknownStr', _wireSAFEARR_UNKNOWN),
    ('DispatchStr', _wireSAFEARR_DISPATCH),
    ('VariantStr', _wireSAFEARR_VARIANT),
    ('RecordStr', _wireSAFEARR_BRECORD),
    ('HaveIidStr', _wireSAFEARR_HAVEIID),
    ('ByteStr', _BYTE_SIZEDARR),
    ('WordStr', _SHORT_SIZEDARR),
    ('LongStr', _LONG_SIZEDARR),
    ('HyperStr', _HYPER_SIZEDARR),
]

assert sizeof(__MIDL_IOleAutomationTypes_0001) == 32, sizeof(__MIDL_IOleAutomationTypes_0001)
assert alignment(__MIDL_IOleAutomationTypes_0001) == 8, alignment(__MIDL_IOleAutomationTypes_0001)

_wireSAFEARRAY_UNION._fields_ = [
    ('sfType', c_ulong),
    ('u', __MIDL_IOleAutomationTypes_0001),
]

assert sizeof(_wireSAFEARRAY_UNION) == 40, sizeof(_wireSAFEARRAY_UNION)
assert alignment(_wireSAFEARRAY_UNION) == 8, alignment(_wireSAFEARRAY_UNION)

_wireSAFEARRAY._fields_ = [
    ('cDims', c_ushort),
    ('fFeatures', c_ushort),
    ('cbElements', c_ulong),
    ('cLocks', c_ulong),
    ('uArrayStructs', _wireSAFEARRAY_UNION),
    ('rgsabound', POINTER(tagSAFEARRAYBOUND)),
]

assert sizeof(_wireSAFEARRAY) == 64, sizeof(_wireSAFEARRAY)
assert alignment(_wireSAFEARRAY) == 8, alignment(_wireSAFEARRAY)


class PortableDevicePropVariantCollection(CoClass):
    """Portable Device PROPVARIANT collection"""
    _reg_clsid_ = GUID('{08A99E2F-6D6D-4B80-AF5A-BAF2BCBE4CB9}')
    _idlflags_ = []
    _typelib_path_ = typelib_path
    _reg_typelib_ = ('{2B00BA2F-E750-4BEB-9235-97142EDE1D3E}', 1, 0)


PortableDevicePropVariantCollection._com_interfaces_ = [IPortableDevicePropVariantCollection]

_FLAGGED_WORD_BLOB._pack_ = 4

_FLAGGED_WORD_BLOB._fields_ = [
    ('fFlags', c_ulong),
    ('clSize', c_ulong),
    ('asData', POINTER(c_ushort)),
]

assert sizeof(_FLAGGED_WORD_BLOB) == 16, sizeof(_FLAGGED_WORD_BLOB)
assert alignment(_FLAGGED_WORD_BLOB) == 4, alignment(_FLAGGED_WORD_BLOB)


class __MIDL_IOleAutomationTypes_0005(Union):
    pass


__MIDL_IOleAutomationTypes_0005._fields_ = [
    ('lptdesc', POINTER(tagTYPEDESC)),
    ('lpadesc', POINTER(tagARRAYDESC)),
    ('hreftype', c_ulong),
]

assert sizeof(__MIDL_IOleAutomationTypes_0005) == 8, sizeof(__MIDL_IOleAutomationTypes_0005)
assert alignment(__MIDL_IOleAutomationTypes_0005) == 8, alignment(__MIDL_IOleAutomationTypes_0005)


class __MIDL_IOleAutomationTypes_0006(Union):
    pass


__MIDL_IOleAutomationTypes_0006._fields_ = [
    ('oInst', c_ulong),
    ('lpvarValue', POINTER(VARIANT)),
]

assert sizeof(__MIDL_IOleAutomationTypes_0006) == 8, sizeof(__MIDL_IOleAutomationTypes_0006)
assert alignment(__MIDL_IOleAutomationTypes_0006) == 8, alignment(__MIDL_IOleAutomationTypes_0006)


class __MIDL_IOleAutomationTypes_0004(Union):
    pass


__MIDL_IOleAutomationTypes_0004._fields_ = [
    ('llVal', c_longlong),
    ('lVal', c_int),
    ('bVal', c_ubyte),
    ('iVal', c_short),
    ('fltVal', c_float),
    ('dblVal', c_double),
    ('boolVal', VARIANT_BOOL),
    ('scode', SCODE),
    ('cyVal', c_longlong),
    ('date', c_double),
    ('bstrVal', POINTER(_FLAGGED_WORD_BLOB)),
    ('punkVal', POINTER(IUnknown)),
    ('pdispVal', POINTER(IDispatch)),
    ('parray', POINTER(POINTER(_wireSAFEARRAY))),
    ('brecVal', POINTER(_wireBRECORD)),
    ('pbVal', POINTER(c_ubyte)),
    ('piVal', POINTER(c_short)),
    ('plVal', POINTER(c_int)),
    ('pllVal', POINTER(c_longlong)),
    ('pfltVal', POINTER(c_float)),
    ('pdblVal', POINTER(c_double)),
    ('pboolVal', POINTER(VARIANT_BOOL)),
    ('pscode', POINTER(SCODE)),
    ('pcyVal', POINTER(c_longlong)),
    ('pdate', POINTER(c_double)),
    ('pbstrVal', POINTER(POINTER(_FLAGGED_WORD_BLOB))),
    ('ppunkVal', POINTER(POINTER(IUnknown))),
    ('ppdispVal', POINTER(POINTER(IDispatch))),
    ('pparray', POINTER(POINTER(POINTER(_wireSAFEARRAY)))),
    ('pvarVal', POINTER(POINTER(_wireVARIANT))),
    ('cVal', c_char),
    ('uiVal', c_ushort),
    ('ulVal', c_ulong),
    ('ullVal', c_ulonglong),
    ('intVal', c_int),
    ('uintVal', c_uint),
    ('decVal', DECIMAL),
    ('pdecVal', POINTER(DECIMAL)),
    ('pcVal', STRING),
    ('puiVal', POINTER(c_ushort)),
    ('pulVal', POINTER(c_ulong)),
    ('pullVal', POINTER(c_ulonglong)),
    ('pintVal', POINTER(c_int)),
    ('puintVal', POINTER(c_uint)),
]

assert sizeof(__MIDL_IOleAutomationTypes_0004) == 16, sizeof(__MIDL_IOleAutomationTypes_0004)
assert alignment(__MIDL_IOleAutomationTypes_0004) == 8, alignment(__MIDL_IOleAutomationTypes_0004)

_wireVARIANT._fields_ = [
    ('clSize', c_ulong),
    ('rpcReserved', c_ulong),
    ('vt', c_ushort),
    ('wReserved1', c_ushort),
    ('wReserved2', c_ushort),
    ('wReserved3', c_ushort),
    ('DUMMYUNIONNAME', __MIDL_IOleAutomationTypes_0004),
]

assert sizeof(_wireVARIANT) == 32, sizeof(_wireVARIANT)
assert alignment(_wireVARIANT) == 8, alignment(_wireVARIANT)

_wireBRECORD._fields_ = [
    ('fFlags', c_ulong),
    ('clSize', c_ulong),
    ('pRecInfo', POINTER(IRecordInfo)),
    ('pRecord', POINTER(c_ubyte)),
]

assert sizeof(_wireBRECORD) == 24, sizeof(_wireBRECORD)
assert alignment(_wireBRECORD) == 8, alignment(_wireBRECORD)


class WpdSerializer(CoClass):
    """WpdSerializer Class"""
    _reg_clsid_ = GUID('{0B91A74B-AD7C-4A9D-B563-29EEF9167172}')
    _idlflags_ = []
    _typelib_path_ = typelib_path
    _reg_typelib_ = ('{2B00BA2F-E750-4BEB-9235-97142EDE1D3E}', 1, 0)


class IWpdSerializer(_00020430_0000_0000_C000_000000000046_0_2_0.IUnknown):
    """IWpdSerializer Interface"""
    _case_insensitive_ = True
    _iid_ = GUID('{B32F4002-BB27-45FF-AF4F-06631C1E8DAD}')
    _idlflags_ = []

    if TYPE_CHECKING:  # commembers
        def GetIPortableDeviceValuesFromBuffer(self, pBuffer: hints.Incomplete, dwInputBufferLength: hints.Incomplete) -> 'IPortableDeviceValues': ...
        def WriteIPortableDeviceValuesToBuffer(self, dwOutputBufferLength: hints.Incomplete, pResults: hints.Incomplete) -> hints.Tuple[hints.Incomplete, hints.Incomplete]: ...
        def GetBufferFromIPortableDeviceValues(self, pSource: hints.Incomplete) -> hints.Tuple[hints.Incomplete, hints.Incomplete]: ...
        def GetSerializedSize(self, pSource: hints.Incomplete) -> hints.Incomplete: ...


WpdSerializer._com_interfaces_ = [IWpdSerializer]


class PortableDeviceValuesCollection(CoClass):
    """Portable Device Values collection"""
    _reg_clsid_ = GUID('{3882134D-14CF-4220-9CB4-435F86D83F60}')
    _idlflags_ = []
    _typelib_path_ = typelib_path
    _reg_typelib_ = ('{2B00BA2F-E750-4BEB-9235-97142EDE1D3E}', 1, 0)


PortableDeviceValuesCollection._com_interfaces_ = [IPortableDeviceValuesCollection]

IPortableDeviceValues._methods_ = [
    COMMETHOD(
        [],
        HRESULT,
        'GetCount',
        (['in'], POINTER(c_ulong), 'pcelt')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetAt',
        (['in'], c_ulong, 'index'),
        (['in', 'out'], POINTER(_tagpropertykey), 'pKey'),
        (['in', 'out'], POINTER(tag_inner_PROPVARIANT), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], POINTER(tag_inner_PROPVARIANT), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(tag_inner_PROPVARIANT), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetStringValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], WSTRING, 'Value')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetStringValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(WSTRING), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetUnsignedIntegerValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], c_ulong, 'Value')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetUnsignedIntegerValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(c_ulong), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetSignedIntegerValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], c_int, 'Value')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetSignedIntegerValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(c_int), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetUnsignedLargeIntegerValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], c_ulonglong, 'Value')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetUnsignedLargeIntegerValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(c_ulonglong), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetSignedLargeIntegerValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], c_longlong, 'Value')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetSignedLargeIntegerValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(c_longlong), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetFloatValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], c_float, 'Value')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetFloatValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(c_float), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetErrorValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], HRESULT, 'Value')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetErrorValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(HRESULT), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetKeyValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], POINTER(_tagpropertykey), 'Value')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetKeyValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(_tagpropertykey), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetBoolValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], c_int, 'Value')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetBoolValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(c_int), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetIUnknownValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], POINTER(IUnknown), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetIUnknownValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(POINTER(IUnknown)), 'ppValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetGuidValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (
            ['in'],
            POINTER(_00020430_0000_0000_C000_000000000046_0_2_0.GUID),
            'Value',
        )
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetGuidValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (
            ['out'],
            POINTER(_00020430_0000_0000_C000_000000000046_0_2_0.GUID),
            'pValue',
        )
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetBufferValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], POINTER(c_ubyte), 'pValue'),
        (['in'], c_ulong, 'cbValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetBufferValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(POINTER(c_ubyte)), 'ppValue'),
        (['out'], POINTER(c_ulong), 'pcbValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetIPortableDeviceValuesValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], POINTER(IPortableDeviceValues), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetIPortableDeviceValuesValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(POINTER(IPortableDeviceValues)), 'ppValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetIPortableDevicePropVariantCollectionValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], POINTER(IPortableDevicePropVariantCollection), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetIPortableDevicePropVariantCollectionValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (
            ['out'],
            POINTER(POINTER(IPortableDevicePropVariantCollection)),
            'ppValue',
        )
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetIPortableDeviceKeyCollectionValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], POINTER(IPortableDeviceKeyCollection), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetIPortableDeviceKeyCollectionValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(POINTER(IPortableDeviceKeyCollection)), 'ppValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'SetIPortableDeviceValuesCollectionValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['in'], POINTER(IPortableDeviceValuesCollection), 'pValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetIPortableDeviceValuesCollectionValue',
        (['in'], POINTER(_tagpropertykey), 'key'),
        (['out'], POINTER(POINTER(IPortableDeviceValuesCollection)), 'ppValue')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'RemoveValue',
        (['in'], POINTER(_tagpropertykey), 'key')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'CopyValuesFromPropertyStore',
        (['in'], POINTER(IPropertyStore), 'pStore')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'CopyValuesToPropertyStore',
        (['in'], POINTER(IPropertyStore), 'pStore')
    ),
    COMMETHOD([], HRESULT, 'Clear'),
]

################################################################
# code template for IPortableDeviceValues implementation
# class IPortableDeviceValues_Impl(object):
#     def GetCount(self, pcelt):
#         '-no docstring-'
#         #return 
#
#     def GetAt(self, index):
#         '-no docstring-'
#         #return pKey, pValue
#
#     def SetValue(self, key, pValue):
#         '-no docstring-'
#         #return 
#
#     def GetValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetStringValue(self, key, Value):
#         '-no docstring-'
#         #return 
#
#     def GetStringValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetUnsignedIntegerValue(self, key, Value):
#         '-no docstring-'
#         #return 
#
#     def GetUnsignedIntegerValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetSignedIntegerValue(self, key, Value):
#         '-no docstring-'
#         #return 
#
#     def GetSignedIntegerValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetUnsignedLargeIntegerValue(self, key, Value):
#         '-no docstring-'
#         #return 
#
#     def GetUnsignedLargeIntegerValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetSignedLargeIntegerValue(self, key, Value):
#         '-no docstring-'
#         #return 
#
#     def GetSignedLargeIntegerValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetFloatValue(self, key, Value):
#         '-no docstring-'
#         #return 
#
#     def GetFloatValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetErrorValue(self, key, Value):
#         '-no docstring-'
#         #return 
#
#     def GetErrorValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetKeyValue(self, key, Value):
#         '-no docstring-'
#         #return 
#
#     def GetKeyValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetBoolValue(self, key, Value):
#         '-no docstring-'
#         #return 
#
#     def GetBoolValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetIUnknownValue(self, key, pValue):
#         '-no docstring-'
#         #return 
#
#     def GetIUnknownValue(self, key):
#         '-no docstring-'
#         #return ppValue
#
#     def SetGuidValue(self, key, Value):
#         '-no docstring-'
#         #return 
#
#     def GetGuidValue(self, key):
#         '-no docstring-'
#         #return pValue
#
#     def SetBufferValue(self, key, pValue, cbValue):
#         '-no docstring-'
#         #return 
#
#     def GetBufferValue(self, key):
#         '-no docstring-'
#         #return ppValue, pcbValue
#
#     def SetIPortableDeviceValuesValue(self, key, pValue):
#         '-no docstring-'
#         #return 
#
#     def GetIPortableDeviceValuesValue(self, key):
#         '-no docstring-'
#         #return ppValue
#
#     def SetIPortableDevicePropVariantCollectionValue(self, key, pValue):
#         '-no docstring-'
#         #return 
#
#     def GetIPortableDevicePropVariantCollectionValue(self, key):
#         '-no docstring-'
#         #return ppValue
#
#     def SetIPortableDeviceKeyCollectionValue(self, key, pValue):
#         '-no docstring-'
#         #return 
#
#     def GetIPortableDeviceKeyCollectionValue(self, key):
#         '-no docstring-'
#         #return ppValue
#
#     def SetIPortableDeviceValuesCollectionValue(self, key, pValue):
#         '-no docstring-'
#         #return 
#
#     def GetIPortableDeviceValuesCollectionValue(self, key):
#         '-no docstring-'
#         #return ppValue
#
#     def RemoveValue(self, key):
#         '-no docstring-'
#         #return 
#
#     def CopyValuesFromPropertyStore(self, pStore):
#         '-no docstring-'
#         #return 
#
#     def CopyValuesToPropertyStore(self, pStore):
#         '-no docstring-'
#         #return 
#
#     def Clear(self):
#         '-no docstring-'
#         #return 
#

_tagpropertykey._fields_ = [
    ('fmtid', _00020430_0000_0000_C000_000000000046_0_2_0.GUID),
    ('pid', c_ulong),
]

assert sizeof(_tagpropertykey) == 20, sizeof(_tagpropertykey)
assert alignment(_tagpropertykey) == 4, alignment(_tagpropertykey)


class PortableDeviceKeyCollection(CoClass):
    """Portable Device PROPERTYKEY collection"""
    _reg_clsid_ = GUID('{DE2D022D-2480-43BE-97F0-D1FA2CF98F4F}')
    _idlflags_ = []
    _typelib_path_ = typelib_path
    _reg_typelib_ = ('{2B00BA2F-E750-4BEB-9235-97142EDE1D3E}', 1, 0)


PortableDeviceKeyCollection._com_interfaces_ = [IPortableDeviceKeyCollection]

IWpdSerializer._methods_ = [
    COMMETHOD(
        [],
        HRESULT,
        'GetIPortableDeviceValuesFromBuffer',
        (['in'], POINTER(c_ubyte), 'pBuffer'),
        (['in'], c_ulong, 'dwInputBufferLength'),
        (['out'], POINTER(POINTER(IPortableDeviceValues)), 'ppParams')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'WriteIPortableDeviceValuesToBuffer',
        (['in'], c_ulong, 'dwOutputBufferLength'),
        (['in'], POINTER(IPortableDeviceValues), 'pResults'),
        (['out'], POINTER(c_ubyte), 'pBuffer'),
        (['out'], POINTER(c_ulong), 'pdwBytesWritten')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetBufferFromIPortableDeviceValues',
        (['in'], POINTER(IPortableDeviceValues), 'pSource'),
        (['out'], POINTER(POINTER(c_ubyte)), 'ppBuffer'),
        (['out'], POINTER(c_ulong), 'pdwBufferSize')
    ),
    COMMETHOD(
        [],
        HRESULT,
        'GetSerializedSize',
        (['in'], POINTER(IPortableDeviceValues), 'pSource'),
        (['out'], POINTER(c_ulong), 'pdwSize')
    ),
]

################################################################
# code template for IWpdSerializer implementation
# class IWpdSerializer_Impl(object):
#     def GetIPortableDeviceValuesFromBuffer(self, pBuffer, dwInputBufferLength):
#         '-no docstring-'
#         #return ppParams
#
#     def WriteIPortableDeviceValuesToBuffer(self, dwOutputBufferLength, pResults):
#         '-no docstring-'
#         #return pBuffer, pdwBytesWritten
#
#     def GetBufferFromIPortableDeviceValues(self, pSource):
#         '-no docstring-'
#         #return ppBuffer, pdwBufferSize
#
#     def GetSerializedSize(self, pSource):
#         '-no docstring-'
#         #return pdwSize
#

__all__ = [
    'tagCACY', 'PortableDeviceValues', 'tagSTATSTG',
    '_wireSAFEARR_VARIANT', '_HYPER_SIZEDARR',
    'IPortableDeviceKeyCollection', '__MIDL_IOleAutomationTypes_0001',
    'tagCAFLT', 'IStorage', 'typelib_path', 'IPortableDeviceValues',
    '_wireSAFEARR_HAVEIID', 'tagCLIPDATA', 'tagCAUH', 'tagCADBL',
    'Library', 'tagCAFILETIME', 'tagCAI', 'IWpdSerializer',
    'PortableDeviceValuesCollection', '_SHORT_SIZEDARR',
    'IEnumSTATSTG', 'tagCADATE', 'tagCAC', 'tagCAH',
    'tagCAPROPVARIANT', '_wireSAFEARR_DISPATCH',
    'PortableDevicePropVariantCollection', 'tagCAUB', 'tagCABSTR',
    'IStream', 'tagCACLIPDATA', 'IPropertyStore',
    'IPortableDevicePropVariantCollection', 'wireSNB',
    '__MIDL_IOleAutomationTypes_0006', 'PortableDeviceKeyCollection',
    'tagVersionedStream', 'tagCAL', 'tagCALPWSTR', '_wireVARIANT',
    '__MIDL___MIDL_itf_PortableDeviceTypes_0003_0017_0001',
    'tagCASCODE', '_LONG_SIZEDARR', 'tag_inner_PROPVARIANT',
    'WpdSerializer', 'tagBSTRBLOB', 'tagBLOB', 'tagCAUL',
    'IPortableDeviceValuesCollection', '_wireSAFEARR_BRECORD',
    'wirePSAFEARRAY', 'tagCABSTRBLOB', '_wireSAFEARRAY', 'tagCALPSTR',
    '_wireBRECORD', 'tagRemSNB', 'tagCAUI', 'tagCACLSID',
    '_FLAGGED_WORD_BLOB', '_wireSAFEARR_BSTR', '_wireSAFEARRAY_UNION',
    '_tagpropertykey', '_wireSAFEARR_UNKNOWN', 'tagCABOOL',
    '__MIDL_IOleAutomationTypes_0005',
    '__MIDL_IOleAutomationTypes_0004', '_BYTE_SIZEDARR'
]

_check_version('1.4.10', 1741532197.767389)

