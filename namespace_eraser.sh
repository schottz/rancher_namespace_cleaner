#!/bin/bash

#######################################################################################################################################
#
# MAKE SURE YOU DON'T HAVE ANY NON RANCHER RELATED NAMESPACE THAT HAVE THESE WORDS IN YOUR CLUSTER: 'CATTLE', 'FLEET', 'LOCAL' AND 'P-'
#
########################################################################################################################################

rancher_namespaces=$(kubectl get ns -o=custom-columns=:metadata.name | grep 'cattle\|p-\|local\|fleet\|user-' )

for ns in $rancher_namespaces; do
    kubectl delete $ns --force
done