#!/bin/bash
data_dir=/tmp/galaxy

cleardocker()
{

    for  line  in  `docker ps -a | grep $1 | awk '{print $1}'`
    do
        docker stop ${line} > /dev/null
        docker rm ${line} > /dev/null
        echo "delete ${line}"
   done
}

echo "start delete nodgal ..."
cleardocker job
echo "end delete nodgal ..."
echo "start delete kgald ..."
cleardocker kgald
echo "end delete kgald ..."
rm -rf $data_dir



