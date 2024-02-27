# Mismo código que en CPython, no hay optimizaciones específicas de Cython.

import owslib.wfs

def connect_wfs(url):
    wfs = owslib.wfs.WebFeatureService(url)
    return wfs

def download_and_save_gml(wfs, typename, filename):
    response = wfs.getfeature(typename=typename)
    with open(filename, 'wb') as f:
        f.write(bytes(response.read()))

def read_gml(filename):
    with open(filename, 'rb') as f:
        data = f.read()
    return data

# Ejemplo de uso
wfs_url = "http://www.secretariadeambiente.gov.co/arcgis/services/MapasVisorGeo/Lote/MapServer/WFSServer"
wfs = connect_wfs(wfs_url)
download_and_save_gml(wfs, 'loteo', 'data.gml')
data = read_gml('data.gml')
print("Datos GML leídos:", data)
