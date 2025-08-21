#!/usr/bin/env python
# coding: utf-8



##Układ współrzędnych 1965 (strefa I) – EPSG:3120
##Układ współrzędnych 1965 (strefa II) – EPSG:2172
##Układ współrzędnych 1965 (strefa III) – EPSG:2173
##Układ współrzędnych 1965 (strefa IV) – EPSG:2174
##Układ współrzędnych 1965 (strefa V) – EPSG:2175
##
##Układ 1992 EPSG:2180
##
##Układ współrzędnych 2000 (strefa V) – EPSG:2176
##Układ współrzędnych 2000 (strefa VI) – EPSG2177
##Układ współrzędnych 2000 (strefa VII) – EPSG:2178
##Układ współrzędnych 2000 (strefa VIII) – EPSG:2179


from geopy.geocoders import ArcGIS
from pyproj import Transformer
import sys
import json
import re


nom =ArcGIS()

WEJSCIE =''
WYJSCIE =''


def trans(adres):
    uklad = {
                '65/1':'3120',
              '65/2' : '2172',
              '65/3' : '2173',
              '65/4' : '2174',
              '65/5' : '2175',
              '1992' : '2180',
              '2000/5' : '2176',
              '2000/6' : '2177',
              '2000/7' : '2178',
              '2000/8' : '2179'
              }

    result = nom.geocode(adres)
    adress = result[0]
    ws = result[1]
    x1 = ws[0]
    y1 = ws[1]

    out={}
    out['adres'] = adress
    for k,v in uklad.items():
        transformer = Transformer.from_crs("epsg:4326", "epsg:"+v)
        x0,y0 = transformer.transform(x1, y1)
##        x0 =int(x0)
##        y0 = int(y0)
        x0 = ('%.2f' %x0)
        y0 = ('%.2f' %y0)
        out[k]= {'x':x0, 'y':y0}

    j = json.dumps(out)
    print(j)



if __name__ == '__main__':

    par  = sys.argv[1]
    trans(par)





