# Mismo código que en CPython, no hay optimizaciones específicas de Cython.

import owslib.wfs

def connect_wfs(url):
    wfs = owslib.wfs.WebFeatureService(url)
    return wfs

def get_layer_structure(wfs, typename):
    feature_type = wfs.contents[typename]
    return feature_type

# Ejemplo de uso
wfs_url = "http://www.secretariadeambiente.gov.co/arcgis/services/MapasVisorGeo/Lote/MapServer/WFSServer"
wfs = connect_wfs(wfs_url)
layer_structure = get_layer_structure(wfs, 'loteo')
print("Estructura de la capa 'loteo':", layer_structure)
