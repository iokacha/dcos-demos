cd $(dirname $0)

# Create the kubernetes service account
dcos security org service-accounts keypair private-kubernetes.pem public-kubernetes.pem
dcos security org service-accounts delete kubernetes
dcos security org service-accounts create -p public-kubernetes.pem -d kubernetes kubernetes
dcos security secrets delete /kubernetes/private-kubernetes
dcos security secrets create-sa-secret --strict private-kubernetes.pem kubernetes /kubernetes/private-kubernetes
dcos security org users grant kubernetes dcos:mesos:master:reservation:role:kubernetes-role create
dcos security org users grant kubernetes dcos:mesos:master:framework:role:kubernetes-role create
dcos security org users grant kubernetes dcos:mesos:master:task:user:nobody create

# Deploy kubernetes
dcos package install --yes kubernetes --options=options-kubernetes-mke.json --package-version=2.2.0-1.13.3