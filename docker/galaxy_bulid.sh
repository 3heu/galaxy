#!/bin/bash

image_name=galaxy
image_version=1.0.1

clearimage()
{
    #get images 
    version_id=`docker images | grep $image_name | awk '{print $2}'`
    if [ "$version_id" == "$image_version" ]; then
       image_id=`docker images | grep $image_name | awk '{print $3}'`
       if [ -n "$image_id" ]; then
          docker rmi $image_id
          if [ $? -ne 0 ]; then
	          printf "delete old docker images error!!\\n"
		        exit 1;
          fi
          printf "delete old docker images!!\\n"
       fi
    fi	
}

clear_data()
{
    if [  -d "./galaxy" ]; then
      if ! rm -rf "./galaxy"  &>/dev/null; then
			 printf "Unable to remove directory galaxy !!\\n" 
			 exit 1;
      fi
    fi
    if [  -d "./lib" ]; then
      if ! rm -rf "./lib"  &>/dev/null; then
			 printf "Unable to remove lib galaxy !!\\n" 
			 exit 1;
      fi
   fi
   
    
    
}
copy_file()
{
	  if [ -f copybuild.sh ]; then
        ./copybuild.sh
       printf "copy config file Successfully!!\\n" 
    else
       printf "the config file is not exist!!\\n"	
       exit 1;
    fi
}

build_images()
{
    docker build . -t $image_name:$image_version
    if [ $? -ne 0 ]; then
	      printf "build docker image error!!\\n"	 
		    exit 1;
    fi
}

clearimage
copy_file
build_images
clear_data

