JAR ?= /Users/azagrebin/projects/flink-docker/testing/docker-test-job/target/docker-test-job-1.0.jar
T ?= session

init-swarm:
	docker swarm init

start:
	./create-flink-$(T).sh

stop:
	./stop.sh $(T)

start-session: T=session
start-session: start

start-job: T=job
start-job: start

stop-session: T=session
stop-session: stop

stop-job: T=job
stop-job: stop

ssh-jm:
	$(eval JOBMANAGER_CONTAINER := $(shell docker ps --filter name=jobmanager --format={{.ID}}))
	@echo $(JOBMANAGER_CONTAINER)
	docker exec -t -i "$(JOBMANAGER_CONTAINER)" sh

submit-session-job:
	$(eval JOBMANAGER_CONTAINER := $(shell docker ps --filter name=jobmanager --format={{.ID}}))
	@echo $(JOBMANAGER_CONTAINER)
	docker cp $(JAR) "$(JOBMANAGER_CONTAINER)":/job.jar
	docker exec -t -i "$(JOBMANAGER_CONTAINER)" flink run -d -c org.apache.flink.StreamingJob /job.jar