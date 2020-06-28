FROM ubuntu:18.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes
ADD TIB_BW-dev_6.*.zip /tmp/install/

RUN apt-get update \
&& apt-get install -y --no-install-recommends ca-certificates curl jq git iputils-ping libcurl4 libicu60 libunwind8 netcat apt-utils wget unzip openjdk-8-jdk curl maven git-all sudo python3 python3-pip

RUN pip3 install fabric xmltodict xmlschema

WORKDIR /azp

ADD start.sh /opt/tibco/start.sh
RUN chmod +x /opt/tibco/start.sh


RUN groupadd -r tibgrp -g 433 && useradd -u 431 -r -m -g tibgrp -d /home/tibusr -s /bin/bash -c "Tibco user" tibusr  && mkdir -p /opt/tibco && chown -R tibusr:tibgrp /home/tibusr && \ 
    chown -R tibusr:tibgrp /opt/tibco && mkdir /home/tibusr/tibco-conf  && \
	mkdir -p /tmp/install/tibbw && unzip /tmp/install/TIB_BW-dev_6.*.zip -d /tmp/install/tibbw/ && chown -R tibusr:tibgrp /tmp/install


RUN sed -i 's/<entry key="environmentName">.*<\/entry>/<entry key="environmentName">CAE<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="installationRoot">.*<\/entry>/<entry key="installationRoot">\/opt\/tibco<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="LGPLAssemblyPath">.*<\/entry>/<entry key="LGPLAssemblyPath">\/opt\/tibco\/thirdpartysoftware<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="selectedProfiles">.*<\/entry>/<entry key="selectedProfiles">Typical<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	sed -i 's/<entry key="configDirectoryRoot">.*<\/entry>/<entry key="configDirectoryRoot">\/home\/tibusr<\/entry>/g' /tmp/install/tibbw/TIBCOUniversalInstaller_BW-dev_6.5.*.silent && \
	/tmp/install/tibbw/TIBCOUniversalInstaller-lnx-x86-64.bin -silent  && \
	rm -rf /tmp/install && find /opt/tibco -name doc -type d | xargs rm -fr

CMD ["/opt/tibco/start.sh"]