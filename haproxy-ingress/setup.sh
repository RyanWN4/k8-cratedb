#Create a default backend that HAProxy can fallback on. Just returns 4040s
kubectl run ingress-default-backend \
  --image=gcr.io/google_containers/defaultbackend:1.0 \
  --port=8080 \
  --limits=cpu=10m,memory=20Mi \
  --expose

#Check if it's running
kubectl get pod

#Create configmap for storing HAProxy config
kubectl create configmap haproxy-ingress
