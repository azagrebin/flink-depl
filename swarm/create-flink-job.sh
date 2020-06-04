#!/bin/sh

################################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

FLINK_PROPERTIES="jobmanager.rpc.address: flink-job-jobmanager
taskmanager.numberOfTaskSlots: 2
"

# Create overlay network
docker network create -d overlay flink-job

# Create the jobmanager service
docker service create --name flink-job-jobmanager \
  --env FLINK_PROPERTIES="${FLINK_PROPERTIES}" \
  --mount type=bind,source="$(pwd)/../test-job/target",target=/opt/flink/usrlib \
  -p 8081:8081 \
  --network flink-job \
  flink standalone-job --job-classname org.apache.flink.StreamingJob

# Create the taskmanager service (scale this out as needed)
docker service create --name flink-job-taskmanager \
  --replicas 2 \
  --env FLINK_PROPERTIES="${FLINK_PROPERTIES}" \
  --mount type=bind,source="$(pwd)/../test-job/target",target=/opt/flink/usrlib \
  --network flink-job \
  flink taskmanager
