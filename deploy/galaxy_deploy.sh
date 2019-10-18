#!/bin/bash

data_dir=/tmp/galaxy/data
image_name=galaxy
image_version=1.0.1
network_name=gal_net
wallet_url=http://10.0.0.24:8900
nodgal_url=http://10.0.0.2:8001
producer1=galaxy
pubkey1=GAL6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
prikey1=5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
producer2=aprods1
pubkey2=GAL6BZxjPemrsBRmfCDHf3afvJ4t7JDcNE3UXMudPsE4ezCMUJsWk
prikey2=5KexNTtncryJnof5SsKUH2nE9BYdCemsgiNkQQxJnjSG6HaUYVR
producer3=aprods2
pubkey3=GAL89Uj4bAVRDwP99VmjcL2Us6TebzsJRTfvbTNo4bmEioMwC2FTV
prikey3=5JbFfhtjUkL1RsZsW1MXxzG21pYSJwVQR6UFbvJAEtjwtGtgiAV
producer4=aprods3
pubkey4=GAL7Dg55w6aMc1drsQzGWyKz6mfAgQ744nad8cY8cZ3NEGXk97XVG
prikey4=5JTF8EmWDVKd7cDfJxny7e154UmjwkL91RnMdson9ZqoFBX4CsC
producer5=aprods4
pubkey5=GAL6i58nZEJAwhVHvNKLey5UJi8QYmvdtE6CSKyxSCAmcrw3BdQrX
prikey5=5KkTDCWodRGJzKRPpJuAnbUjC8gMeFfwwfzA6hXUA3qxwEiNnG6
producer6=aprods5
pubkey6=GAL84BLRbGbFahNJEpnnJHYCoW9QPbQEk2iHsHGGS6qcVUq9HhutG
prikey6=5KAVVPzPZnbAx8dHz6UWVPFDVFtU1P5ncUzwHGQFuTxnEbdHJL4
producer7=sprods1
pubkey7=GAL6YbMDQkoVv6nPEQ4hLiVT9PT2XYKRrkCLq6g9rxhdwbm9D9swp
prikey7=5KaZgdzBV4STUWkRzWsAFAFDuXQvBCPW2bkGxj4bkx5cd2uEbJw
producer8=sprods2
pubkey8=GAL5KT2TZDvobRot9GvUCM8VtBoKyDoE2LpihUdJUSC2hnq7fPuj3
prikey8=5JkFRF4eCbYTbQ74K8MDpqZiexiBEuyPvhNkg7vS3f9VDXXFzvj
producer9=sprods3
pubkey9=GAL5JP2xyiZ4J8JuVprYr7VV5d7V3GhozusDUqJgJSW1sMZkmMMtS
prikey9=5JxDmiJfiAUjDtAfu5WRLyoTidmUQytFdWWFPLhQJkJH1xSR85T
producer10=sprods4
pubkey10=GAL6xs6kBVLpDfAn97yY9m3j5bZctousUHcgwijA6yD2UeLWjD1dY
prikey10=5Jwn7tQWwubHj3vNvAhn3dQH7zohhvpT9V81jbBsFVr2PaPCvwb

nodgalname1=job1
nodgalname2=job2
nodgalname3=job3
nodgalname4=job4
nodgalname5=job5
nodgalname6=job6
nodgalname7=job7
nodgalname8=job8
nodgalname9=job9
nodgalname10=job10
jobname=job

bldred='\e[2;31m'
bldgreen='\e[2;32m'
bldyellow='\e[2;33m'
txtrst='\e[0m'


cleardockerjob()
{

    for  line  in  `docker ps -a | grep $1 | awk '{print $1}'`
    do
    	  tmp=`docker ps -a | grep ${line} | cut -d',' -f2 | awk '{print $2}'`
    	  if [ -n "$tmp" ]; then 
    	     printf "delete nodgal %s !!\\n" "${tmp}"
    	  else
    	     printf "delete nodgal %s !!\\n" "$1"
    	  fi
        docker stop ${line} > /dev/null
        docker rm ${line} > /dev/null
        
    done
}

