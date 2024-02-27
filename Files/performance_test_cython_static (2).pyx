#cython: language_level=3

import time
import owslib.wfs
from libc.stdio cimport FILE, fopen, fwrite, fclose

def connect_wfs(url):
    start_time = time.time()
    wfs = owslib.wfs.WebFeatureService(url)
    end_time = time.time()
    connection_time = end_time - start_time
    return connection_time

def download_and_save_gml(wfs, typename, filename):
    start_time = time.time()
    response = wfs.getfeature(typename=typename)
    cdef FILE* f
    f = fopen(filename.encode(), 'wb')
    fwrite(bytes(response.read()), 1, len(bytes(response.read())), f)
    fclose(f)
    end_time = time.time()
    download_time = end_time - start_time
    return download_time

def read_gml(filename):
    start_time = time.time()
    cdef FILE* f
    cdef bytes data
    f = fopen(filename.encode(), 'rb')
    fseek(f, 0, 2)  # Seek to the end of the file
    length = ftell(f)  # Get the current position, which is the file size
    fseek(f, 0, 0)  # Seek back to the beginning of the file
    data = fread(length, 1, f)  # Read the entire file
    fclose(f)
    end_time = time.time()
    read_time = end_time - start_time
    return read_time

# URL del servicio WFS
wfs_url = "http://www.secretariadeambiente.gov.co/arcgis/services/MapasVisorGeo/Lote/MapServer/WFSServer"

# Prueba de conexión a WFS
connection_time = connect_wfs(wfs_url)
print("Tiempo de conexión a WFS:", connection_time, "segundos")

# Prueba de descarga y almacenamiento de GML
wfs = owslib.wfs.WebFeatureService(wfs_url)
download_time = download_and_save_gml(wfs, 'loteo', 'data.gml')
print("Tiempo de descarga y almacenamiento de GML:", download_time, "segundos")

# Prueba de lectura de GML
read_time = read_gml('data
