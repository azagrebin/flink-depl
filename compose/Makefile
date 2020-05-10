N ?= 4
T ?= session
CONF ?= docker-compose-$(T).yml
CMD ?= docker-compose -f $(CONF)
JAR ?= /Users/azagrebin/projects/flink-docker/testing/docker-test-job/target/docker-test-job-1.0.jar

edit:
	vim $(CONF)

up:
	$(CMD) up -d

scale:
	$(CMD) up -d --scale taskmanager=$(N)

jm:
	docker exec -it `docker ps --filter name=jobmanager --format={{.ID}}` /bin/sh

conf:
	docker exec -it `docker ps --filter name=jobmanager --format={{.ID}}` cat /opt/flink/conf/flink-conf.yaml

submit-session-job:
	$(eval JOBMANAGER_CONTAINER := $(shell docker ps --filter name=jobmanager --format={{.ID}}))
	@echo $(JOBMANAGER_CONTAINER)
	docker cp $(JAR) "$(JOBMANAGER_CONTAINER)":/job.jar
	docker exec -t -i "$(JOBMANAGER_CONTAINER)" flink run -d -c org.apache.flink.StreamingJob /job.jar

down:
	$(CMD) kill
