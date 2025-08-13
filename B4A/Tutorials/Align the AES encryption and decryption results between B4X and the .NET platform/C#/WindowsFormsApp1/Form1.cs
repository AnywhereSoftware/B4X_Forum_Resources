using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        /// <summary>
        /// AES加密<para>作者：lesliexin@outlook.com</para><para>Web：www.lesliexin.com</para><para>日期：2022-12-17</para>
        /// </summary>
        /// <param name="str">待解密字符串</param>
        /// <param name="key">密码</param>
        /// <param name="iv">向量</param>
        /// <returns></returns>
        byte[] AesEncrypt(string str, string key, string iv)
        {
            try
            {
                var _keyByte = Encoding.UTF8.GetBytes(key);
                var _valueByte = Encoding.UTF8.GetBytes(str);
                using (var aes = new RijndaelManaged())
                {
                    aes.IV = Encoding.UTF8.GetBytes(iv);
                    aes.Key = _keyByte;
                    aes.Mode = CipherMode.CBC;
                    aes.Padding = PaddingMode.PKCS7;
                    var cryptoTransform = aes.CreateEncryptor();
                    var resultArray = cryptoTransform.TransformFinalBlock(_valueByte, 0, _valueByte.Length);
                    return resultArray;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("加密出错：" + ex.Message);
                return null;
            }

        }

        /// <summary>
        /// AES解密<para>作者：lesliexin@outlook.com</para><para>Web：www.lesliexin.com</para><para>日期：2022-12-17</para>
        /// </summary>
        /// <param name="str">待解密字符串</param>
        /// <param name="key">密码</param>
        /// <param name="iv">向量</param>
        /// <returns></returns>
        string AesDecrypt(byte[] str, string key, string iv)
        {
            try
            {
                using (var aes = new RijndaelManaged())
                {
                    aes.IV = Encoding.UTF8.GetBytes(iv);
                    aes.Key = Encoding.UTF8.GetBytes(key);
                    aes.Mode = CipherMode.CBC;
                    aes.Padding = PaddingMode.PKCS7;
                    var cryptoTransform = aes.CreateDecryptor();
                    var resultArray = cryptoTransform.TransformFinalBlock(str, 0, str.Length);
                    return Encoding.UTF8.GetString(resultArray);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("解密出错：" + ex.Message);
                return "";
            }
        }

        /// <summary>
        /// 将16进制字符串转换成字节数组
        /// </summary>
        /// <param name="hex"></param>
        /// <returns></returns>
        byte[] HexStrToBytes(string hex)
        {
            var bs = new byte[hex.Length / 2];
            for (int i = 0; i < hex.Length; i += 2)
            {
                bs[i / 2] = Convert.ToByte(hex.Substring(i, 2), 16);
            }
            return bs;
        }

        /// <summary>
        /// 将字节数组转换成16进制字符串
        /// </summary>
        /// <param name="bs"></param>
        /// <returns></returns>
        string BytesToHexStr(byte[] bs)
        {
            return BitConverter.ToString(bs).Replace("-", "");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string str = "这是一串待加解密的字符串";
            string iv = "abcdefghijklmnop";
            string key = "ponmlkjihgfedcba";

            var envalue = AesEncrypt(str, key, iv);
            Console.WriteLine("加密结果：" + BytesToHexStr(envalue));

            var destr = AesDecrypt(envalue, key, iv);
            Console.WriteLine("解密结果：" + destr);

        }
    }
}