cleardockerwallet()
{

    for  line  in  `docker ps -a | grep $1 | awk '{print $1}'`
    do
    	  printf "delete nodgal %s !!\\n" "$1"

        docker stop ${line} > /dev/null
        docker rm ${line} > /dev/null
        
    done
}

clear_data()
{
    printf "${bldgreen}/***GALAXY******************* delete nodgal start ...!!*********************GALAXY***/\\n${txtrst}" 
    cleardockerjob $jobname
    printf "${bldgreen}/***GALAXY******************* delete nodgal end   ...!!*********************GALAXY***/\\n${txtrst}"

    printf "${bldgreen}/***GALAXY******************* delete kgald start  ...!!*********************GALAXY***/\\n${txtrst}"  
    cleardockerwallet kgald
    printf "${bldgreen}/***GALAXY******************* delete  kgald  end  ...!!*********************GALAXY***/\\n${txtrst}"

    printf "${bldgreen}/***GALAXY**************** delete history data start ...!!******************GALAXY***/\\n${txtrst}"
    if [ -d "$data_dir" ]; then
		   if  ! rm -rf $data_dir/* ; then
			    printf "${bldred}/***GALAXY**************** delete history date error  !!********************GALAXY***/\\n${txtrst}"  
			    exit 1;
		   fi
		   printf "delete buffer data!!\\n"
    fi
    printf "${bldgreen}/***GALAXY**************** delete history data end ...!!********************GALAXY***/\\n${txtrst}"
    
    
    
}



