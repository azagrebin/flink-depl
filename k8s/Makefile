TYPE ?= session
OP ?= create
N ?= 4

depl:
	kubectl $(OP) -f flink-configuration-configmap.yaml
	kubectl $(OP) -f $(TYPE)/jobmanager.yaml
	kubectl $(OP) -f $(TYPE)/taskmanager-deployment.yaml
	kubectl $(OP) -f jobmanager-service.yaml
	kubectl $(OP) -f jobmanager-rest-service.yaml 

scale:
	kubectl scale --replicas=$(N) deployment/flink-taskmanager

session: TYPE=session
session: OP=create
session: depl

job: TYPE=job
job: OP=create
job: depl

delete-session: TYPE=session
delete-session: OP=delete
delete-session: depl

delete-job: TYPE=job
delete-job: OP=delete
delete-job: depl

ssh-pod:
	kubectl exec -it $(POD) -- /bin/bash

# minikube

start-minikube:
	minikube start --driver=hyperkit \
		--extra-config=apiserver.service-node-port-range=1-65535 \
		--mount --mount-string='/Users/azagrebin/projects/flink-depl:/flink-depl'

stop-minikube:
	minikube tunnel --cleanup
	minikube stop

webiu-minikube:
	open http://$(shell minikube ip):8081

ssh-minikube:
	minikube ssh