clean-docker-exited:
	cs=(`docker ps -a | grep Exited | awk '{print $12}'`); for c in ${cs[@]}; do docker rm $c; done