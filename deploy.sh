docker build -t $DOCKER_USERNAME/complex-client:$SHA -t $DOCKER_USERNAME/complex-client:latest -f ./client/Dockerfile ./client
docker build -t $DOCKER_USERNAME/complex-server:$SHA -t $DOCKER_USERNAME/complex-server:latest -f ./server/Dockerfile ./server
docker build -t $DOCKER_USERNAME/complex-worker:$SHA -t $DOCKER_USERNAME/complex-worker:latest -f ./worker/Dockerfile ./worker
docker push $DOCKER_USERNAME/complex-client:$SHA
docker push $DOCKER_USERNAME/complex-server:$SHA
docker push $DOCKER_USERNAME/complex-worker:$SHA
docker push $DOCKER_USERNAME/complex-client:latest
docker push $DOCKER_USERNAME/complex-server:latest
docker push $DOCKER_USERNAME/complex-worker:latest
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=$DOCKER_USERNAME/complex-server:$SHA
kubectl set image deployments/client-deployment client=$DOCKER_USERNAME/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=$DOCKER_USERNAME/complex-worker:$SHA