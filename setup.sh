kubectl create namespace cratedb

kubectl create -f services/crate-internal-service.yaml -n cratedb
kubectl create -f services/crate-headless.yml -n cratedb

kubectl create -f volumes/node1.yml -n cratedb
kubectl create -f volumes/node2.yml -n cratedb
kubectl create -f volumes/node3.yml -n cratedb


kubectl create -f statefulsets/crate-controller.yaml -n cratedb

kubectl create -f haproxy-ingress/rbac/ingress-controller-rbac.yml


kubectl run ingress-default-backend \
  --image=gcr.io/google_containers/defaultbackend:1.0 \
  --port=8080 \
  --limits=cpu=10m,memory=20Mi \
  --expose \
  --namespace cratedb

#Create configmap for storing HAProxy config
kubectl create configmap haproxy-ingress -n cratedb

kubectl create -f haproxy-ingress/rbac/ingress-controller-rbac.yml

kubectl create -f haproxy-ingress/deployment/haproxy-ingress.yml -n cratedb

kubectl create -f haproxy-ingress/ingress/cratedb-extension.yml -n cratedb

kubectl expose deploy/haproxy-ingress --type=NodePort -n cratedb
