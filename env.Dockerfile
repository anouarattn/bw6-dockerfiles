FROM debian:stretch

MAINTAINER BAKRI Anouar bakri.anouar@gmail.com https://github.com/anouarattn
# base

ADD TIB_BW-dev_6.*.zip /tmp/install/


RUN apt-get update && apt-get install apt-utils wget unzip openjdk-8-jdk curl maven git-all sudo python3 python3-pip -y

RUN pip3 install fabric xmltodict xmlschema

RUN groupadd -r tibgrp -g 433 && useradd -u 431 -r -m -g tibgrp -d /home/tibusr -s /bin/bash -c "Tibco user" tibusr  && chown -R tibusr:tibgrp /home/tibusr && \ 
    chown -R tibusr:tibgrp /opt/tibco && mkdir /home/tibusr/tibco-conf  && \
	mkdir -p /tmp/install/tibbw && unzip /tmp/install/TIB_BW-dev_6.*.zip -d /tmp/install/tibbw/ && chown -R tibusr:tibgrp /tmp/install

USER tibusr

ADD bootstrapper.sh /opt/tibco/bootstrapper.sh
chmod +x /opt/tibco/bootstrapper.sh

RUN sed -i 's/<entry key="environmentName">.*<\/entry>/<entry key="environmentName">CAE<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="installationRoot">.*<\/entry>/<entry key="installationRoot">\/opt\/tibco<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="LGPLAssemblyPath">.*<\/entry>/<entry key="LGPLAssemblyPath">\/opt\/tibco\/thirdpartysoftware<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="selectedProfiles">.*<\/entry>/<entry key="selectedProfiles">Typical<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="configDirectoryRoot">.*<\/entry>/<entry key="configDirectoryRoot">\/home\/tibusr<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	/tmp/install/tibbw/TIBCOUniversalInstaller-lnx-x86-64.bin -silent  && \
	rm -rf /tmp/install && find /opt/tibco -name doc -type d | xargs rm -fr
	
CMD ["/opt/tibco/bootstrapper.sh"]
