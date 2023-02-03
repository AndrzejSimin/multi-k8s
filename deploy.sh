docker build -t AndrzejSimin/multi-client-k8s:latest -t AndrzejSimin/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t AndrzejSimin/multi-server-k8s-pgfix:latest -t AndrzejSimin/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t AndrzejSimin/multi-worker-k8s:latest -t AndrzejSimin/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push AndrzejSimin/multi-client-k8s:latest
docker push AndrzejSimin/multi-server-k8s-pgfix:latest
docker push AndrzejSimin/multi-worker-k8s:latest

docker push AndrzejSimin/multi-client-k8s:$SHA
docker push AndrzejSimin/multi-server-k8s-pgfix:$SHA
docker push AndrzejSimin/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=AndrzejSimin/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=AndrzejSimin/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=AndrzejSimin/multi-worker-k8s:$SHA