create_network()
{
    printf "${bldgreen}/***GALAXY***************** create docker network...!!**********************GALAXY***/\\n${txtrst}" 
    network=`docker network ls | grep $network_name | awk '{print $2}'`
    if [ -n "$network" ]; then
        docker network rm $network_name
        if [ $? -ne 0 ]; then
	          printf "${bldred}/***GALAXY***************** delete old docker network error!!***************GALAXY***/\\n${txtrst}"
		        exit 1;
        fi
        printf "delete old docker network %s\\n"	"${network_name}"
    fi

    docker network create --driver bridge --subnet=10.0.0.0/24 --gateway 10.0.0.1 $network_name
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** create docker network error!!*******************GALAXY***/\\n${txtrst}"   
		    exit 1;
    fi
    printf "${bldgreen}/***GALAXY*************** create docker network Successfully...!!**********GALAXY***/\\n${txtrst}" 
}
#start service
start_docker()
{
	  printf "${bldgreen}/***GALAXY***************** docker %s start ...!!***********************GALAXY***/\\n${txtrst}" "$nodgalname1"
    docker run --name $nodgalname1 -v $data_dir/$nodgalname1:/root/data/$nodgalname1 -v $data_dir/logs:/root/data/logs -d -p 8001:8001 -p 9001:9001 --ip 10.0.0.2 --network $network_name -it $image_name:$image_version /bin/bash -c \
        "/root/startscript/start_nodgal1.sh"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** docker nodgal start error!!*********************GALAXY***/\\n${txtrst}" "$nodgalname1"
		    exit 1;
    fi
    sleep 6 
    printf "${bldgreen}/***GALAXY***************** docker %s end ...!!*************************GALAXY***/\\n${txtrst}" "$nodgalname1" 
    
    printf "${bldgreen}/***GALAXY***************** docker %s start ...!!**********************GALAXY***/\\n${txtrst}" "$nodgalname2"
    docker run --name $nodgalname2 -v $data_dir/$nodgalname2:/root/data/$nodgalname2 -v $data_dir/logs:/root/data/logs -d -p 8002:8002 -p 9002:9002 --ip 10.0.0.3 --network $network_name -it $image_name:$image_version /bin/bash -c \
       "/root/startscript/start_nodgal2.sh" 
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** docker %s start error!!********************GALAXY***/\\n${txtrst}" "$nodgalname2"
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY***************** docker %s end ...!!************************GALAXY***/\\n${txtrst}" "$nodgalname2"
    
    printf "${bldgreen}/***GALAXY***************** docker %s start ...!!**********************GALAXY***/\\n${txtrst}" "$nodgalname3"
    docker run --name $nodgalname3 -v $data_dir/$nodgalname3:/root/data/$nodgalname3 -v $data_dir/logs:/root/data/logs -d -p 8003:8003 -p 9003:9003 --ip 10.0.0.4 --network $network_name -it $image_name:$image_version /bin/bash -c \
        "/root/startscript/start_nodgal3.sh"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** docker %s start error!!********************GALAXY***/\\n${txtrst}" "$nodgalname3"
		    exit 1;
    fi 
    sleep 6 
    printf "${bldgreen}/***GALAXY***************** docker %s end ...!!************************GALAXY***/\\n${txtrst}" "$nodgalname3"

    printf "${bldgreen}/***GALAXY***************** docker %s start ...!!**********************GALAXY***/\\n${txtrst}" "$nodgalname4"
    docker run --name $nodgalname4 -v $data_dir/$nodgalname4:/root/data/$nodgalname4 -v $data_dir/logs:/root/data/logs -d -p 8004:8004 -p 9004:9004 --ip 10.0.0.5 --network $network_name -it $image_name:$image_version /bin/bash -c \
        "/root/startscript/start_nodgal4.sh"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** docker %s start error!!********************GALAXY***/\\n${txtrst}" "$nodgalname4"
		    exit 1;
    fi
    sleep 6 
    printf "${bldgreen}/***GALAXY***************** docker %s end ...!!************************GALAXY***/\\n${txtrst}" "$nodgalname4"
    
    printf "${bldgreen}/***GALAXY***************** docker %s start ...!!**********************GALAXY***/\\n${txtrst}" "$nodgalname5"
    docker run --name $nodgalname5 -v $data_dir/$nodgalname5:/root/data/$nodgalname5 -v $data_dir/logs:/root/data/logs -d -p 8005:8005 -p 9005:9005 --ip 10.0.0.6 --network $network_name -it $image_name:$image_version /bin/bash -c \
        "/root/startscript/start_nodgal5.sh"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** docker %s start error!!********************GALAXY***/\\n${txtrst}" "$nodgalname5"
		    exit 1;
    fi
    sleep 6 
    printf "${bldgreen}/***GALAXY***************** docker %s end ...!!************************GALAXY***/\\n${txtrst}" "$nodgalname5"
    
    printf "${bldgreen}/***GALAXY***************** docker %s start ...!!**********************GALAXY***/\\n${txtrst}" "$nodgalname6"
    docker run --name $nodgalname6 -v $data_dir/$nodgalname6:/root/data/$nodgalname6 -v $data_dir/logs:/root/data/logs -d -p 8006:8006 -p 9006:9006 --ip 10.0.0.7 --network $network_name -it $image_name:$image_version /bin/bash -c \
        "/root/startscript/start_nodgal6.sh"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** docker %s start error!!********************GALAXY***/\\n${txtrst}" "$nodgalname6"
		    exit 1;
    fi
    sleep 6 
    printf "${bldgreen}/***GALAXY***************** docker %s end ...!!************************GALAXY***/\\n${txtrst}" "$nodgalname6"
    
    printf "${bldgreen}/***GALAXY***************** docker %s start ...!!**********************GALAXY***/\\n${txtrst}" "$nodgalname7"
    docker run --name $nodgalname7 -v $data_dir/$nodgalname7:/root/data/$nodgalname7 -v $data_dir/logs:/root/data/logs -d -p 8007:8007 -p 9007:9007 --ip 10.0.0.8 --network $network_name -it $image_name:$image_version /bin/bash -c \
        "/root/startscript/start_nodgal7.sh"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** docker %s start error!!********************GALAXY***/\\n${txtrst}" "$nodgalname7"
		    exit 1;
    fi
    sleep 6 
    printf "${bldgreen}/***GALAXY***************** docker %s end ...!!************************GALAXY***/\\n${txtrst}" "$nodgalname7"
    
    printf "${bldgreen}/***GALAXY***************** docker %s start ...!!**********************GALAXY***/\\n${txtrst}" "$nodgalname8"
    docker run --name $nodgalname8 -v $data_dir/$nodgalname8:/root/data/$nodgalname8 -v $data_dir/logs:/root/data/logs -d -p 8008:8008 -p 9008:9008 --ip 10.0.0.9 --network $network_name -it $image_name:$image_version /bin/bash -c \
        "/root/startscript/start_nodgal8.sh"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** docker %s start error!!********************GALAXY***/\\n${txtrst}" "$nodgalname8"
		    exit 1;
    fi
    sleep 6 
    printf "${bldgreen}/***GALAXY***************** docker %s end ...!!************************GALAXY***/\\n${txtrst}" "$nodgalname8"
    
    printf "${bldgreen}/***GALAXY***************** docker %s start ...!!**********************GALAXY***/\\n${txtrst}" "$nodgalname9"
    docker run --name $nodgalname9 -v $data_dir/$nodgalname9:/root/data/$nodgalname9 -v $data_dir/logs:/root/data/logs -d -p 8009:8009 -p 9009:9009 --ip 10.0.0.10 --network $network_name -it $image_name:$image_version /bin/bash -c \
        "/root/startscript/start_nodgal9.sh"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** docker %s start error!!********************GALAXY***/\\n${txtrst}" "$nodgalname9"
		    exit 1;
    fi
    sleep 6 
    printf "${bldgreen}/***GALAXY***************** docker %s end ...!!************************GALAXY***/\\n${txtrst}" "$nodgalname9"
    
    printf "${bldgreen}/***GALAXY***************** docker %s start ...!!**********************GALAXY***/\\n${txtrst}" "$nodgalname10"
    docker run --name $nodgalname10 -v $data_dir/$nodgalname10:/root/data/$nodgalname10 -v $data_dir/logs:/root/data/logs -d -p 8010:8010 -p 9010:9010 --ip 10.0.0.11 --network $network_name -it $image_name:$image_version /bin/bash -c \
        "/root/startscript/start_nodgal10.sh"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY***************** docker %s start error!!********************GALAXY***/\\n${txtrst}" "$nodgalname10"
		    exit 1;
    fi
    sleep 6 
    printf "${bldgreen}/***GALAXY***************** docker %s end ...!!************************GALAXY***/\\n${txtrst}" "$nodgalname10"
    
    printf "${bldgreen}/***GALAXY***************** docker wallet start ...!!************************GALAXY***/\\n${txtrst}"
    docker run \
      --name kgald  -v $data_dir/galaxy-wallet:/root/galaxy-wallet -d -p 8900:8900 \
      --ip 10.0.0.24 \
      --network $network_name \
      $image_name:$image_version /bin/bash -c \
      "./root/kgald/kgald \
        --http-server-address=10.0.0.24:8900 \
        --access-control-allow-origin=* \
        --http-validate-host=false " 
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY********************* docker wallet start error!!******************GALAXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY***************** docker kgald end ...!!**************************GALAXY***/\\n${txtrst}"
 
}

