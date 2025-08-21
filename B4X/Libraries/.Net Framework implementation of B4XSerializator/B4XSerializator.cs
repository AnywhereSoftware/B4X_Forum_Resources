using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using ICSharpCode.SharpZipLib.Zip.Compression.Streams;

namespace WpfApplication1
{
    public class B4XSerializator
    {
        private const byte T_NULL = 0, T_STRING = 1, T_SHORT = 2, T_INT = 3, T_LONG = 4, T_FLOAT = 5,
	        T_DOUBLE = 6, T_BOOLEAN = 7, T_BYTE = 10, T_CHAR = 14, T_MAP = 20, T_LIST = 21,
	        T_NSARRAY = 22, T_NSDATA = 23, T_TYPE = 24;
        private BinaryReader br;
        private BinaryWriter bw;
        private readonly UTF8Encoding utf8;
        public B4XSerializator()
        {
            utf8 = new UTF8Encoding(false);
        }

        public Object ConvertBytesToObject(byte[] Bytes)
        {
            using (InflaterInputStream inf = new InflaterInputStream(new MemoryStream(Bytes)))
            {
                br = new BinaryReader(inf);
                Object ret = readObject();
		        return ret;
            }
            
        }
        public byte[] ConvertObjectToBytes(Object Object) 
        {
		   MemoryStream ms = new MemoryStream();
           using (DeflaterOutputStream def = new DeflaterOutputStream(ms))
           {
               bw = new BinaryWriter(def);
               writeObject(Object);
           }
            return ms.ToArray();
        }
        private void writeObject(Object o)
        {
            if (o == null)
                writeByte(T_NULL);
            else if (o is int)
            {
                writeByte(T_INT);
                writeInt((int)o);
            }
            else if (o is Double)
            {
                writeByte(T_DOUBLE);
                bw.Write((double)o);
            }
            else if (o is float)
            {
                writeByte(T_FLOAT);
                bw.Write((float)o);
            }
            else if (o is long)
            {
                writeByte(T_LONG);
                bw.Write((long)o);
            }
            else if (o is byte)
            {
                writeByte(T_BYTE);
                bw.Write((byte)o);
            }
            else if (o is short)
            {
                writeByte(T_SHORT);
                bw.Write((short)o);
            }
            else if (o is Char)
            {
                writeByte(T_CHAR);
                bw.Write((short)(char)o);
            }
            else if (o is bool)
            {
                writeByte(T_BOOLEAN);
                writeByte((byte)((bool)o ? 1 : 0));
            }
            else if (o is string)
            {
                byte[] temp = utf8.GetBytes((string)o);
                writeByte(T_STRING);
                writeInt(temp.Length);
                bw.Write(temp, 0, temp.Length);
            }
            else if (o is List<object>)
            {
                writeByte(T_LIST);
                writeList((List<Object>)o);
            }
            else if (o is Dictionary<object, object>)
            {
                writeByte(T_MAP);
                writeMap((Dictionary<object, object>)o);
            }
            else if (o.GetType().IsArray)
            {
                if (o is byte[])
                {
                    writeByte(T_NSDATA);
                    byte[] b = (byte[])o;
                    writeInt(b.Length);
                    bw.Write(b, 0, b.Length);
                }
                else if (o is object[])
                {
                    writeByte(T_NSARRAY);
                    writeList(new List<object>((object[])o));
                }
                else
                    throw new Exception("Only arrays of bytes or objects are supported.");
            }
            else if (o is B4XType)
            {
                writeByte(T_TYPE);
                writeType((B4XType)o);

            }
            else
                throw new Exception("Type not supported: " + o.GetType());
        }
        private void writeMap(Dictionary<object, object> m)
        {
            writeInt(m.Count);
            foreach (KeyValuePair<object, object> kvp in m)
            {
                writeObject(kvp.Key);
                writeObject(kvp.Value);
            }
        }

        private void writeList(List<object> list)
        {
            writeInt(list.Count);
            foreach (Object o in list)
            {
                writeObject(o);
            }

        }

        private Object readObject()
        {
            byte t = br.ReadByte();
            int len;
            byte[] b;
            switch (t)
            {
                case T_NULL:
                    return null;
                case T_INT:
                    return readInt();
                case T_SHORT:
                    return readShort();
                case T_LONG:
                    return br.ReadInt64();
                case T_FLOAT:
                    return br.ReadSingle();
                case T_DOUBLE:
                    return br.ReadDouble();
                case T_BOOLEAN:
                    return br.ReadByte() == 1;
                case T_BYTE:
                    return br.ReadByte();
                case T_STRING:
                    len = readInt();
                    b = br.ReadBytes(len);
                    return utf8.GetString(b);
                case T_CHAR:
                    return (char)readShort();
                case T_LIST:
                    return readList();
                case T_MAP:
                    return readMap();
                case T_NSDATA:
                    len = readInt();
                    return br.ReadBytes(len);
                case T_NSARRAY:
                    List<Object> list = readList();
                    return list.ToArray();
                case T_TYPE:
                    return readType();
                default:
                    throw new Exception("Unsupported type: " + t);
            }
        }
        private void writeByte(byte b)
        {
            bw.Write(b);
        }
        private void writeInt(int i)
        {
            bw.Write(i);
        }
        private List<Object> readList()
        {
            int len = readInt();
            List<object> arr = new List<object>(len);
            for (int i = 0; i < len; i++)
                arr.Add(readObject());
            return arr;
        }
        private Dictionary<Object, Object> readMap()
        {
            int len = readInt();
            Dictionary<object, object> mm = new Dictionary<object, object>();
            for (int i = 0; i < len; i++)
            {
                mm[readObject()] = readObject();
            }
            return mm;
        }
        private int readInt()
        {
            return br.ReadInt32();
        }
        private short readShort()
        {
            return br.ReadInt16();
        }
        private Object readType()
        {
            string cls = (string)readObject();
            var data = readMap();
            return new B4XType(cls, data);
        }
        private void writeType(B4XType t)
        {
            writeObject("_" + t.ClassName);
            writeMap(t.Fields);
        }

    }
    public class B4XType
    {
        public readonly string ClassName;
        public readonly Dictionary<object, object> Fields;
        public B4XType(string className, Dictionary<object, object> data)
        {
            int i = className.LastIndexOf("$");
            if (i > -1)
                className = className.Substring(i + 2);
            else if (className.StartsWith("_"))
            {
                className = className.Substring(1);
            }
            else
                className = className.ToLower(new CultureInfo("en-US", false));
            this.ClassName = className;
            this.Fields = data;
        }
    }
}
