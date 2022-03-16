docker build -t thanhld97/multi-client:latest -t thanhld97/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t thanhld97/multi-server:latest -t thanhld97/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t thanhld97/multi-worker:latest -t thanhld97/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push thanhld97/multi-client:latest
docker push thanhld97/multi-server:latest
docker push thanhld97/multi-worker:latest

docker push thanhld97/multi-client:$SHA
docker push thanhld97/multi-server:$SHA
docker push thanhld97/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=thanhld97/multi-server:$SHA
kubectl set image deployments/client-deployment client=thanhld97/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thanhld97/multi-worker:$SHA