exec_command()
{
    #execute  command
    printf "${bldgreen}/***GALAXY***************** create default wallet !!*************************GALAXY**/\\n"
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet create --to-console\\n" "${wallet_url}" "${nodgal_url}"
    tmp=`docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url wallet create --to-console`
    export password=`echo $tmp | awk -F"\"" '{print $2}'`
    echo "$password" > key.txt
    echo "get password : $password"
    #import wallet
    printf "${bldgreen}/***GALAXY************** wallet import private key start ... !!*************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet import --private-key %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${prikey1}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  wallet import --private-key $prikey1
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet import --private-key %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${prikey2}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  wallet import --private-key $prikey2
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet import --private-key %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${prikey3}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  wallet import --private-key $prikey3
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet import --private-key %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${prikey4}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  wallet import --private-key $prikey4
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet import --private-key %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${prikey5}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  wallet import --private-key $prikey5
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet import --private-key %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${prikey6}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  wallet import --private-key $prikey6
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet import --private-key %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${prikey7}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  wallet import --private-key $prikey7
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet import --private-key %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${prikey8}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  wallet import --private-key $prikey8
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet import --private-key %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${prikey9}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  wallet import --private-key $prikey9
    printf "${bldyellow}clgal --wallet-url %s --url %s wallet import --private-key %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${prikey10}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  wallet import --private-key $prikey10
    
    printf "${bldgreen}/***GALAXY************** wallet import private key end ... !!***************GALAXY***/\\n${txtrst}"
    #create systemaccount
    printf "${bldgreen}/***GALAXY***************** create system account start ... !!***************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s create account galaxy galaxy.bpay %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${pubkey1}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url create account galaxy galaxy.bpay $pubkey1
    printf "${bldyellow}clgal --wallet-url %s --url %s create account galaxy galaxy.msig %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${pubkey1}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url create account galaxy galaxy.msig $pubkey1
    printf "${bldyellow}clgal --wallet-url %s --url %s create account galaxy galaxy.names %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${pubkey1}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url create account galaxy galaxy.names $pubkey1
    printf "${bldyellow}clgal --wallet-url %s --url %s create account galaxy galaxy.ram %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${pubkey1}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url create account galaxy galaxy.ram  $pubkey1
    printf "${bldyellow}clgal --wallet-url %s --url %s create account galaxy galaxy.rfee %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${pubkey1}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url create account galaxy galaxy.rfee $pubkey1
    printf "${bldyellow}clgal --wallet-url %s --url %s create account galaxy galaxy.save %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${pubkey1}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url create account galaxy galaxy.save $pubkey1
    printf "${bldyellow}clgal --wallet-url %s --url %s create account galaxy galaxy.stake %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${pubkey1}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url create account galaxy galaxy.stake $pubkey1
    printf "${bldyellow}clgal --wallet-url %s --url %s create account galaxy galaxy.token %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${pubkey1}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url create account galaxy galaxy.token $pubkey1
    printf "${bldyellow}clgal --wallet-url %s --url %s create account galaxy galaxy.vpay %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${pubkey1}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url create account galaxy galaxy.vpay $pubkey1
    printf "${bldyellow}clgal --wallet-url %s --url %s create account galaxy galaxy.bwfee %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${pubkey1}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url create account galaxy galaxy.bwfee $pubkey1
    sleep 6
    printf "${bldgreen}/***GALAXY****************** create system account end ... !!****************GALAXY***/\\n${txtrst}"  

    printf "${bldgreen}/***GALAXY****************** load token contract start ... !!***************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s set contract galaxy.token  /root/build/contracts/galaxy.token/ tokenContract:tcp -h 127.0.0.1  -p 2233  -t 10 -p galaxy.token@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url set contract galaxy.token  /root/build/contracts/galaxy.token/ "tokenContract:tcp -h 127.0.0.1  -p 2233  -t 10" -p galaxy.token@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** load token contract error!!********************GALAXY***/\\n${txtrst}"  
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** load token contract end ... !!*****************GALAXY***/\\n${txtrst}"

    printf "${bldgreen}/***GALAXY***************** load msig contract start ... !!*****************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s set contract galaxy.msig /root/build/contracts/galaxy.msig/ msigContract:tcp -h 127.0.0.1  -p 2244  -t 10 -p galaxy.msig@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url set contract galaxy.msig /root/build/contracts/galaxy.msig/ "msigContract:tcp -h 127.0.0.1  -p 2244  -t 10" -p galaxy.msig@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** load msig contract error!!*********************GALXY***/\\n${txtrst}"
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** load msig contract end ... !!******************GALAXY***/\\n${txtrst}" 

    printf "${bldyellow}clgal --wallet-url %s --url %s push action galaxy.token create [galaxy, 100000000.0000 SYS] -p galaxy.token\\n${txtrst}" "${wallet_url}" "${nodgal_url}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url push action galaxy.token create '["galaxy", "100000000.0000 SYS"]' -p galaxy.token
    sleep 6

    printf "${bldyellow}clgal --wallet-url %s --url %s push action galaxy.token issue [galaxy, 90000000.0000 SYS, memo] -p galaxy\\n${txtrst}" "${wallet_url}" "${nodgal_url}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url push action galaxy.token issue '["galaxy", "90000000.0000 SYS", "memo"]' -p galaxy
    sleep 6

    printf "${bldgreen}/***GALAXY****************** load system contract start ... !!**************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s set contract galaxy  /root/build/contracts/galaxy.system/ systemContract:tcp -h 127.0.0.1  -p 2255  -t 10 -p galaxy@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url set contract galaxy   /root/build/contracts/galaxy.system/ "systemContract:tcp -h 127.0.0.1  -p 2255  -t 10" -p galaxy@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** load system contract error!!*******************GALAXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** load system contract end ... !!****************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s push action galaxy setpriv [galaxy.msig, 1] -p galaxy@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url push action galaxy setpriv '["galaxy.msig", 1]' -p galaxy@active
    sleep 6

    printf "${bldgreen}/***GALAXY****************** create account two start ...!!*****************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s system newaccount galaxy %s %s --stake-net 1000.0000 SYS --stake-cpu 1000.0000 SYS --buy-ram 2000.0000 SYS\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer2}" "${pubkey2}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url system newaccount galaxy $producer2 $pubkey2 --stake-net "1000.0000 SYS" --stake-cpu "1000.0000 SYS" --buy-ram "2000.0000 SYS"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** create account two error!!*********************GALXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** create account two end ...!!*******************GALAXY***/\\n${txtrst}"

    printf "${bldgreen}/***GALAXY****************** create account three start ...!!***************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s system newaccount galaxy %s %s --stake-net 1000.0000 SYS --stake-cpu 1000.0000 SYS --buy-ram 2000.0000 SYS\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer3}" "${pubkey3}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url system newaccount galaxy $producer3 $pubkey3 --stake-net "1000.0000 SYS" --stake-cpu "1000.0000 SYS" --buy-ram "2000.0000 SYS"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** create account three error!!*******************GALAXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** create account three end ...!!*****************GALAXY***/\\n${txtrst}"

    printf "${bldgreen}/***GALAXY****************** create account four start ...!!****************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s system newaccount galaxy %s %s --stake-net 1000.0000 SYS --stake-cpu 1000.0000 SYS --buy-ram 2000.0000 SYS\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer4}" "${pubkey4}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url system newaccount galaxy $producer4 $pubkey4 --stake-net "1000.0000 SYS" --stake-cpu "1000.0000 SYS" --buy-ram "2000.0000 SYS"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** create account four error!!********************GALAXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** create account four end ...!!******************GALAXY***/\\n${txtrst}"
    
    printf "${bldgreen}/***GALAXY****************** create account five start ...!!****************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s system newaccount galaxy %s %s --stake-net 1000.0000 SYS --stake-cpu 1000.0000 SYS --buy-ram 2000.0000 SYS\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer5}" "${pubkey5}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url system newaccount galaxy $producer5 $pubkey5 --stake-net "1000.0000 SYS" --stake-cpu "1000.0000 SYS" --buy-ram "2000.0000 SYS"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** create account five error!!********************GALAXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** create account five end ...!!******************GALAXY***/\\n${txtrst}"
    
    printf "${bldgreen}/***GALAXY****************** create account six start ...!!****************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s system newaccount galaxy %s %s --stake-net 1000.0000 SYS --stake-cpu 1000.0000 SYS --buy-ram 2000.0000 SYS\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer6}" "${pubkey6}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url system newaccount galaxy $producer6 $pubkey6 --stake-net "1000.0000 SYS" --stake-cpu "1000.0000 SYS" --buy-ram "2000.0000 SYS"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** create account six error!!********************GALAXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** create account six end ...!!******************GALAXY***/\\n${txtrst}"
    
    printf "${bldgreen}/***GALAXY****************** create account seven start ...!!****************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s system newaccount galaxy %s %s --stake-net 1000.0000 SYS --stake-cpu 1000.0000 SYS --buy-ram 2000.0000 SYS\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer7}" "${pubkey7}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url system newaccount galaxy $producer7 $pubkey7 --stake-net "1000.0000 SYS" --stake-cpu "1000.0000 SYS" --buy-ram "2000.0000 SYS"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** create account seven error!!********************GALAXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** create account seven end ...!!******************GALAXY***/\\n${txtrst}"
    
    printf "${bldgreen}/***GALAXY****************** create account eight start ...!!****************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s system newaccount galaxy %s %s --stake-net 1000.0000 SYS --stake-cpu 1000.0000 SYS --buy-ram 2000.0000 SYS\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer8}" "${pubkey8}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url system newaccount galaxy $producer8 $pubkey8 --stake-net "1000.0000 SYS" --stake-cpu "1000.0000 SYS" --buy-ram "2000.0000 SYS"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** create account eight error!!********************GALAXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** create account eight end ...!!******************GALAXY***/\\n${txtrst}"
    
    printf "${bldgreen}/***GALAXY****************** create account nine start ...!!****************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s system newaccount galaxy %s %s --stake-net 1000.0000 SYS --stake-cpu 1000.0000 SYS --buy-ram 2000.0000 SYS\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer9}" "${pubkey9}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url system newaccount galaxy $producer9 $pubkey9 --stake-net "1000.0000 SYS" --stake-cpu "1000.0000 SYS" --buy-ram "2000.0000 SYS"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** create account nine error!!********************GALAXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** create account nine end ...!!******************GALAXY***/\\n${txtrst}"
    
    printf "${bldgreen}/***GALAXY****************** create account ten start ...!!****************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s system newaccount galaxy %s %s --stake-net 1000.0000 SYS --stake-cpu 1000.0000 SYS --buy-ram 2000.0000 SYS\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer10}" "${pubkey10}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url system newaccount galaxy $producer10 $pubkey10 --stake-net "1000.0000 SYS" --stake-cpu "1000.0000 SYS" --buy-ram "2000.0000 SYS"
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** create account ten error!!********************GALAXY***/\\n${txtrst}" 
		    exit 1;
    fi
    sleep 6
    printf "${bldgreen}/***GALAXY****************** create account ten end ...!!******************GALAXY***/\\n${txtrst}"
     
    printf "${bldgreen}/***GALAXY****************** regproducer  start ... !!**********************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s system regproducer %s %s 10.0.0.3 -p %s@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer2}" "${pubkey2}" "${producer2}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  system regproducer $producer2 $pubkey2 10.0.0.3 -p $producer2@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** regproducer %s error!!********************GALAXY***/\\n${txtrst}" "${producer2}"
		    exit 1;
    fi
    sleep 6
    
    printf "${bldyellow}clgal --wallet-url %s --url %s system regproducer %s %s 10.0.0.4 -p %s@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer3}" "${pubkey3}" "${producer3}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  system regproducer $producer3 $pubkey3 10.0.0.4 -p $producer3@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** regproducer %s error!!********************GALAXY***/\\n${txtrst}" "${producer3}"
		    exit 1;
    fi
    sleep 6
    
    printf "${bldyellow}clgal --wallet-url %s --url %s system regproducer %s %s 10.0.0.5 -p %s@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer4}" "${pubkey4}" "${producer4}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  system regproducer $producer4 $pubkey4 10.0.0.5 -p $producer4@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** regproducer %s error!!********************GALAXY***/\\n${txtrst}" "${producer4}"
		    exit 1;
    fi
    sleep 6

    printf "${bldyellow}clgal --wallet-url %s --url %s system regproducer %s %s 10.0.0.6 -p %s@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer5}" "${pubkey5}" "${producer5}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  system regproducer $producer5 $pubkey5 10.0.0.6 -p $producer5@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** regproducer %s error!!********************GALAXY***/\\n${txtrst}" "${producer5}"
		    exit 1;
    fi
    sleep 6
    
    printf "${bldyellow}clgal --wallet-url %s --url %s system regproducer %s %s 10.0.0.7 -p %s@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer6}" "${pubkey6}" "${producer6}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  system regproducer $producer6 $pubkey6 10.0.0.7 -p $producer6@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** regproducer %s error!!********************GALAXY***/\\n${txtrst}" "${producer6}"
		    exit 1;
    fi
    sleep 6
    
    printf "${bldyellow}clgal --wallet-url %s --url %s system regproducer %s %s 10.0.0.8 -p %s@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer7}" "${pubkey7}" "${producer7}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  system regproducer $producer7 $pubkey7 10.0.0.8 -p $producer7@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** regproducer %s error!!********************GALAXY***/\\n${txtrst}" "${producer7}"
		    exit 1;
    fi
    sleep 6
    
    printf "${bldyellow}clgal --wallet-url %s --url %s system regproducer %s %s 10.0.0.9 -p %s@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer8}" "${pubkey8}" "${producer8}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  system regproducer $producer8 $pubkey8 10.0.0.9 -p $producer8@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** regproducer %s error!!********************GALAXY***/\\n${txtrst}" "${producer8}"
		    exit 1;
    fi
    sleep 6
    
    printf "${bldyellow}clgal --wallet-url %s --url %s system regproducer %s %s 10.0.0.10 -p %s@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer9}" "${pubkey9}" "${producer9}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  system regproducer $producer9 $pubkey9 10.0.0.10 -p $producer9@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** regproducer %s error!!********************GALAXY***/\\n${txtrst}" "${producer9}"
		    exit 1;
    fi
    sleep 6
    
    printf "${bldyellow}clgal --wallet-url %s --url %s system regproducer %s %s 10.0.0.11 -p %s@active\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer10}" "${pubkey10}" "${producer10}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url  system regproducer $producer10 $pubkey10 10.0.0.11 -p $producer10@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** regproducer %s error!!********************GALAXY***/\\n${txtrst}" "${producer10}"
		    exit 1;
    fi
    sleep 6
    
    printf "${bldgreen}/***GALAXY****************** regproducer  end ... !!************************GALAXY***/\\n${txtrst}"
    
    printf "${bldgreen}/***GALAXY****************** voteproducer  start ... !!*********************GALAXY***/\\n${txtrst}"
    printf "${bldyellow}clgal --wallet-url %s --url %s push action galaxy.token transfer [galaxy,%s,10000000.0000 SYS,vote] -p galaxy@active\\n${txtrst}"  "${wallet_url}" "${nodgal_url}" "${producer2}" 
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url push action galaxy.token transfer '["galaxy","'${producer2}'","20000000.0000 SYS","vote"]' -p galaxy@active   
    sleep 6
    printf "${bldyellow}clgal --wallet-url %s --url %s system voteproducer prods %s %s %s %s %s %s %s %s\\n${txtrst}" "${wallet_url}" "${nodgal_url}" "${producer2}" "${producer2}" "${producer3}" "${producer4}" "${producer5}" "${producer6}" "${producer7}" "${producer8}"
    docker exec $nodgalname1 /root/clgal/clgal --wallet-url $wallet_url --url $nodgal_url system voteproducer prods $producer2 $producer2 $producer3 $producer4 $producer5 $producer6 $producer7 $producer8 -p $producer2@active
    if [ $? -ne 0 ]; then
	      printf "${bldred}/***GALAXY****************** voteproducer %s error!!********************GALAXY***/\\n${txtrst}" "${producer2}"
		    exit 1;
    fi
    sleep 6
    
    printf "${bldgreen}/***GALAXY****************** voteproducer  end ... !!***********************GALAXY***/\\n${txtrst}"	
}

clear_data
create_network 
start_docker
exec_command

