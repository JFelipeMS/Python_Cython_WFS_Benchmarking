import owslib.wfs

def connect_wfs(url):
    wfs = owslib.wfs.WebFeatureService(url)
    return wfs

def get_layer_features(wfs, typename):
    response = wfs.getfeature(typename=typename)
    return response

def extract_attributes_and_geometry(features):
    for feature in features:
        attributes = feature['properties']
        geometry = feature['geometry']
        print("Atributos:", attributes)
        print("Datos espaciales:", geometry)

# Ejemplo de uso
wfs_url = "http://www.secretariadeambiente.gov.co/arcgis/services/MapasVisorGeo/Lote/MapServer/WFSServer"
wfs = connect_wfs(wfs_url)
layer_features = get_layer_features(wfs, 'loteo')
extract_attributes_and_geometry(layer_features)
