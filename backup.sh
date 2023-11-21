#!/bin/bash

echo #######################################'date +%Y%m%d_%H-%M##############################
echo ###										#####
echo ###                                                                                #####
echo ###                                          Running                               #####
echo ###                                                                                #####
echo ###										#####
END=`docker ps --format "{{.Names}}"  | wc -l`
for (( i=1; i<=$END; i++ ))
do
	name=`docker ps --format "{{.Names}}" | head -n $i | tail -1`
	echo $name
	IMAGE="mohajerhos/backups:$name-`date +%Y-%m-%d_%H-%M`"
	echo $IMAGE
	BACKUP="/root/$name-backup-`date +%Y-%m-%d_%H-%M`.tar"
	echo $BACKUP
	docker commit $name $IMAGE
	docker save $IMAGE > $BACKUP
	docker push $IMAGE
done
find ~ -name "*-backup-*.tar" -mtime +7 -exec rm -rf {} \;

echo ###                                                                               ######
echo ###                                                                                #####
echo ###                                                                                #####
echo ###                                          End	                                #####
echo ###                                                                                #####
echo ########################################################################################
