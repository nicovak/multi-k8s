docker build -t nicovak/multi-client:latest -t nicovak/multi-client:"$SHA" -f ./client/Dockerfile ./client
docker build -t nicovak/multi-server:latest -t nicovak/multi-server:"$SHA" -f ./server/Dockerfile ./server
docker build -t nicovak/multi-worker:latest -t nicovak/multi-worker:"$SHA" -f ./worker/Dockerfile ./worker

docker push nicovak/multi-client:latest
docker push nicovak/multi-server:latest
docker push nicovak/multi-worker:latest

docker push nicovak/multi-client:"$SHA"
docker push nicovak/multi-server:"$SHA"
docker push nicovak/multi-worker:"$SHA"

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=nicovak/multi-server:"$SHA"
kubectl set image deployments/client-deployment client=nicovak/multi-client:"$SHA"
kubectl set image deployments/worker-deployment worker=nicovak/multi-worker:"$SHA"
