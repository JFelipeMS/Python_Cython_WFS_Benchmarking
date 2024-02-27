import time
import owslib.wfs

def connect_wfs(url):
    start_time = time.time()
    wfs = owslib.wfs.WebFeatureService(url)
    end_time = time.time()
    connection_time = end_time - start_time
    return connection_time

def download_and_save_gml(wfs, typename, filename):
    start_time = time.time()
    response = wfs.getfeature(typename=typename)
    with open(filename, 'wb') as f:
        f.write(bytes(response.read()))
    end_time = time.time()
    download_time = end_time - start_time
    return download_time

def read_gml(filename):
    start_time = time.time()
    with open(filename, 'rb') as f:
        data = f.read()
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
read_time = read_gml('data.gml')
print("Tiempo de lectura de GML:", read_time, "segundos")

# Guardar los tiempos en un archivo
with open('results_cpython.txt', 'w') as file:
    file.write(f"Tiempo de conexión a WFS: {connection_time} segundos\n")
    file.write(f"Tiempo de descarga y almacenamiento de GML: {download_time} segundos\n")
    file.write(f"Tiempo de lectura de GML: {read_time} segundos\n")
