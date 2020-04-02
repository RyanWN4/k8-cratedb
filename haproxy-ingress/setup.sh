#Create a default backend that HAProxy can fallback on. Just returns 4040s
kubectl run ingress-default-backend \
  --image=gcr.io/google_containers/defaultbackend:1.0 \
  --port=8080 \
  --limits=cpu=10m,memory=20Mi \
  --expose

#Create configmap for storing HAProxy config
kubectl create configmap haproxy-ingress


kubectl create -f deployment/haproxy-ingress.yml

kubectl create -f ingress/cratedb-extension.yml
