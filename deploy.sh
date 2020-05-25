docker build -t uazadi/multi-client:latest -t uazadi/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t uazadi/multi-server:latest -t uazadi/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t uazadi/multi-worker:latest -t uazadi/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push uazadi/multi-client:latest
docker push uazadi/multi-server:latest
docker push uazadi/multi-worker:latest

docker push uazadi/multi-client:$GIT_SHA
docker push uazadi/multi-server:$GIT_SHA
docker push uazadi/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=uazadi/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=uazadi/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=uazadi/multi-worker:$GIT_SHA

