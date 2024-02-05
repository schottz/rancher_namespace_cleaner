#!/bin/bash

#######################################################################################################################################
#
# MAKE SURE YOU DON'T HAVE ANY NON RANCHER RELATED NAMESPACE THAT HAVE THESE WORDS IN YOUR CLUSTER: 'CATTLE', 'FLEET', 'LOCAL' AND 'P-'
#
########################################################################################################################################

rancher_namespaces=$(kubectl get ns -o=custom-columns=:metadata.name | grep 'cattle\|p-\|local\|fleet\|user-' )

for namespace in $rancher_namespaces; do
    kubectl delete ns $namespace --force
    kubectl get ns $namespace -o json | jq 'del(.metadata.finalizers)' | jq '.spec = {}' > tempfile.json
    kubectl replace --raw /api/v1/namespaces/$namespace/finalize -f tempfile.json
done