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
import sys, os
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
              '2000 V' : '2176',
              '2000 VI' : '2177',
              '2000 VII' : '2178',
              '2000 VIII' : '2179'
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
        x0 =int(x0)
        y0 = int(y0)
        out[k]= {'x':x0, 'y':y0}

    j = json.dumps(out)
    print(j)

def setUklad(wejscie, wyjscie):
    global WEJSCIE, WYJSCIE
    if wejscie == 'WGS84':
        WEJSCIE = 'epsg:4326'
    elif wejscie == '65/1':
        WEJSCIE = 'epsg:3120'
    elif wejscie == '2000/5':
        WEJSCIE = 'epsg:2176'
    elif wejscie == '2000/6':
        WEJSCIE = 'epsg:2177'
    elif wejscie == '2000/7':
        WEJSCIE = 'epsg:2178'
    elif wejscie == '2000/8':
        WEJSCIE = 'epsg:2179'
    elif wejscie == '1992':
        WEJSCIE = 'epsg:2180'

    if wyjscie == 'WGS84':
        WYJSCIE = 'epsg:4326'
    elif wyjscie == '65/1':
        WYJSCIE = 'epsg:3120'
    elif wyjscie == '65/2':
        WYJSCIE = 'epsg:2172'
    elif wyjscie == '65/3':
        WYJSCIE = 'epsg:2173'
    elif wyjscie == '65/4':
        WYJSCIE = 'epsg:2174'
    elif wyjscie == '65/5':
        WYJSCIE = 'epsg:2175'
    elif wyjscie == '1992':
        WYJSCIE = 'epsg:2180'
    return

def oneTransorm(x, y):
    global WEJSCIE, WYJSCIE
    transformer = Transformer.from_crs(WEJSCIE, WYJSCIE)
    x0,y0 = transformer.transform(x,y)
    out=[]
    out.append(x0)
    out.append(y0)
    return out

def convertData(value):
    lista = value.split(",")
    setUklad(lista[1], lista[2])
    zamiana = lista[3]
    out =''
    value = open(lista[0] , 'r').read()
##    value.close()
    os.remove(lista[0])
    lista = value.split('\n')
    for line in lista:
        if len(line) > 10:
            line = line.split(',')
            if str(zamiana) == 'true':
                y = line[1]
                x = line[2]
            else:
                x = line[1]
                y = line[2]
            result = oneTransorm(x,y)
            x0 = ('%.2f' %result[0])
            y0 = ('%.2f' %result[1])
            out = out+('%s,%s,%s,1' %(line[0],x0,y0))+'\n'

    print(out)


par  = sys.argv[1]
convertData(par)






