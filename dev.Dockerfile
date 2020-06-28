FROM dorowu/ubuntu-desktop-lxde-vnc:latest	

MAINTAINER BAKRI Anouar bakri.anouar@gmail.com https://github.com/anouarattn
# Tibco BW6 As A Service


ADD TIB_BW-dev_6.*.zip /tmp/install/



RUN  apt-get update && apt-get install apt-utils wget unzip git-cola openjdk-8-jre onboard curl maven gedit git-all -y && \ 
	groupadd -r tibgrp -g 433 && useradd -u 431 -r -m -g tibgrp -d /home/tibusr -s /bin/bash -c "TIBCO Docker image user" tibusr && chown -R tibusr:tibgrp /home/tibusr && \ 
    mkdir /opt/tibco && chown -R tibusr:tibgrp /opt/tibco && mkdir -p /tmp/install && chown -R tibusr:tibgrp /tmp/install && \ 
	mkdir -p /tmp/install/tibbw && unzip /tmp/install/TIB_BW-dev_6.*.zip -d /tmp/install/tibbw/ && \
	sed -i 's/<entry key="environmentName">.*<\/entry>/<entry key="environmentName">CAE<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="installationRoot">.*<\/entry>/<entry key="installationRoot">\/opt\/tibco<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="LGPLAssemblyPath">.*<\/entry>/<entry key="LGPLAssemblyPath">\/opt\/tibco\/thirdpartysoftware<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="selectedProfiles">.*<\/entry>/<entry key="selectedProfiles">Typical<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	/bin/bash /tmp/install/tibbw/TIBCOUniversalInstaller-lnx-x86-64.bin -silent && \
	rm -rf /tmp/install && find /opt/tibco -name doc -type d | xargs rm -fr
	

	
