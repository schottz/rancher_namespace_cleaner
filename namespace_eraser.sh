#!/bin/bash

#######################################################################################################################################
#
# MAKE SURE YOU DON'T HAVE ANY NON RANCHER RELATED NAMESPACE THAT HAVE THESE WORDS IN YOUR CLUSTER: 'CATTLE', 'FLEET', 'LOCAL' AND 'P-'
#
########################################################################################################################################

cattle_namespaces=$(kubectl get ns -o=custom-columns=:metadata.name | grep cattle )
fleet_namespaces=$(kubectl get ns -o=custom-columns=:metadata.name | grep fleet )
local_namespaces=$(kubectl get ns -o=custom-columns=:metadata.name | grep 'local' )
p_namespaces=$(kubectl get ns -o=custom-columns=:metadata.name | grep 'p-' )

for ns in $cattle_namespaces; do
    kubectl delete $ns
done

for ns in $fleet_namespaces; do
    kubectl delete $ns
done

for ns in $local_namespaces; do
    kubectl delete $ns
done

for ns in $p_namespaces; do
    kubectl delete $ns
done