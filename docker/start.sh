FLINK_PROPERTIES="jobmanager.rpc.address: jobmanager" 
docker network create flink-network
docker run \
    --name=jobmanager -d \
    --network flink-network \
    -p 8081:8081 \
    --env FLINK_PROPERTIES="${FLINK_PROPERTIES}" \
    flink:latest jobmanager
docker run \
    --name=taskmanager -d \
    --network flink-network \
    --env FLINK_PROPERTIES="${FLINK_PROPERTIES}" \
    flink:latest taskmanager
