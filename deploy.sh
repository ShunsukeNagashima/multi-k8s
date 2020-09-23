docker build -t shunsukenagashima/multi-client:latest -t shunsukenagashima/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shunsukenagashima/multi-server:latest -t shunsukenagashima/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shunsukenagashima/multi-worker:latest -t shunsukenagashima/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push shunsukenagashima/multi-client:latest
docker push shunsukenagashima/multi-server:latest
docker push shunsukenagashima/multi-worker:latest

docker push shunsukenagashima/multi-client:$SHA
docker push shunsukenagashima/multi-server:$SHA
docker push shunsukenagashima/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shunsukenagashima/multi-server:$SHA
kubectl set image deployments/client-deployment clietn=shunsukenagashima/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shunsukenagashima/multi-worker:$SHA