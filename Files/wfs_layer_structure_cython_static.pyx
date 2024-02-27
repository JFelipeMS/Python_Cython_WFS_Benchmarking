# Implementación con Cython utilizando definición de variables estáticas.

import owslib.wfs

def connect_wfs(url):
    cdef owslib.wfs.WebFeatureService wfs
    wfs = owslib.wfs.WebFeatureService(url)
    return wfs

def get_layer_structure(wfs, typename):
    cdef owslib.feature.type.FeatureType feature_type
    feature_type = wfs.contents[typename]
    return feature_type

# Ejemplo de uso
wfs_url = "http://www.secretariadeambiente.gov.co/arcgis/services/MapasVisorGeo/Lote/MapServer/WFSServer"
wfs = connect_wfs(wfs_url)
layer_structure = get_layer_structure(wfs, 'loteo')
print("Estructura de la capa 'loteo':", layer_structure)
