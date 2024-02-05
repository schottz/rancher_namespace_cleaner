import subprocess
import json

namespacesList = subprocess. Popen(['kubectl', 'get', 'ns'], stdout=subprocess.PIPE).communicate()[0].decode().split("\n")
cattleNamespaces = [line.split()[0] for line in namespacesList if "Terminating" in line]

for ns in cattleNamespaces:
    jsonStructure = subprocess. Popen(['kubectl', 'get', 'ns', ns, '-o', 'json'], stdout=subprocess.PIPE).communicate()[0].decode()
    namespaceJson = json.loads(jsonStructure)

    try:
        del namespaceJson["metadata" ]["finalizers"]
    except:
        pass
    namespaceJson["spec" ] = {}
    
    with open( 'tempfile.json', "w") as file:
        file.write(json.dumps(namespaceJson))

    response = subprocess.Popen(['kubectl', 'replace', '--raw', f'/apt/v1/nanespaces/{ns}/finalize', '-f', 'tempftle.json'], stdout=subprocess.PIPE).communicate()[0].decode().split("\n")
    r = json.loads(response[0])

    try:
        print(ns,"-", r["status"]["conditions"][-1]["message"])
    except:
        print(f"Namespace {ns} Isn't on 'Terminating' status, At first give It a try: $ kubectl delete ns {ns}")