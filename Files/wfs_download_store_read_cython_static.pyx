# Implementación con Cython utilizando definición de variables estáticas.

import owslib.wfs
from libc.stdio cimport FILE, fopen, fwrite, fclose

def connect_wfs(url):
    cdef owslib.wfs.WebFeatureService wfs
    wfs = owslib.wfs.WebFeatureService(url)
    return wfs

def download_and_save_gml(wfs, typename, filename):
    response = wfs.getfeature(typename=typename)
    cdef FILE* f
    f = fopen(filename.encode(), 'wb')
    fwrite(bytes(response.read()), 1, len(bytes(response.read())), f)
    fclose(f)

def read_gml(filename):
    cdef FILE* f
    cdef bytes data
    f = fopen(filename.encode(), 'rb')
    fseek(f, 0, 2)  # Seek to the end of the file
    length = ftell(f)  # Get the current position, which is the file size
    fseek(f, 0, 0)  # Seek back to the beginning of the file
    data = fread(length, 1, f)  # Read the entire file
    fclose(f)
    return data

# Ejemplo de uso
wfs_url = "http://www.secretariadeambiente.gov.co/arcgis/services/MapasVisorGeo/Lote/MapServer/WFSServer"
wfs = connect_wfs(wfs_url)
download_and_save_gml(wfs, 'loteo', 'data.gml')
data = read_gml('data.gml')
print("Datos GML leídos:", data)
