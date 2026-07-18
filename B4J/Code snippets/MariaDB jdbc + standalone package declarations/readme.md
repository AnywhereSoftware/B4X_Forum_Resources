### MariaDB jdbc + standalone package declarations by Erel
### 07/13/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171535/)

1. Download mariadb-java-client: <https://repo1.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/3.5.9/mariadb-java-client-3.5.9.jar>  
2. Copy to additional libraries folder and add reference with #AdditionalJar: mariadb-java-client-3.5.9.jar  
3. Initialize the connection pool or SQL object with:  
driver: org.mariadb.jdbc.Driver  
url: jdbc:mariadb://localhost:3306/db\_name  
  
If you want to build a standalone package then add:  

```B4X
#PackagerProperty: AdditionalModuleInfoString = provides org.mariadb.jdbc.plugin.Codec with org.mariadb.jdbc.plugin.codec.BigDecimalCodec, org.mariadb.jdbc.plugin.codec.BigIntegerCodec, org.mariadb.jdbc.plugin.codec.BitSetCodec, org.mariadb.jdbc.plugin.codec.BlobCodec, org.mariadb.jdbc.plugin.codec.BooleanCodec, org.mariadb.jdbc.plugin.codec.ByteArrayCodec, org.mariadb.jdbc.plugin.codec.ByteCodec, org.mariadb.jdbc.plugin.codec.ClobCodec, org.mariadb.jdbc.plugin.codec.DateCodec, org.mariadb.jdbc.plugin.codec.DoubleCodec, org.mariadb.jdbc.plugin.codec.DurationCodec, org.mariadb.jdbc.plugin.codec.FloatCodec, org.mariadb.jdbc.plugin.codec.GeometryCollectionCodec, org.mariadb.jdbc.plugin.codec.IntCodec, org.mariadb.jdbc.plugin.codec.InstantCodec, org.mariadb.jdbc.plugin.codec.OffsetDateTimeCodec, org.mariadb.jdbc.plugin.codec.LineStringCodec, org.mariadb.jdbc.plugin.codec.LocalDateCodec, org.mariadb.jdbc.plugin.codec.LocalDateTimeCodec, org.mariadb.jdbc.plugin.codec.LocalTimeCodec, org.mariadb.jdbc.plugin.codec.LongCodec, org.mariadb.jdbc.plugin.codec.MultiLinestringCodec, org.mariadb.jdbc.plugin.codec.MultiPointCodec, org.mariadb.jdbc.plugin.codec.MultiPolygonCodec, org.mariadb.jdbc.plugin.codec.PointCodec, org.mariadb.jdbc.plugin.codec.PolygonCodec, org.mariadb.jdbc.plugin.codec.ReaderCodec, org.mariadb.jdbc.plugin.codec.ShortCodec, org.mariadb.jdbc.plugin.codec.StreamCodec, org.mariadb.jdbc.plugin.codec.StringCodec, org.mariadb.jdbc.plugin.codec.TimeCodec, org.mariadb.jdbc.plugin.codec.TimestampCodec, org.mariadb.jdbc.plugin.codec.UuidCodec, org.mariadb.jdbc.plugin.codec.ZonedDateTimeCodec, org.mariadb.jdbc.plugin.codec.FloatArrayCodec, org.mariadb.jdbc.plugin.codec.FloatObjectArrayCodec;
```