# Rancher Namespace Cleaner


This brief code is aimed to clean garbage namespaces Rancher leaves when you need to reinstall it on your Kubernetes cluster.

When you try to delete namespaces created by rancher during its installation, they usually get stuck on "Terminating" status in your cluster.

So, if you need to clean all the namespace structure left from Rancher, you can simply run these scripts and get rid of them automatically, running:

    $ ./namespace_eraser.sh

This script will filter all namespaces created by Rancher (those who have "Cattle", "Fleet", "Local", "p-", "user-" on their names) and send a kubectl delete --force command at them.

Right after that, it will call the python script (did it in python, because I feel more comfortable with it) that replaces the finalizers information in each raw namespace that make it unable to conclude its deletion.

This solution is an adaptation of this [re:Post Blog post](https://repost.aws/knowledge-center/eks-terminated-namespaces),