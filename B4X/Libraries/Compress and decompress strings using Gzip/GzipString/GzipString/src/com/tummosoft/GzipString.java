package com.tummosoft;

import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

@Version(1.22f)
@ShortName("GzipString")
public class GzipString {

    public static byte[] gzipCompress(String str) throws IOException {
        if (str == null || str.isEmpty()) {
            return new byte[0];
        }

        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        try (GZIPOutputStream gzip = new GZIPOutputStream(bos)) {
            gzip.write(str.getBytes(StandardCharsets.UTF_8));
        }
        return bos.toByteArray();
    }

    public static String gzipDecompress(byte[] compressed) throws IOException {
        if (compressed == null || compressed.length == 0) {
            return "";
        }

        ByteArrayInputStream bis = new ByteArrayInputStream(compressed);
        GZIPInputStream gzip = new GZIPInputStream(bis);

        byte[] buffer = new byte[1024];
        StringBuilder result = new StringBuilder();
        int len;

        while ((len = gzip.read(buffer)) > 0) {
            result.append(new String(buffer, 0, len, StandardCharsets.UTF_8));
        }

        return result.toString();
    }
}
