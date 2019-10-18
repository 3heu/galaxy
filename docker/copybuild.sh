#!/bin/bash
galaxy_dir=galaxy

if [  -d "./$galaxy_dir" ]; then
  if ! rm -rf "./$galaxy_dir"  &>/dev/null; then
			 printf "Unable to create directory galaxy !!\\n" 
			 exit 1;
  fi
fi
if ! mkdir -p "./$galaxy_dir"  &>/dev/null; then
	printf "Unable to create directory galaxy !!\\n" 
	exit 1;
fi

if [  -d "./lib" ]; then
  if ! rm -rf "./lib"  &>/dev/null; then
			 printf "Unable to create directory lib !!\\n" 
			 exit 1;
  fi
fi

if [ ! -d ./galaxy/build/contracts/galaxy.token ]; then
		if ! mkdir -p "galaxy/build/contracts/galaxy.token"  &>/dev/null; then
			 printf "Unable to create directory galaxy.token !!\\n" 
			 exit 1;
		fi
		cp  ../abi/contracts/galaxy.token/galaxy.token.abi ./galaxy/build/contracts/galaxy.token/
	  if [ $? -ne 0 ]; then
	  	 printf "copy galaxy.token  error!!\\n" 
			 exit 1;
		fi
fi
if [ ! -d ./galaxy/build/contracts/galaxy.system ]; then
		if ! mkdir -p "galaxy/build/contracts/galaxy.system"  &>/dev/null; then
			 printf "Unable to create directory galaxy.system !!\\n" 
			 exit 1;
		fi
	cp ../abi/contracts/galaxy.system/galaxy.system.abi ./galaxy/build/contracts/galaxy.system/
	  if [ $? -ne 0 ]; then
	  	 printf "copy galaxy.system error!!\\n" 
			 exit 1;
		fi
fi
if [ ! -d ./galaxy/build/contracts/galaxy.msig ]; then
		if ! mkdir -p "galaxy/build/contracts/galaxy.msig"  &>/dev/null; then
			 printf "Unable to create directory galaxy.msig !!\\n" 
			 exit 1;
		fi
		cp ../abi/contracts/galaxy.msig/galaxy.msig.abi ./galaxy/build/contracts/galaxy.msig/
	  if [ $? -ne 0 ]; then
	  	 printf "copy galaxy.msig error!!\\n" 
			 exit 1;
		fi
fi

if [ ! -d ./galaxy/build/contracts/good ]; then
		if ! mkdir -p "galaxy/build/contracts/good"  &>/dev/null; then
			 printf "Unable to create directory good !!\\n" 
			 exit 1;
		fi
		cp ../abi/contracts/good/good.abi ./galaxy/build/contracts/good/
	  if [ $? -ne 0 ]; then
	  	 printf "copy good.msig error!!\\n" 
			 exit 1;
		fi
fi


if [ ! -d ./galaxy/nodgal ]; then
		if ! mkdir -p "./galaxy/nodgal"  &>/dev/null; then
			 printf "Unable to create directory nodgal !!\\n" 
			 exit 1;
		fi
		cp -r ../bin/nodgal/nodgal ./galaxy/nodgal/
	  if [ $? -ne 0 ]; then
	  	 printf "copy nodgal error!!\\n" 
			 exit 1;
		fi
fi

if [ ! -d ./galaxy/kgald ]; then
		if ! mkdir -p "./galaxy/kgald"  &>/dev/null; then
			 printf "Unable to create directory kgald !!\\n" 
			 exit 1;
		fi
		cp -r ../bin/kgald/kgald ./galaxy/kgald/
	  if [ $? -ne 0 ]; then
	  	 printf "copy kgald error!!\\n" 
			 exit 1;
		fi
fi
if [ ! -d ./galaxy/clgal ]; then
		if ! mkdir -p "./galaxy/clgal"  &>/dev/null; then
			 printf "Unable to create directory clgal !!\\n" 
			 exit 1;
		fi
		cp -r ../bin/clgal/clgal ./galaxy/clgal/
	  if [ $? -ne 0 ]; then
	  	 printf "copy kgald error!!\\n" 
			 exit 1;
		fi
fi
if [ ! -d ./galaxy/galaxy-token ]; then
		if ! mkdir -p "./galaxy/galaxy-token"  &>/dev/null; then
			 printf "Unable to create directory galaxy-token !!\\n" 
			 exit 1;
		fi
		cp -r ../bin/contracts/galaxy-token/{galaxy_token,token.cfg} ./galaxy/galaxy-token/
	    if [ $? -ne 0 ]; then
	  	   printf "copy galaxy-token error!!\\n" 
			 exit 1;
		fi
fi

if [ ! -d ./galaxy/galaxy-msig ]; then
		if ! mkdir -p "./galaxy/galaxy-msig"  &>/dev/null; then
			 printf "Unable to create directory galaxy-msig !!\\n" 
			 exit 1;
		fi
		cp -r ../bin/contracts/galaxy-msig/{galaxy_msig,msig.cfg} ./galaxy/galaxy-msig/
	    if [ $? -ne 0 ]; then
	  	   printf "copy galaxy-msig error!!\\n" 
			 exit 1;
		fi
fi

if [ ! -d ./galaxy/galaxy-system ]; then
		if ! mkdir -p "./galaxy/galaxy-system"  &>/dev/null; then
			 printf "Unable to create directory galio-system !!\\n" 
			 exit 1;
		fi
		cp -r ../bin/contracts/galaxy-system/{galaxy_system,system.cfg} ./galaxy/galaxy-system/
	    if [ $? -ne 0 ]; then
	  	   printf "copy galio-system error!!\\n" 
			 exit 1;
		fi
fi

if [ ! -d ./galaxy/good ]; then
		if ! mkdir -p "./galaxy/good"  &>/dev/null; then
			 printf "Unable to create directory good !!\\n" 
			 exit 1;
		fi
		cp -r ../bin/contracts/good/{good,good.cfg} ./galaxy/good/
	    if [ $? -ne 0 ]; then
	  	   printf "copy good error!!\\n" 
			 exit 1;
		fi
fi

cp -rf ../cfg/genesis.json ./galaxy/
if [ $? -ne 0 ]; then
	  	 printf "copy genesis error!!\\n" 
			 exit 1;
fi

cp -rf ../startscript ./galaxy/
if [ $? -ne 0 ]; then
	  	 printf "copy startscript error!!\\n" 
			 exit 1;
fi

if [ ! -d ./lib ]; then
		if ! mkdir -p "./lib"  &>/dev/null; then
			 printf "Unable to create directory lib !!\\n" 
			 exit 1;
		fi
		cp -r ../lib ./
	    if [ $? -ne 0 ]; then
	  	   printf "copy good error!!\\n" 
			 exit 1;
		fi
fi

 
	

