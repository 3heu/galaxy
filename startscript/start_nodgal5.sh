#!/bin/bash

progdir="/root"
clgal="${progdir}/clgal/clgal"
kgald="${progdir}/kgald/kgald"
nodgal="${progdir}/nodgal/nodgal"
producer=aprods4
pubkey=GAL6i58nZEJAwhVHvNKLey5UJi8QYmvdtE6CSKyxSCAmcrw3BdQrX
prikey=5KkTDCWodRGJzKRPpJuAnbUjC8gMeFfwwfzA6hXUA3qxwEiNnG6

nodgalname=job5



killprog()
{
	ps -ef |grep -i $1 |grep -v grep |grep -v kill| awk -F ' ' '{print $2}'| while read line
  do
	    echo " proc: $1, pid $line to be kill..."
	    ret=`ps -ef |grep -i $1| awk -F ' ' '{print $2}'|grep $line`
	    if [ $ret ]
	    then
		    echo "kill $line"
		    kill  $line
	    else
		    contine
	    fi
  done
}


#rm -rf *-*
#killprog galaxy


if [ ! -d /root/data/logs ]; then
		if ! mkdir -p "/root/data/logs"  &>/dev/null; then
			 printf "Unable to create directory logs !!\\n" 
			 exit 1;
		fi
fi

if [ ! -d /root/data/$nodgalname ]; then
		if ! mkdir -p "/root/data/$nodgalname"  &>/dev/null; then
			printf "Unable to create directory %s !!\\n"  "${nodgalname}"
			exit 1;
    fi
fi


cd ${progdir}/galaxy-token/
./galaxy_token >> /root/data/logs/galaxy_token_$nodgalname.log 2>&1 &
sleep 1
echo " start galaxy_token.."

cd ${progdir}/galaxy-msig/ 
./galaxy_msig >> /root/data/logs/galaxy_msig_$nodgalname.log 2>&1 &
sleep 1
echo " start galaxy_msig.."
cd ${progdir}/galaxy-system/
./galaxy_system >> /root/data/logs/galaxy_system_$nodgalname.log 2>&1 &
sleep 1
echo " start galaxy_system.."
cd ${progdir}/good/
./good >> /root/data/logs/good_$nodgalname.log 2>&1 &
sleep 1
echo " start good.."

#${kgald} --unlock-timeout 999999999 --http-server-address 127.0.0.1:6666 --wallet-dir /root/data/wallet > /root/data/logs/kgald.log 2>&1 &
#sleep 5
#echo " start wallet.."
${nodgal} \
    ./root/nodgal/nodgal \
    --enable-stale-production false \
    --producer-name $producer \
    --signature-provider=$pubkey=KEY:$prikey \
    --plugin galaxy::block_producer_plugin \
    --plugin galaxy::chain_api_plugin \
    --plugin galaxy::http_plugin \
    --plugin galaxy::net_plugin \
    --plugin galaxy::chain_plugin \
    --http-server-address=10.0.0.6:8005 \
    --p2p-listen-endpoint=10.0.0.6:9005 \
    --p2p-server-address=10.0.0.6:9005 \
    --p2p-peer-address 10.0.0.2:9001 \
    --p2p-peer-address 10.0.0.3:9002 \
    --p2p-peer-address 10.0.0.4:9003 \
    --p2p-peer-address 10.0.0.5:9004 \
    --ice-server-address="tcp -h 127.0.0.1 -p 3322" \
    --access-control-allow-origin=* \
    --contracts-console \
    --data-dir /root/data/$nodgalname \
    --genesis-json /root/genesis.json \
    --http-validate-host=false
echo " start nodgal.." 

while true
do
		sleep 10
done