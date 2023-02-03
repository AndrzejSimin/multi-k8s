docker build -t andrzejsimin/multi-client-k8s:latest -t andrzejsimin/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t andrzejsimin/multi-server-k8s-pgfix:latest -t andrzejsimin/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t andrzejsimin/multi-worker-k8s:latest -t andrzejsimin/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push andrzejsimin/multi-client-k8s:latest
docker push andrzejsimin/multi-server-k8s-pgfix:latest
docker push andrzejsimin/multi-worker-k8s:latest

docker push andrzejsimin/multi-client-k8s:$SHA
docker push andrzejsimin/multi-server-k8s-pgfix:$SHA
docker push andrzejsimin/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andrzejsimin/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=andrzejsimin/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=andrzejsimin/multi-worker-k8s:$SHA