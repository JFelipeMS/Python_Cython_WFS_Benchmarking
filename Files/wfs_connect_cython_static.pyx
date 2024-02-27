# Este código utiliza Cython con definición de variables estáticas para mejorar el rendimiento.

import owslib.wfs
from libc.stdio cimport FILE, fopen, fwrite, fclose

def connect_wfs(url):
    wfs = owslib.wfs.WebFeatureService(url)
    return wfs

def get_features(wfs, typename):
    response = wfs.getfeature(typename=typename)
    return response.read()

def save_gml(data, filename):
    cdef FILE* f
    f = fopen(filename.encode(), 'wb')
    fwrite(data, 1, len(data), f)
    fclose(f)
    return filename

# Ejemplo de uso
wfs_url = "http://www.secretariadeambiente.gov.co/arcgis/services/MapasVisorGeo/Lote/MapServer/WFSServer"
wfs = connect_wfs(wfs_url)
data = get_features(wfs, 'igm:embalse_a')
filename = save_gml(data, 'data.gml')
print("Archivo guardado:", filename)
