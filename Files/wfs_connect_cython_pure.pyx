# Este código sería idéntico al de CPython ya que no hay optimizaciones de Cython implementadas.

import owslib.wfs

def connect_wfs(url):
    wfs = owslib.wfs.WebFeatureService(url)
    return wfs

def get_features(wfs, typename):
    response = wfs.getfeature(typename=typename)
    return response.read()

def save_gml(data, filename):
    with open(filename, 'wb') as f:
        f.write(data)
    return filename

# Ejemplo de uso
wfs_url = "http://www.secretariadeambiente.gov.co/arcgis/services/MapasVisorGeo/Lote/MapServer/WFSServer"
wfs = connect_wfs(wfs_url)
data = get_features(wfs, 'igm:embalse_a')
filename = save_gml(data, 'data.gml')
print("Archivo guardado:", filename)
