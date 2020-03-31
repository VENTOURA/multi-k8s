docker build -t 20742074/multi-client:latest -t 20742074/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t 20742074/multi-server:latest -t 20742074/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 20742074/multi-worker:latest -t 20742074/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push 20742074/multi-client:latest
docker push 20742074/multi-server:latest
docker push 20742074/multi-worker:latest

docker push 20742074/multi-client:$SHA
docker push 20742074/multi-server:$SHA
docker push 20742074/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=20742074/multi-server:$SHA
kubectl set image deployments/client-deployment client=20742074/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=20742074/multi-worker:$SHA
