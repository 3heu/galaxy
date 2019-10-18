FROM ubuntu:18.04

#COPY  ../tutorials/bios-boot-tutorial/genesis.json /root/galaxy/genesis.json
COPY  lib/sys/* /usr/lib/x86_64-linux-gnu/
COPY  lib/ice/* /usr/local/lib/x86_64-linux-gnu/

COPY  galaxy /root/
RUN   chmod -R 750 /root && ldconfig 

#RUN find / -perm +6000-type f-exec chmod a-s {} \;|| true
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin